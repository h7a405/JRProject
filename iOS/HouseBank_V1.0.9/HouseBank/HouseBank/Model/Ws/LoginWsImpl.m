//
//  LoginWsImpl.m
//  HouseBank
//
//  Created by CSC on 14/12/1.
//  Copyright (c) 2014年 QCloud. All rights reserved.
//

#import "LoginWsImpl.h"

@implementation LoginWsImpl

-(AFHTTPRequestOperationManager *) login : (NSString *) userName password : (NSString *) password result : (void(^)(BOOL isSuccess , id result,NSString* data)) result{
    NSDictionary *params=@{@"username": userName,@"password": password};
    return [super doGet:KUrlConfig method: @"user/login" params:params result:result];
};

-(AFHTTPRequestOperationManager *) registerBroker : (NSString *) number name : (NSString *) name password : (NSString *) password cityId : (NSString *) cityId regionId : (NSString *) regionId brokerId : (NSString *) brokerId result : (void(^)(BOOL isSuccess , id result,NSString* data)) result {
    NSDictionary *params=@{@"mobilephone":number,
                           @"name" : name,
                           @"password":password,
                           @"cityId":cityId,
                           @"regionId":regionId,
                           @"blockId":brokerId};
    return [super doPost:KUrlConfig method:RESOURCE_BROKER params:params result:result];
};

@end
