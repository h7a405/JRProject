//
//  LoginWsImpl.h
//  HouseBank
//
//  Created by CSC on 14/12/1.
//  Copyright (c) 2014年 QCloud. All rights reserved.
//

#import "BaseWs.h"

//登陆界面网络连接实现
@interface LoginWsImpl : BaseWs

//登录
-(AFHTTPRequestOperationManager *) login : (NSString *) userName password : (NSString *) password result : (void(^)(BOOL isSuccess , id result,NSString* data)) result;
//注册
-(AFHTTPRequestOperationManager *) registerBroker : (NSString *) number name : (NSString *) name password : (NSString *) password cityId : (NSString *) cityId regionId : (NSString *) regionId brokerId : (NSString *) brokerId result : (void(^)(BOOL isSuccess , id result,NSString* data)) result ;


@end
