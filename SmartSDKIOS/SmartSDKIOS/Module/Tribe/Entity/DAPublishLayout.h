//
//  DAPublishLayout.h
//  TribeSDK
//
//  Created by kita on 13-8-31.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"
#import "DALayout.h"

@interface DAPublishLayout : Jastor<NSCoding>
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) DALayout *active;
@property (retain, nonatomic) NSNumber *valid;


@end
