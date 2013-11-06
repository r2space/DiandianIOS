//
//  DAMyMenuBookViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSGridView.h"
#import "DABookCell.h"

typedef enum {
    MenuBookList    = 0,
    MenuBookDetail  = 1
} MenuBookType;

@interface DAMyMenuBookViewController : UIViewController<MSGridViewDataSource,MSGridViewDelegate>


@end
