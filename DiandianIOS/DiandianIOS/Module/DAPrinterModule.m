//
//  DAPrinterModule.m
//  DiandianIOS
//
//  Created by Antony on 13-12-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAPrinterModule.h"

@implementation DAPrinterModule

-(void)getPrinterById:(NSString *)printerId callback:(void (^)(NSError *err, DAPrinter *obj))callback
{
    NSString *path = [NSString stringWithFormat:API_PRINTER_GET,printerId];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPrinter alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void)getPrinterList:(void (^)(NSError *err, DAPrinterList *obj))callback
{
    NSString *path = [NSString stringWithFormat:API_PRINTER_LIST];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPrinterList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}


@end
