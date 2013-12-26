//
//  DAEntity.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "Jastor.h"

@interface DAEntity : Jastor<NSCoding>

@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) NSString *editby;

@property (retain, nonatomic) NSNumber  *valid;

@property (retain, nonatomic) NSNumber *_status;
@property (retain, nonatomic) NSString *_error;


-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

-(BOOL ) archiveRootObjectWithName :(NSString *) withName;
-(BOOL ) archiveRootObjectWithPath:(NSString *) withPath withName :(NSString *)withName;
-(id ) unarchiveObjectWithFileWithName :(NSString *) withName;
-(id ) unarchiveObjectWithFileWithPath:(NSString *) withPath withName :(NSString *)withName;


@end
