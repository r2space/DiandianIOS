//
//  DAProcessionViewController.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAProcessionViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAProcessionViewCell.h"

@interface DAProcessionViewController ()

@end

@implementation DAProcessionViewController
{
    NSMutableArray *dataList;
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(UIViewController *) parentView
{
    DAProcessionViewController *vc = [[DAProcessionViewController alloc]initWithNibName:@"DAProcessionViewController" bundle:nil];
    vc.delegate = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    //parentVC = (id)parentView;
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

- (IBAction)addProcession:(id)sender {
}
- (IBAction)openMyTable:(id)sender {
}
- (IBAction)orderFool:(id)sender {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAProcessionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAProcessionViewCell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DAProcessionViewControll" owner:self options:nil];
        for(id c in topLevelObjects)
        {
            if ([c isKindOfClass:[UITableViewCell class]])
            {
                cell=(DAProcessionViewCell *) c;
                break;
            }
        }
    }
    
//    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
//    cell.imgGroup.image = [UIImage imageNamed:[row objectForKey:@"image"]];
//    cell.lblName.text = [row objectForKey:@"name"];
//    cell.lblProcess.text = [row objectForKey:@"process"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
@end
