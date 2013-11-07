//
//  DAFile.h
//  tribe
//
//  Created by kita on 13-4-13.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "Jastor.h"

@interface FileMetadata : Jastor
@property(retain, nonatomic) NSString *author;
@property(retain, nonatomic) NSString *tags;
@end

@interface DAFile : Jastor
@property(retain, nonatomic) NSString* _id;
@property(retain, nonatomic) NSString* downloadId;
@property(retain, nonatomic) NSString *extension;
@property(retain, nonatomic) NSString *filename;
@property(retain, nonatomic) NSNumber *chunkSize;
@property(retain, nonatomic) NSString *contentType;
@property(retain, nonatomic) NSNumber *length;
@property(retain, nonatomic) NSString *uploadDate;
@property(retain, nonatomic) NSString *owner;
@property(retain, nonatomic) NSArray *history;
@property(retain, nonatomic) FileMetadata *metadata;
@end
