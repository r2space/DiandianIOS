//
//  DAJsonAPIUrl.h
//  tribe
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import <Foundation/Foundation.h>

// JSON API
/**
 * Notification Api
 */
#define urlGetNotificationList      @"/notification/list.json?type=%@&start=%d&limit=%d"
/*
* Message API
*/
#define urlGetMessageInTimeLine     @"/message/list/home.json?start=%d&count=%d&before=%@"
#define urlGetMessageInGroup        @"/message/list/group.json?start=%d&count=%d&gid=%@&before=%@"
#define urlGetMessageByUser         @"/message/list/user.json?start=%d&count=%d&uid=%@&before=%@"
#define urlGetReplyMeMessage        @"/message/list/comment.json?start=%d&count=%d"
#define urlGetAtMeMessage           @"/message/list/at.json?start=%d&count=%d"
#define urlCreateMessage            @"/message/create.json"
#define urlgetMessage               @"/message/get.json?mid=%@"
#define urlGetCommentInMessage      @"/message/list/reply.json?mid=%@&start=%d&count=%d"

//Message json ptah
#define jsonPathMessageList     @"data"
#define jsonPathMessage         @"data"
#define jsonPathCommentList     @"data"


/*
* User API
*/
#define urlGetUserList              @"/user/list.json?start=%d&count=%d"
#define urlGetUserFollowerList      @"/user/list.json?kind=follower&uid=%@&start=%d&count=%d"
#define urlGetUserFollowingList     @"/user/list.json?kind=following&uid=%@&start=%d&count=%d"


//User json path
#define jsonPathUserList @"data"


/*
* Group API
*/
#define urlGetGroupList @"/group/list.json"
#define urlGetGroupMember @"/group/members.json?gid=%@&start=%d&count=%d"

// Group json path
#define jsonPathGroupList @"data"

/*
* File API
*/
#define urlGetFileList @"/file/list.json?start=%d&count=%d"


//File json path
#define jsonPathFileList @"data"

/*
 * Picture API
 */
#define urlGetPicture @"/picture/%@"

@interface DAJsonAPIUrl : NSObject
// Notification
+(NSMutableURLRequest *) urlWithGetNotificationList:(int)start count:(int)count type:(NSString *)type;

// Message
+(NSMutableURLRequest *) urlWithGetMessagesInTimeLineStart:(int)start count:(int)count before:(NSString *)date;
+(NSMutableURLRequest *) urlWithGetMessagesInGroup:(NSString *)gid start:(int)start count:(int)count before:(NSString *)date;
+(NSMutableURLRequest *) urlWithGetMessagesByUser:(NSString *)uid start:(int)start count:(int)count before:(NSString *)date;
+(NSMutableURLRequest *) urlWithGetReplyMeMessagesStart:(int)start count:(int)count;
+(NSMutableURLRequest *) urlWithGetAtMeMessagesStart:(int)start count:(int)count;
+(NSMutableURLRequest *) urlWithPostMessage;
+(NSMutableURLRequest *) urlWithGetMessage:(NSString *)msgId;

+(NSMutableURLRequest *) urlWithGetCommentListInMessage:(NSString *)msgId start:(int)start count:(int)count;

// User
+(NSMutableURLRequest *) urlWithGetUserListStart:(int)start count:(int)count;
+(NSMutableURLRequest *) urlWithGetFollowerListByUser:(NSString *)userId start:(int)start count:(int)count;
+(NSMutableURLRequest *) urlWithGetFollowingListByUser:(NSString *)userId start:(int)start count:(int)count;

// Group
+(NSMutableURLRequest *) urlWithGetGroupList;
+(NSMutableURLRequest *) urlWithGetUserListInGroup:(NSString *)gid start:(int)start count:(int)count;

// File
+(NSMutableURLRequest *) urlWithGetFilesStart:(int)start count:(int)count;

// Picture
+(NSMutableURLRequest *) urlWithGetPicture:(NSString *)fileId;
@end
