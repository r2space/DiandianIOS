//
//  DAItemListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-12-23.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAItemListViewController.h"
#import "TMCache.h"
#import "DAMenuProxy.h"
#import "ProgressHUD.h"
#import "DASoldButton.h"
#import "ProgressHUD.h"




@interface DAItemListViewController ()<UIScrollViewDelegate>
{
    DAItemList *dataList;
    int start;
    int count;
    NSString *keyword;
    NSString *tag;
    NSString *soldoutType;
    UIRefreshControl    *refresh;   // 下拉Table时显示的控件

}
@end

@implementation DAItemListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(handler) forControlEvents:UIControlEventValueChanged];
    refresh.tintColor = [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.tableView addSubview:refresh];
    // Do any additional setup after loading the view from its nib.
    start = 0;
    count = 20;
    keyword = @"";
    tag = [[NSString alloc ]init];
    soldoutType = @"0";
    UINib *cellNib = [UINib nibWithNibName:@"DAItemListCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAItemListCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(noticeReload:)
                                                 name:@"DAItemListReload" object:nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

- (void)noticeReload:(NSNotification *)notification {
    NSMutableArray *tmpObject = [notification object];
    NSMutableString *tmpTag = [[NSMutableString alloc]init];
    for (int i = 0 ;i <[tmpObject count] ;i++) {
        if (i != 0) {
            [tmpTag appendString: @","];
        }
        [tmpTag appendString: [tmpObject objectAtIndex:i]];
    }
    
    
    tag = [NSString stringWithFormat:@"%@",tmpTag];
    [self loadFromApi:YES];
}

- (void) handler
{
    NSLog(@"refreshed");
    [refresh endRefreshing];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    start = 0;
    [self loadFromApi:NO];
}

- (void)loadFromApi:(BOOL)reload
{
    [ProgressHUD show:@"正在努力为你加载。。。"];
    if (reload) {
        dataList = nil;
        start = 0 ;
    }
    
    [[DAItemModule alloc] getItemList:start count:count keyword:keyword tag:tag soldoutType:soldoutType callback:^(NSError *err, DAItemList *list)
     {
         // 保存数据
         
         if (dataList == nil || start == 0) {
             dataList = list;
             
                 NSNotification *tagsNotification = [NSNotification notificationWithName:@"TagsReload" object:dataList.tags];
                 
                 [[NSNotificationCenter defaultCenter] postNotification:tagsNotification];
             
             
         } else {
             dataList.items = [dataList.items arrayByAddingObjectsFromArray:list.items];
         }
         
         
         [self.tableView reloadData];
         [ProgressHUD dismiss];
     }];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFromApi:YES];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (maximumOffset - currentOffset <= -40) {
        [((UIActivityIndicatorView *)self.tableView.tableFooterView) startAnimating];
        
        start += count;
        [self loadFromApi:NO];
    }
}
-(void)addSoldOut :(DASoldButton *)sender
{
    [ProgressHUD show:@"稍等。。。"];
    NSLog(@"itemId : %@" ,sender.itemId);
    NSLog(@"label  %@" , [sender titleForState:UIControlStateNormal]);
    NSString *titleLabel = [sender titleForState:UIControlStateNormal];
    if ([titleLabel isEqualToString:@"售罄"]) {
        [[DAItemModule alloc ] addSoldOut:sender.itemId callback:^(NSError *err, DASoldout *object) {
            [ProgressHUD show:@"添加成功"];
            NSString *title = @"取消售罄";

            [sender setTitle:title forState:UIControlStateNormal];
            [sender setTitle:title forState:UIControlStateHighlighted];
            [sender setTitle:title forState:UIControlStateDisabled];
        }];
        
    } else {
        [[DAItemModule alloc ] removeSoldOut:sender.itemId callback:^(NSError *err, NSDictionary *object) {
            [ProgressHUD show:@"取消成功"];
            NSString *title = @"售罄";
            
            [sender setTitle:title forState:UIControlStateNormal];
            [sender setTitle:title forState:UIControlStateHighlighted];
            [sender setTitle:title forState:UIControlStateDisabled];
        }];
    }
    [self loadFromApi:YES];

}

-(void)deleteSoldOut :(DASoldButton *)sender
{
    [ProgressHUD show:@"稍等。。。"];

    NSLog(@"itemId : %@" ,sender.itemId);

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAItemListCell" forIndexPath:indexPath];
    DAItem *item = [dataList.items objectAtIndex:indexPath.row];
    UILabel     *labelName  = (UILabel *)[cell viewWithTag:10];
    UIImageView *imageView  = (UIImageView *)[cell viewWithTag:11];
    
    UILabel     *labelAmount= (UILabel *)[cell viewWithTag:13];
    DASoldButton    *btnSoldout = (DASoldButton *)[cell viewWithTag:14];
    btnSoldout.itemId = item._id;
    NSLog(@"售罄 status ： %@ ", item.soldout);
    NSString *title = @"";
    if ([item.soldout isEqualToNumber:[NSNumber numberWithInt:1]]) {

        title = @"售罄";
        [btnSoldout setTitle:title forState:UIControlStateNormal];
        [btnSoldout setTitle:title forState:UIControlStateHighlighted];
        [btnSoldout setTitle:title forState:UIControlStateDisabled];
        [btnSoldout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
    } else {
        
        title = @"取消售罄";
        [btnSoldout setTitle:title forState:UIControlStateNormal];
        [btnSoldout setTitle:title forState:UIControlStateHighlighted];
        [btnSoldout setTitle:title forState:UIControlStateDisabled];
        [btnSoldout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       
    }
    [btnSoldout addTarget:self
                   action:@selector(addSoldOut:) forControlEvents:UIControlEventTouchUpInside];
    
    labelName.text = item.itemName;
    labelAmount.text = [NSString stringWithFormat:@"%@",item.amount];
    [imageView setImage:nil];
    UIImage *image = [DAMenuProxy getImageFromDisk:item.smallimage];
    if (image) {

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"cacheed");
            [imageView setImage:image];
        });
    } else {
        NSString *urlString = [DAMenuProxy resourceURLString:item.smallimage];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
        [req setValue:@"Application/octet-stream" forHTTPHeaderField:@"Accept"];
        [req setHTTPMethod:@"GET"];

        [NSURLConnection sendAsynchronousRequest:req
                                         queue:[NSOperationQueue mainQueue]
                             completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                 if( data != nil ){
                                     NSString *saveImageName = item.smallimage;
                                     NSString *path = [DAMenuProxy imagePath:saveImageName];
                                     [data writeToFile:path atomically:YES];
                                    UIImage *image = [DAMenuProxy getImageFromDisk:item.smallimage];
                                     [imageView setImage:image];
                                     
                                 }else{
                                     NSLog(@" download fail!!! save image - %@", item.smallimage );
                                 }
                             }];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    keyword = searchBar.text;
    [self loadFromApi:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    keyword = @"";
    [self loadFromApi:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (IBAction)onChangeSoldoutType:(UISegmentedControl *)sender {
    NSLog(@"选择售罄 ：%d"  , sender.selectedSegmentIndex );
    soldoutType = [NSString stringWithFormat:@"%d",sender.selectedSegmentIndex];
    [self loadFromApi:YES];
}

@end
