//
//  DAFile.m
//  tribe
//
//  Created by kita on 13-4-13.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAFile.h"

@implementation FileMetadata
@synthesize author,tags;
@end

@implementation DAFile
@synthesize _id,downloadId,extension,filename,chunkSize,contentType,length,uploadDate,owner,history,metadata;
+(Class) history_class {
    return [NSString class];
}
@end
