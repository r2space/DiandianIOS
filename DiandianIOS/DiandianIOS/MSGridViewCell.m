//
//  MSGridViewCell.m
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 TBC Digital. All rights reserved.
//

#import "MSGridViewCell.h"
#import "MSGridView.h"
#import "DABookCell.h"
@interface MSGridViewCell()
{
    BOOL touching;
}
@end

@implementation MSGridViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier menuData:(DAMenuModule *)menuData
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.reuseIdentifier = identifier;
        self.menuData = menuData;
        UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 160, 120)];
        [imageView setImage:[UIImage imageNamed:@"cai_2.png"]];
        [self addSubview:imageView];
        UILabel *bookName = [[UILabel alloc]initWithFrame:CGRectMake(4, 130, 100, 30)];
        UILabel *bookPrice = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 100, 30)];

        UIButton *bookDetail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIButton *bookOrder = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bookDetail.frame = CGRectMake(130, 160, 100, 30);
        bookOrder.frame = CGRectMake(40, 160, 100, 30);
        
        bookName.text = self.menuData.name;
        bookPrice.text = @"100元/盘";
        [bookDetail setTitle:@"详细" forState:UIControlStateNormal];
        [bookOrder setTitle:@"预定" forState:UIControlStateNormal];
        [bookDetail addTarget:self action:@selector(bookDetailTouch:) forControlEvents:UIControlEventTouchUpInside];
        [bookOrder addTarget:self action:@selector(bookOrderTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bookName];
        [self addSubview:bookPrice];
        [self addSubview:bookDetail];
        [self addSubview:bookOrder];
        
        
        
    }
    return self;
}

-(void) bookDetailTouch:(id)sender
{
    NSLog(@"Detail");
}

-(void) bookOrderTouch:(id)sender
{
    NSLog(@"Order");
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setFrame:CGRectMake(contentbuffer, contentbuffer, self.frame.size.width-contentbuffer*2, self.frame.size.height-contentbuffer*2)];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touching = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touching && [touches count] == 1) {
        UITouch *t = [touches anyObject];
        CGPoint p = [t locationInView:self];
        if(CGRectContainsPoint(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), p)) {
            
            
            NSIndexPath *ip = [(MSGridView *)self.superview indexPathForCell:self];
            
            if([[(MSGridView *)self.superview gridViewDelegate]respondsToSelector:@selector(didSelectCellWithIndexPath:)]) {
                
                [[(MSGridView *)self.superview gridViewDelegate] didSelectCellWithIndexPath:ip];
                
            }
        }
    }
    touching = NO;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    touching = NO;
}


@end
