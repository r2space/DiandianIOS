//
//  DAFileModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAFileList.h"
#import "DAFile.h"
#import "DAFileDetail.h"
#import "DAFileHistory.h"

@interface DAFileModule : NSObject


- (void)getFileList:(int)start count:(int)count type:(NSString *)type callback:(void (^)(NSError *error, DAFileList *files))callback;

- (void)uploadPicture:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType callback:(void (^)(NSError *error, DAFile *files))callback progress:(void (^)(CGFloat percent))progress;

- (void)uploadFile:(NSData *)data
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
          callback:(void (^)(NSError *error, DAFileList *files))callback
          progress:(void (^)(CGFloat percent))progress;

- (void) getFileDetail :(NSString *)fid callback:(void (^)(NSError *error, DAFileDetail *file))callback;

- (void) getFileHistory :(NSString *)fid callback:(void (^) (NSError *error, DAFileHistory *histroy))callback;

- (void)getPicture:(NSString *)pictureId callback:(void (^)(NSError *, NSString *))callback;

- (void)downloadFile:(NSString *)fileId ext:(NSString *)ext callback:(void (^)(NSError *, NSString *))callback progress:(void (^)(CGFloat percent))progress;

@end
