//
//  DAFileModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAFileModule.h"
#import "DAAFHttpOperation.h"

#define kURLFileHistory     @"/file/history_ios.json?fid=%@"

#define kURLFileDetail      @"/file/detail.json?fid=%@"
#define kURLFileList        @"/file/list.json?start=%d&count=%d&type=%@"
#define kURLUploadFile      @"/file/upload.json"
#define kURLGetPicture      @"/picture/%@"
#define kURLDownloadFile    @"/file/download.json?_id=%@"
#define kURLUploadPicture   @"/gridfs/save.json"

@implementation DAFileModule

- (void)getFileList:(int)start count:(int)count type:(NSString *)type callback:(void (^)(NSError *error, DAFileList *files))callback
{
    NSString *path = [NSString stringWithFormat:kURLFileList, start, count, type];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAFileList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)uploadPicture:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType callback:(void (^)(NSError *error, DAFile *files))callback progress:(void (^)(CGFloat percent))progress
{
    DAAFHttpClient *httpClient = [DAAFHttpClient sharedClient];
    
    // 添加formData到Request
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:kURLUploadPicture
                                                                   parameters:nil
                                                    constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                                                        
                                                        [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:mimeType];
                                                    }];
    
    // 设定上传进度block
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) {
            progress((CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite);
        }
    }];
    
    // 设定上传结束block
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if (callback) {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&jsonError];
            DAFileList *files = [[DAFileList alloc] initWithDictionary:[result objectForKey:@"data"]];
            
            callback(jsonError, [files.items objectAtIndex:0]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
    
    [httpClient enqueueHTTPRequestOperation:operation];
}

- (void)uploadFile:(NSData *)data
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
          callback:(void (^)(NSError *error, DAFileList *files))callback
          progress:(void (^)(CGFloat percent))progress
{
    DAAFHttpClient *httpClient = [DAAFHttpClient sharedClient];

    // 添加formData到Request
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:kURLUploadFile
                                                                   parameters:nil
                                                    constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                                                        
        [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:mimeType];
    }];

    // 设定上传进度block
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) {
            progress((CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite);
        }
    }];

    // 设定上传结束block
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if (callback) {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&jsonError];

            callback(jsonError, [[DAFileList alloc] initWithDictionary:[result valueForKeyPath:@"data"]]);
        }

    } failure:nil];
    
    [httpClient enqueueHTTPRequestOperation:operation];
}

- (void)getFileDetail:(NSString *)fid callback:(void (^)(NSError *, DAFileDetail *))callback
{
    NSString *path = [NSString stringWithFormat:kURLFileDetail, fid];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAFileDetail alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void) getFileHistory:(NSString *)fid callback:(void (^)(NSError *, DAFileHistory *))callback
{
    NSString *path = [NSString stringWithFormat:kURLFileHistory, fid];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAFileHistory alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];

}

- (void)getPicture:(NSString *)pictureId callback:(void (^)(NSError *, NSString *))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetPicture, pictureId];
    DAAFHttpOperation *daoperation = [[DAAFHttpOperation alloc] initWithRequestPath:path];
    
    [daoperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if (callback) {
            [DACommon dataToFile:responseObject fileName:pictureId];
            callback(nil, pictureId);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        if (callback) {
            callback(error, nil);
        }
    }];
    [daoperation start];
}

- (void)downloadFile:(NSString *)fileId ext:(NSString *)ext callback:(void (^)(NSError *, NSString *))callback progress:(void (^)(CGFloat percent))progress
{
    NSString *path = [NSString stringWithFormat:kURLDownloadFile, fileId];
    DAAFHttpOperation *daoperation = [[DAAFHttpOperation alloc] initWithRequestPath:path];
    
    // 设定下载进度block
    [daoperation setDownloadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) {
            progress((CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite);
        }
    }];
    
    [daoperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if (callback) {
            [DACommon dataToFile:responseObject fileName:[fileId stringByAppendingFormat:@".%@", ext]];
            callback(nil, fileId);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        if (callback) {
            callback(error, nil);
        }
    }];
    [daoperation start];
}

@end
