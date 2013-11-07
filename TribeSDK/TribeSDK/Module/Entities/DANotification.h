//
//  DANotification.h
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 Li Hao. All rights reserved.
//

#import "Jastor.h"
#import "DAUser.h"
#import "DAMessage.h"

@interface DANotification : Jastor

@property (retain, nonatomic) NSString  *_id;
@property (retain, nonatomic) DAUser    *user;
@property (retain, nonatomic) NSString  *content;
@property (retain, nonatomic) NSString  *createat;
@property (retain, nonatomic) NSString  *createby;
@property (retain, nonatomic) NSString  *objectid;
@property (retain, nonatomic) NSString  *type;
@property (retain, nonatomic) NSArray   *togroups;
@property (retain, nonatomic) NSArray   *tousers;
@property (retain, nonatomic) NSArray   *readers;
@property (retain, nonatomic) DAMessage *message;

@end


/*
{
    "apiVersion": "1.0",
    "data": {
        "total": 1,
        "items": [
                  {
                      "user": {
                          "photo": {},
                          "name": {
                              "letter_zh": " ",
                              "name_zh": "smart"
                          },
                          "_id": "51762882d85cec4122000030"
                      },
                      "__v": 0,
                      "_id": "517889415808c2820400000a",
                      "content": "lihao",
                      "createat": "2013-04-25T01:39:13.548Z",
                      "createby": "51762882d85cec4122000030",
                      "objectid": "517889415808c28204000009",
                      "type": "at",
                      "togroups": [],
                      "tousers": [
                                  "51762882d85cec4122000030"
                                  ],
                      "readers": [
                                  "51762882d85cec4122000030",
                                  "51762882d85cec4122000030"
                                  ]
                  }
                  ]
    }
}
*/