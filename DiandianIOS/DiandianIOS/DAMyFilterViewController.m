//
//  DAMyFilterViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyFilterViewController.h"
#import "CCSegmentedControl.h"
#import "SmartSDK.h"

@interface DAMyFilterViewController ()
{
    NSMutableArray *elements;
    DAMenuList *menuList;
    CCSegmentedControl* segmentedControl;
}
@end

@implementation DAMyFilterViewController

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
    elements = [[NSMutableArray alloc] init];
    
    
    
    
    [self loadFromDisk];
    // Do any additional setup after loading the view from its nib.
    segmentedControl = [[CCSegmentedControl alloc] initWithItems:elements];
    segmentedControl.frame = CGRectMake(0, 0, 774, 67);
    
    //设置背景图片，或者设置颜色，或者使用默认白色外观
    //segmentedControl.backgroundImage = [UIImage imageNamed:@"menubook_top.png"];
    segmentedControl.backgroundColor = [UIColor clearColor];
    
    //阴影部分图片，不设置使用默认椭圆外观的stain
    UIImageView *stainView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bg3.png"]];
//    stainView.layer.cornerRadius = 3;
//    stainView.layer.masksToBounds = YES;
    
    segmentedControl.selectedStainView = stainView;
    
    segmentedControl.selectedSegmentTextColor = [self colorWithHexString:@"#000000"];
    segmentedControl.segmentTextColor = [self colorWithHexString:@"#FFFFFF"];
    
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segmentedControlReload:) name:@"segmentedControlReload" object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearSearch:) name:@"QuickSearchRes" object:nil];
}
- (void)clearSearch:(NSNotification *)sender
{
    self.searchTextField.text = @"";
    NSNotification *searchRequest = [NSNotification notificationWithName:@"QuickSearchRequest" object:@""];

    [[NSNotificationCenter defaultCenter] postNotification:searchRequest];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadFromDisk{
    
    menuList = [[DAMenuList alloc]unarchiveObjectWithFileWithName:FILE_MENU_LIST];
    
    for (DAMenu *aMenu in menuList.items){
        NSString *type =[NSString stringWithFormat:@"      %@      " ,aMenu.name];
        [elements addObject:type];
    }
}

- (void)segmentedControlReload:(NSNotification
                                *)sender
{
    NSString *index = [sender object];
    segmentedControl.selectedSegmentIndex = [index integerValue];
}

- (void)valueChanged:(id)sender
{
    if(self.searchTextField.isFirstResponder){
        [self.searchTextField resignFirstResponder];
    }
    CCSegmentedControl* segmented = sender;
    NSString *index = [NSString stringWithFormat:@"%d",segmented.selectedSegmentIndex];
    
    
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"filterReload" object:index];
    
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}


- (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
- (IBAction)searchValueChanged:(id)sender {
    UITextField* text = (UITextField*)sender;
    NSLog(@"%@",text.text);

    NSNotification *searchRequest = [NSNotification notificationWithName:@"QuickSearchRequest" object:text.text];

    [[NSNotificationCenter defaultCenter] postNotification:searchRequest];
    
}

@end
