//
//  SmartSDK.h
//  DiandianIOS
//
//  Created by Antony on 13-11-20.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#ifndef DiandianIOS_SmartSDK_h
#define DiandianIOS_SmartSDK_h


#define API_ALL_USER_LIST       @"/api/user/list.json"


#define API_MENU_LIST           @"/api/menu/list.json"
#define API_DESK_LIST           @"/api/desk/list.json"
#define API_SOLDOUT_ITEM_LIST   @"/api/soldout/list.json"
#define API_ITEM_LIST           @"/api/item/list.json?start=%d&count=%d&keyword=%@&soldoutType=%@"
#define API_TAG_LIST            @"/api/tag/list.json?count=100&start=0"

#define API_GET_TAKEOUT_SERVICELIST       @"/api/service/takeoutList.json"

#define API_START_SERVICE       @"/api/service/start.json"
#define API_CHANGE_SERVICE      @"/api/service/change.json"
#define API_GET_BILL            @"/api/bill/get.json?serviceId=%@"
#define API_STOP_BILL           @"/api/bill/stop.json"

#define API_ADD_SOLDOUT         @"/api/soldout/add.json"
#define API_REMOVE_SOLDOUT         @"/api/soldout/remove.json"
#define API_REMOVEALL_SOLDOUT         @"/api/soldout/removeAll.json"

#define API_ADD_SCHEDULE        @"/api/schedule/add.json"
#define API_REMOVE_SCHEDULE     @"/api/schedule/remove.json"
#define API_LIST_SCHEDULE       @"/api/schedule/list.json?start=%d&count=%d"


#define API_PRINTER_LIST            @"/api/printer/list.json"
#define API_PRINTER_GET             @"/api/printer/get.json?printerId=%@"
#define API_PRINTER_LOCK            @"/api/printer/lock.json?printerId=%@&operationType=%@&owner=%@"


#define API_ALL_ORDER_LIST  @"/api/order/list.json?start=%d&count=%d"


#define API_ALL_ORDER_ITEM_LIST  @"/api/order/itemList.json?type=%@&serviceId=%@"


#define API_ALL_ORDER_LIST_BY_BACK  @"/api/order/list.json?serviceId=%@&back=%@"
#define API_ALL_ORDER_LIST_BY_SERVICEID  @"/api/order/list.json?serviceId=%@"


#define API_ALL_ORDER_LIST_WITH_BACK  @"/api/order/list.json?serviceId=%@&back=%@"

#define API_ORDERS_DESK_BY_IDS(orderIds) \
[NSString stringWithFormat:@"/api/order/deskList.json?orderIds=%@&type=item",(orderIds)]

#define API_ORDERS_DESK_BY_TYPE(type) \
[NSString stringWithFormat:@"/api/order/deskList.json?type=%@",(type)]

#define API_SETORDER_DONE_BY_ID @"/api/order/doneOrder.json?orderId=%@"
#define API_SETORDER_DONE_BY_IDS @"/api/order/doneOrder.json?orderIds=%@"

#define API_SETORDER_BACK_BY_ID @"/api/order/backOrder.json?orderId=%@"

#define API_SETORDER_FREE @"/api/order/freeOrder.json"
#define API_SETORDER_BACK @"/api/order/backOrder.json"
#define API_ORDER_ADD       @"/api/order/add.json"
#define API_DEVICE_ADD  @"/api/device/add.json"

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
#import "DAUserModule.h"
#import "DAScheduleModule.h"
#import "DAPrinterModule.h"
#import "DAItemModule.h"


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
#import "DAUserList.h"
#import "DABill.h"
#import "DAServiceList.h"
#import "DASchedule.h"
#import "DAScheduleList.h"
#import "DAPrinter.h"
#import "DAPrinterList.h"
#import "DAItemList.h"
#import "DATag.h"
#import "DATagList.h"
#import "DASoldout.h"
#import "DASoldoutList.h"


#endif
