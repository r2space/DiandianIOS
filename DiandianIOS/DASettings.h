//
//  DACommon.h
//  Report
//
//  Created by 李 林 on 12/05/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DASettings : NSObject

// バインダ詳細
//////////////////////////////////////////////////////////////////////////////////////
#define kBinderTitle        @"binder_title_preference"          // タイトル
#define kBinderCategory     @"binder_category_preference"       // カテゴリ
#define kBinderFile         @"binder_file_preference"           // ファイル
#define kBinderUploadUrl    @"binder_upload_url_preference"     // アップロードURL
#define kBinderUrl          @"binder_url_preference"            // 文書URL
#define kBinderSessionUrl   @"binder_session_url_preference"    // セッションURL
#define kBinderVisible      @"binder_visible_preference"        // 文書表示ステータス

// アプリ定義バインダ
#define kAppsDefinitionBinderId     @"apps_definition_binder_id_preference"
#define kAppsDefinitionViewId       @"apps_definition_view_id_preference"

// バインダ
#define kBinderKey                  @"binder_id_preference"
#define kViewName                   @"binder_view_id_preference"

// サーバ
#define kSettingAddress             @"address_preference"

// ログ関連
//////////////////////////////////////////////////////////////////////////////////////
#define _prints(str)        NSLog(@"### [%@:(%d):%p] %@", \
                            [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
                            __LINE__, \
                            self, \
                            str)
#define _printf(str, ...)   NSLog(@"### [%@:(%d):%p] %@", \
                            [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
                            __LINE__, \
                            self, \
                            [NSString stringWithFormat:(str), ##__VA_ARGS__])


// 設定情報アクセス用
+ (void)registerDefaultsFromSettingsBundle;
+ (NSString *)settingValue:(NSString *)key;
+ (NSString *)serverAddress;

// その他
+ (NSString *)fullPath:(NSString *)fileName;

@end
