//
//  Network.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/25.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "Network.h"

@implementation Network

+(void) getDataWithoutParamsFrom:(NSString *)string andTarget:(id)target andSelector:(SEL)selector{
    [Network printData:string andData:nil];
    [Common getDeviceNetworkStatus];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
//        NSLog(@"%s || JSON: %@", __FUNCTION__, responseObject);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        [self showResultWithRequest:dic];
        objc_msgSend(target, selector, dic);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSLog(@"%s || Error: %@", __FUNCTION__, error);
        [self showResultWithRequest:nil];
        objc_msgSend(target, selector, nil);
    }];
}

+(void) getDataWithParams:(NSDictionary *)params andFrom:(NSString *)string andTarget:(id)target andSelector:(SEL)selector{
    [Network printData:string andData:params];
    [Common getDeviceNetworkStatus];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:string parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
//        NSLog(@"%s || JSON: %@", __FUNCTION__, responseObject);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        [self showResultWithRequest:dic];
        objc_msgSend(target, selector, dic);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSLog(@"%s || Error: %@", __FUNCTION__, error);
        [self showResultWithRequest:nil];
        objc_msgSend(target, selector, nil);
    }];
}

+(void) postDataWithParams:(NSDictionary *)params andFrom:(NSString *)string andTarget:(id)target andSelector:(SEL)selector{
    [Network printData:string andData:params];
    [Common getDeviceNetworkStatus];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:string parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        [self showResultWithRequest:dic];
        objc_msgSend(target, selector, dic);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [self showResultWithRequest:nil];
        objc_msgSend(target, selector, nil);
    }];
}

+ (void)showResultWithRequest:(NSDictionary *)request{
    CGFloat defaultDuration = 2;
    if(request){
        NSString *resultCode = [request objectForKey:RESULTCODE];
        NSString *resultContent = [request objectForKey:RESULTCONTENT];
        NSLog(@"Result form server: %@ / %@", resultCode, resultContent);
        [[DropDownNotification sharedDropDown]setupTitle:resultContent];
        [[DropDownNotification sharedDropDown]showWithDuration:defaultDuration andAnimated:YES];
    }else{
        [[DropDownNotification sharedDropDown]setupTitle:@"网络请求失败"];
        [[DropDownNotification sharedDropDown]showWithDuration:defaultDuration andAnimated:YES];
    }
}

+ (void)printData:(NSString *)url andData:(NSDictionary *)data{
    NSLog(@"当前方法：%s || 链接地址：%@ || 以及数据：%@", __FUNCTION__, url, data);
}

@end
