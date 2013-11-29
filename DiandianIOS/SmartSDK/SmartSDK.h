//
//  SmartSDK.h
//  DiandianIOS
//
//  Created by Antony on 13-11-20.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#ifndef DiandianIOS_SmartSDK_h
#define DiandianIOS_SmartSDK_h

#define API_MENU_LIST       @"/api/menu/list.json"
#define API_DESK_LIST       @"/api/desk/list.json"
#define API_START_SERVICE   @"/api/service/start.json"
#define API_ALL_ORDER_LIST  @"/api/order/list.json?start=%d&count=%d"
#define API_ALL_ORDER_LIST_BY_BACK  @"/api/order/list.json?start=%d&count=%d&back=%@"
#define API_ALL_ORDER_LIST_BY_SERVICEID  @"/api/order/list.json?serviceId=%@"

#define API_ALL_ORDER_LIST_WITH_BACK  @"/api/order/list.json?serviceId=%@&back=%@"

#define API_ORDERS_DESK_BY_IDS(orderIds) \
[NSString stringWithFormat:@"/api/order/deskList.json?orderIds=%@",(orderIds)]

#define API_SETORDER_DONE_BY_ID @"/api/order/doneOrder.json?orderId=%@"
#define API_SETORDER_BACK_BY_ID @"/api/order/backOrder.json?orderId=%@"
#define API_SETORDER_BACK @"/api/order/backOrder.json"
#define API_DEVICE_ADD @"/api/device/add.json"

#define API_UESR_UPDATEPATTERN @"/api/admin/user/updatePattern.json"
#define API_UESR_CHECKPATTERN @"/api/admin/user/checkPattern.json"

#define FILE_MENU_LIST @"___data_menu_list_"
#define FILE_DESK_LIST @"___data_desk_list_"

#define FILE_ORDER_LIST(deskId) \
[NSString stringWithFormat:@"data_%@_orderList",(deskId)]


#import "DAMenuModule.h"
#import "DALoginModule.h"
#import "DADeskModule.h"
#import "DAServiceModule.h"
#import "DAOrderModule.h"


#import "DAGroup.h"
#import "DAItem.h"

#import "DAUser.h"
#import "DAMenu.h"
#import "DAMenuList.h"
#import "DAMyTable.h"
#import "DAProcession.h"
#import "DATakeout.h"
#import "DADesk.h"
#import "DADeskList.h"
#import "DAService.h"
#import "DAOrder.h"
#import "DAMyOrderList.h"
#import "DAItemLayout.h"
#import "DAMyDevice.h"


#endif
