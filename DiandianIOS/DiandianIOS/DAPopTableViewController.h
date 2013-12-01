//
//  DAPopTableViewViewController.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/12/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DAPopTableViewDelegate<NSObject>
//@optional
- (void)popTableViewSelectRow:(NSString*) tag value:(id) value;
@end


@interface DAPopTableViewController : UITableViewController
@property (retain, nonatomic) NSString* cellType;
@property (assign, nonatomic) id <DAPopTableViewDelegate>delegate;

-(void)initData:(NSString*) tag list:(NSArray*) list;
@end

