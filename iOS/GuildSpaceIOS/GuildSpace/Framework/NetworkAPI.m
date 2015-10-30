//
//  NetworkAPI.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/25.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "NetworkAPI.h"

@implementation NetworkAPI

+(void)testApiWithTarget:(id)target andSelector:(SEL)selector{
    NSString *url = [Common getUrlCombineWithModule:APITEST andFunction:TEST];
    [Network getDataWithoutParamsFrom:url andTarget:target andSelector:selector];
}

+(void)signUpWithAccount:(NSString *)account andPassword:(NSString *)password andTarget:(id)target andSelector:(SEL)selector{
    NSDictionary *dic = @{@"account": account, @"password": password};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:SIGNUPACCOUNT];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)connectingTestWithTarget:(id)target andSelector:(SEL)selector{
    NSString *url = [Common getUrlCombineWithModule:APITEST andFunction:TEST];
    [Network getDataWithoutParamsFrom:url andTarget:target andSelector:selector];
}

+ (void)sendMessageWithContent:(NSString *)content andTarget:(id)target andSelector:(SEL)selector{
    NSString *timestamp = [Common getTimeStamp];
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:USER_ID] integerValue];
    NSDictionary *dic = @{USER_USER_ID: [NSString stringWithFormat:@"%ld", (long)user_id], TIMESTAMP: timestamp, CONTENT: content};
    NSString *url = [Common getUrlCombineWithModule:APIMESSAGE andFunction:SENDNEWMESSAGE];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
//    [Network getDataWithoutParamsFrom:url andTarget:target andSelector:selector];
}

+ (void)sendCommentWithContent:(NSString *)content andMessage_id:(NSInteger)message_id andTarget:(id)target andSelector:(SEL)selector{
    NSString *timestamp = [Common getTimeStamp];
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:USER_ID] integerValue];
    NSDictionary *dic = @{MESSAGE_ID: [NSString stringWithFormat:@"%ld", (long)message_id], TIMESTAMP: timestamp, CONTENT: content, USER_USER_ID: [NSString stringWithFormat:@"%ld", (long)user_id]};
    NSString *url = [Common getUrlCombineWithModule:APIMESSAGE andFunction:SENDNEWCOMMENT];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)sendLikeWithType:(NSInteger)type andParent_id:(NSInteger)parent_id andTarget:(id)target andSelector:(SEL)selector{
    NSString *timestamp = [Common getTimeStamp];
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:USER_ID] integerValue];
    NSDictionary *dic = @{TIMESTAMP: timestamp, USER_USER_ID: [NSString stringWithFormat:@"%ld", (long)user_id], TYPE: [NSString stringWithFormat:@"%ld", (long)type], PARENT_ID: [NSString stringWithFormat:@"%ld", (long)parent_id]};
    NSString *url = [Common getUrlCombineWithModule:APIMESSAGE andFunction:SENDNEWLIKE];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)getMessageListWithPage:(NSInteger)page andTarget:(id)target andSelector:(SEL)selector{
    NSDictionary *dic = @{PAGE: [NSString stringWithFormat:@"%ld", (long)page]};
    NSString *url = [Common getUrlCombineWithModule:APIMESSAGE andFunction:GETMESSAGELIST];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)getMessageDetailWithID:(NSInteger)message_id andTarget:(id)target andSelector:(SEL)selector{
    NSDictionary *dic = @{USER_ID: [NSString stringWithFormat:@"%ld", (long)message_id]};
    NSString *url = [Common getUrlCombineWithModule:APIMESSAGE andFunction:GETMESSAGEDETAIL];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)signUpWithNickname:(NSString *)nickname andTarget:(id)target andSelector:(SEL)selector{
    NSDictionary *dic = @{USER_USERNAME: nickname};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:SIGNUPDEFAULT];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)userBindWithPhone:(NSString *)phone andTarget:(id)target andSelector:(SEL)selector{
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:@"user_id"] integerValue];
    NSDictionary *dic = @{USER_ID: [Common getStringWithInteger:user_id], USER_PHONE: phone};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:USERBINDING];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)userRecoverWithPhone:(NSString *)phone andTarget:(id)target andSelector:(SEL)selector{
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:@"user_id"] integerValue];
    NSDictionary *dic = @{USER_ID: [Common getStringWithInteger:user_id], USER_PHONE: phone};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:USERRECOVER];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)getUserMessageWithTarget:(id)target andSelector:(SEL)selector{
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:@"user_id"] integerValue];
    NSDictionary *dic = @{USER_ID: [Common getStringWithInteger:user_id]};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:GETUSERMESSAGELIST];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)getUserLikeWithTarget:(id)target andSelector:(SEL)selector{
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:@"user_id"] integerValue];
    NSDictionary *dic = @{USER_ID: [Common getStringWithInteger:user_id]};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:GETUSERLIKELIST];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)getUserCommentWithTarget:(id)target andSelector:(SEL)selector{
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:@"user_id"] integerValue];
    NSDictionary *dic = @{USER_ID: [Common getStringWithInteger:user_id]};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:GETUSERCOMMENTLIST];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

+ (void)sendUpdateWithNickname:(NSString *)nickname andTarget:(id)target andSelector:(SEL)selector{
    NSInteger user_id = [[[[Common sharedCommon]getCurrentUser] objectForKey:@"user_id"] integerValue];
    NSDictionary *dic = @{USER_ID: [Common getStringWithInteger:user_id], USER_USERNAME: nickname};
    NSString *url = [Common getUrlCombineWithModule:APIUSER andFunction:CHANGENAME];
    [Network postDataWithParams:dic andFrom:url andTarget:target andSelector:selector];
}

@end
