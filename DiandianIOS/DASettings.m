//
//  DACommon.m
//  Report
//
//  Created by 李 林 on 12/05/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DASettings.h"

// CCC対応
//#import "DALogin.h"

@implementation DASettings

#pragma mark - NSUserDefaults functions

// 設定パネルの値をユーザディフォルトにコピー
+ (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        _prints(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        NSString *val = [prefSpecification objectForKey:@"DefaultValue"];
        if(key && val) {
            [defaultsToRegister setObject:val forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

// 設定パネルの設定値を取得（読み取りのみ）
+ (NSString *)settingValue:(NSString *) key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:key];
}

// サーバーのアドレスを取得
+ (NSString *)serverAddress {
    return [self settingValue:kSettingAddress];
}

// ユーザのファイル保存場所を取得
+ (NSString *) fullPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *newFileName = [fileName stringByReplacingOccurrencesOfString:@":" withString:@""];
    return [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], newFileName];
}

@end
