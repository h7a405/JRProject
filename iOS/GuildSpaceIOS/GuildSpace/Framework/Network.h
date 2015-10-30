//
//  Network.h
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/25.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <objc/message.h>
#import "Common.h"
#import "NetworkDefine.h"

@interface Network : NSObject

+(void) getDataWithoutParamsFrom:(NSString *)string andTarget:(id)target andSelector:(SEL)selector;
+(void) getDataWithParams:(NSDictionary *)params andFrom:(NSString *)string andTarget:(id)target andSelector:(SEL)selector;
+(void) postDataWithParams:(NSDictionary *)params andFrom:(NSString *)string andTarget:(id)target andSelector:(SEL)selector;
+(void) showResultWithRequest:(NSDictionary *)request;
@end
