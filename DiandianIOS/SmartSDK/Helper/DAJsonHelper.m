//
//  DAJsonHelper.m
//  TribeSDK
//
//  Created by 李 林 on 2012/12/05.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAJsonHelper.h"
#import "DAMacros.h"

@implementation DAJsonHelper

/**
 * JSONを解析、NSDictionary＋NSArray階層に変換
 */
+ (NSDictionary *) decode:(NSData *) json
{
    _printf(@"json length : %d", (int)json.length);
    
    NSDictionary *result;
    if (json) {
        NSError *jsonError = nil;
        result = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&jsonError];
        
        if (jsonError) {
            _prints([jsonError description]);
        }
    }
    
    if (result == (NSDictionary *)[NSNull null]) {
        return nil;
    }
    
    return result;
}

/**
 * 階層化されたJSONの値をパスで取得、
 * 数値の場合は配列、文字列の場合はハッシュとして深堀します。
 * paht : data/imtes/0/id
 */
+ (id) objectAtPath:(id)json path:(NSString *)path
{
    NSArray *keys = [path componentsSeparatedByString:@"/"];
    
    id result = json;
    for (int i = 0; i < keys.count; i++) {
        
        NSString *key = [keys objectAtIndex:i];
        
        // 下位オブジェクトがない場合、そのまま終了する
        if (![result isKindOfClass:[NSArray class]] && ![result isKindOfClass:[NSDictionary class]]) {
            return result;
        }
        
        if ([self isNumeric:key]) {
            result = [((NSArray *)result) objectAtIndex:[key integerValue]];
        } else {
            result = [((NSDictionary *)result) objectForKey:key];
        }
        
        // 最後の階層まで、辿り着いた場合、ループを終了する
        if (i == keys.count - 1) {
            return result;
        }
    }
    
    return nil;
}

/**
 * 文字列が数値かチェック
 */
+ (BOOL) isNumeric:(NSString *)string
{
    NSScanner *sc = [NSScanner scannerWithString: string];
    
    // We can pass NULL because we don't actually need the value to test
    // for if the string is numeric. This is allowable.
    if ([sc scanFloat:nil]){
        // Ensure nothing left in scanner so that "42foo" is not accepted.
        // ("42" would be consumed by scanFloat above leaving "foo".)
        return [sc isAtEnd];
    }
    
    // Couldn't even scan a float :(
    return NO;
}

@end
