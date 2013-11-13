//
//  NSString+Util.h
//  PictureBook
//
//  Created by ドリームアーツ on 2012/11/21.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

+ (NSString *)stringWithValue:(NSNumber *)number;

// 文字列がnilまたは空文字か
+ (BOOL)isEmpty:(NSString *)str;

// 文字列がnil・空文字でない
+ (BOOL)isNotEmpty:(NSString *)str;

// 3桁区切りの数字取得
+ (NSString *)commaSeparatedNumber:(NSNumber *)number;

// 3桁区切りの数字取得（小数第一位まで表示）
+ (NSString *)commaSeparatedNumberWith1stDecimalPlace:(NSNumber *)number;

// 3桁区切りの数字取得（小数第二位まで表示）
+ (NSString *)commaSeparatedNumberWith2ndDecimalPlace:(NSNumber *)number;

// 金額表記「¥999,999,999」へ変換
+ (NSString *)stringWithYenKingakuFormat:(NSNumber *)kingaku;

// ファイルサイズ表記（GB単位まで。小数第一位まで表示。）
+ (NSString *)fileSizeFromNumberString:(NSString *)fileSize;

// 文字列から数値以外を除去
+ (NSString *)trimNonNumbersFromString:(NSString *)string;

@end
