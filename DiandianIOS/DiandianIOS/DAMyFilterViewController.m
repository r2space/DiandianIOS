//
//  DAMyFilterViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyFilterViewController.h"
#import "CCSegmentedControl.h"

@interface DAMyFilterViewController ()
{
    NSMutableArray *elements;
    
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
    CCSegmentedControl* segmentedControl = [[CCSegmentedControl alloc] initWithItems:elements];
    segmentedControl.frame = CGRectMake(0, 0, 700, 60);
    
    //设置背景图片，或者设置颜色，或者使用默认白色外观
    segmentedControl.backgroundImage = [UIImage imageNamed:@"segment_bg.png"];
    //segmentedControl.backgroundColor = [UIColor grayColor];
    
    //阴影部分图片，不设置使用默认椭圆外观的stain
    segmentedControl.selectedStainView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stain.png"]];
    
    segmentedControl.selectedSegmentTextColor = [UIColor whiteColor];
    segmentedControl.segmentTextColor = [self colorWithHexString:@"#535353"];
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

-(void)loadFromDisk{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"type" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *aModuleDict in parsedElements){
        NSString *type = [aModuleDict objectForKey:@"name"];
        [elements addObject:type];
    }
}


- (void)valueChanged:(id)sender
{
    CCSegmentedControl* segmentedControl = sender;
    NSLog(@"%s line:%d segment has changed to %d", __FUNCTION__, __LINE__, segmentedControl.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end