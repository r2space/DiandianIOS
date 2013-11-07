//
//  DAMessage.h
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "Jastor.h"
#import "DAUser.h"
#import "DAGroup.h"

#define message_contenttype_text        @"textBox"
#define message_contenttype_image       @"imageBox"
#define message_contenttype_file        @"fileBox"
#define message_contenttype_video       @"videoBox"
#define message_contenttype_document    @"documentBox"

@interface MessageAt : Jastor
@property (retain, nonatomic) NSArray *users;
@property (retain, nonatomic) NSArray *groups;
@end

@interface MessagePart : Jastor
@property (retain, nonatomic) NSNumber *forwardNums;
@property (retain, nonatomic) NSNumber *replyNums;
@property (retain, nonatomic) DAUser *createby;
@property (retain, nonatomic) DAGroup *range;
@property (retain, nonatomic) NSArray *atgroups;
@property (retain, nonatomic) NSArray *atusers;
@end

@interface MessageAttach : Jastor
@property (retain, nonatomic) NSString *fileid;
@property (retain, nonatomic) NSString *filename;
@property (retain, nonatomic) NSString *_id;
@end

@interface MessageThumb :Jastor
@property (retain, nonatomic) NSString *fileid;
@property (retain, nonatomic) NSNumber *width;
@property (retain, nonatomic) NSNumber *height;
@end

@interface DAMessage : Jastor

@property (retain, nonatomic) NSNumber *type;
@property (retain, nonatomic) NSString *content;
@property (retain, nonatomic) NSString *contentType;
@property (retain, nonatomic) NSString *range;
@property (retain, nonatomic) MessagePart *part;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) MessageAt *at;
@property (retain, nonatomic) NSArray *attach;
@property (retain, nonatomic) NSString *target;
@property (retain, nonatomic) MessageThumb *thumb;
@property (retain, nonatomic) NSArray *likers;

-(DAUser *) getCreatUser;
-(DAGroup *)getPublicRange;
-(NSNumber *) getForwardCount;
-(NSNumber *) getReplyCount;
-(NSString *) getAtString;
-(BOOL) hasAt;
@end
