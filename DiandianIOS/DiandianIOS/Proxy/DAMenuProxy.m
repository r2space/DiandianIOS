//
//  DAMenuProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMenuProxy.h"
#import "ProgressHUD.h"
#import "TMCache.h"


@implementation DAMenuProxy

+ (NSString *)resourceURLString:(NSString *)name {


    NSString *serverUrl = [DACommon getServerAddress];

    NSString *string = [[NSString alloc] initWithFormat:@"%@/picture/%@",
                                                        serverUrl,
                                                        name];

    return string;
}

+ (void)downloadImageImage:(NSArray *)imageIds iteration:(int)i {
    if (imageIds.count <= i) {

        NSNotification *n = [NSNotification notificationWithName:@"downloadDone" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:n];

        NSNotification *caseViewNotification = [NSNotification notificationWithName:@"settingReloaded" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:caseViewNotification];
        [ProgressHUD dismiss];
        return;
    }
    ProgressHUD *hub = [ProgressHUD shared];
    hub.label.text = [NSString stringWithFormat:@"图片%d", i];

    NSString *imageName = [imageIds objectAtIndex:i];

    NSString *urlString = [DAMenuProxy resourceURLString:imageName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:@"Application/octet-stream" forHTTPHeaderField:@"Accept"];
    [req setHTTPMethod:@"GET"];

    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (data != nil ) {
                                   NSString *saveImageName = imageName;
                                   NSString *path = [DAMenuProxy imagePath:saveImageName];
                                   [data writeToFile:path atomically:YES];
                                   UIImage *imageCache = [UIImage imageWithContentsOfFile:[DAMenuProxy imagePath:saveImageName]];

                                   [[TMCache sharedCache] setObject:imageCache forKey:saveImageName block:nil];

                                   //                                   NSLog(@" save image - %@ - path : %@ ", imageName, path );
                                   //                                   NSLog(@" save image %d / %d ", i, [images count]);
                                   NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[imageIds count]], @"count", [NSNumber numberWithInt:i], @"progress", nil];
                                   NSNotification *n = [NSNotification notificationWithName:@"downloadProgress" object:self userInfo:dic];
                                   [[NSNotificationCenter defaultCenter] postNotification:n];
                               } else {
                                   NSLog(@" download fail!!! save image - %@", imageName);
                               }

                               [DAMenuProxy downloadImageImage:imageIds iteration:(i + 1)];
                           }];
}

+ (NSArray *)getImageDownloadIds:(DAMenuList *)menuList {

//    NSMutableArray *tempList = [[NSMutableArray alloc]init];
//    for (DAMenu *menu in  menuList.items) {
//        for (NSDictionary *layoutDic in menu.items) {
//            DAItemLayout *layoutObj = [[DAItemLayout alloc ]initWithDictionary:layoutDic];
//            if (layoutObj.item !=nil) {
//                if (layoutObj.item.smallimage !=nil) {
//                    [tempList addObject:layoutObj.item.smallimage];
//                }
//                if (layoutObj.item.bigimage != nil) {
//                    [tempList addObject:layoutObj.item.bigimage];
//                }
//            }
//            
//        }
//    }
    return [[NSArray alloc] initWithArray:menuList.imageIds];
}


+ (void)getMenuListApiList {
    [ProgressHUD show:@"更新菜单中"];
    [[DAMenuModule alloc] getList:^(NSError *err, DAMenuList *list) {
        [list archiveRootObjectWithName:FILE_MENU_LIST];
        NSArray *imageIds = [self diffImageIds:[DAMenuProxy getImageDownloadIds:list]];
        [DAMenuProxy downloadImageImage:imageIds iteration:0];

    }];
}

+ (NSArray *)diffImageIds:(NSArray *)netIds {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];

    docDir = [docDir stringByAppendingPathComponent:@"menuImage"];
    NSError *error = nil;
//    NSArray *localIds = [[NSArray alloc] init];
    NSArray *localIds = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDir error:&error];
    if (error != nil) {
        return netIds;
    } else {

        NSMutableSet *netSet = [NSMutableSet setWithArray:netIds];
        NSSet *localSet = [NSSet setWithArray:localIds];
        [netSet minusSet:localSet];
        return [netSet allObjects];

    }

}

+ (UIImage *)getImageFromDisk:(NSString *)name {
    return [UIImage imageWithContentsOfFile:[DAMenuProxy imagePath:name]];
}

+ (NSString *)imagePath:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];

    docDir = [docDir stringByAppendingPathComponent:@"menuImage"];
    [DAMenuProxy createDir:docDir];

    // full path
    NSString *path = [docDir stringByAppendingPathComponent:name];
    return path;
}

+ (void)createDir:(NSString *)dirPath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:dirPath])
        return;

    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
}

@end
