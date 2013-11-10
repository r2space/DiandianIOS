//
//  DAJsonAPIUrl.m
//  tribe
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAJsonAPIUrl.h"
#import "DARequestHelper.h"



@implementation DAJsonAPIUrl
//Notification
+(NSMutableURLRequest *) urlWithGetNotificationList:(int)start count:(int)count type:(NSString *)type
{
    NSString *url = [NSString stringWithFormat:urlGetNotificationList, type, start, count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}
//Message
+(NSMutableURLRequest *) urlWithGetMessagesInTimeLineStart:(int)start count:(int)count before:(NSString *)date
{
    NSString *url = [NSString stringWithFormat:urlGetMessageInTimeLine, start, count, date];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithGetMessagesInGroup:(NSString *)gid start:(int)start count:(int)count before:(NSString *)date
{
    NSString *url = [NSString stringWithFormat:urlGetMessageInGroup,start,count,gid, date];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithGetMessagesByUser:(NSString *)uid start:(int)start count:(int)count before:(NSString *)date
{
    NSString *url = [NSString stringWithFormat:urlGetMessageByUser,start,count,uid,date];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithGetReplyMeMessagesStart:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetReplyMeMessage, start, count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithPostMessage
{
    NSString *url = [NSString stringWithFormat:urlCreateMessage];
    return [DARequestHelper httpRequest:url method:@"POST"];
}

+(NSMutableURLRequest *) urlWithGetMessage:(NSString *)msgId
{
    NSString *url = [NSString stringWithFormat:urlgetMessage,msgId];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithGetAtMeMessagesStart:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetAtMeMessage,start,count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithGetCommentListInMessage:(NSString *)msgId start:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetCommentInMessage,msgId,start,count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

//User
+(NSMutableURLRequest *) urlWithGetUserListStart:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetUserList,start,count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}
+(NSMutableURLRequest *) urlWithGetFollowerListByUser:(NSString *)userId start:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetUserFollowerList, userId, start, count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}
+(NSMutableURLRequest *) urlWithGetFollowingListByUser:(NSString *)userId start:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetUserFollowingList, userId, start, count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

//Group
+(NSMutableURLRequest *) urlWithGetGroupList
{
    NSString *url = [NSString stringWithFormat:urlGetGroupList];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

+(NSMutableURLRequest *) urlWithGetUserListInGroup:(NSString *)gid start:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetGroupMember,gid,start,count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

//File
+(NSMutableURLRequest *) urlWithGetFilesStart:(int)start count:(int)count
{
    NSString *url = [NSString stringWithFormat:urlGetFileList,start,count];
    return [DARequestHelper httpRequest:url method:@"GET"];
}

// Picture
+(NSMutableURLRequest *) urlWithGetPicture:(NSString *)fileId
{
    NSString *url = [NSString stringWithFormat:urlGetPicture,fileId];
    return [DARequestHelper httpRequest:url method:@"GET"];
}
@end
