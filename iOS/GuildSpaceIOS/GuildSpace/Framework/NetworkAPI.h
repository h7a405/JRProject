//
//  NetworkAPI.h
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/25.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefine.h"
#import "Network.h"
#import "Common.h"

@interface NetworkAPI : NSObject

+ (void)testApiWithTarget:(id)target andSelector:(SEL)selector;

+ (void)signUpWithAccount:(NSString *)account andPassword:(NSString *)password andTarget:(id)target andSelector:(SEL)selector;

+ (void)connectingTestWithTarget:(id)target andSelector:(SEL)selector;

+ (void)sendMessageWithContent:(NSString *)content andTarget:(id)target andSelector:(SEL)selector;

+ (void)sendCommentWithContent:(NSString *)content andMessage_id:(NSInteger)message_id andTarget:(id)target andSelector:(SEL)selector;

+ (void)sendLikeWithType:(NSInteger)type andParent_id:(NSInteger)parent_id andTarget:(id)target andSelector:(SEL)selector;

+ (void)getMessageListWithPage:(NSInteger)page andTarget:(id)target andSelector:(SEL)selector;

+ (void)getMessageDetailWithID:(NSInteger)message_id andTarget:(id)target andSelector:(SEL)selector;

+ (void)signUpWithNickname:(NSString *)nickname andTarget:(id)target andSelector:(SEL)selector;

+ (void)userBindWithPhone:(NSString *)phone andTarget:(id)target andSelector:(SEL)selector;

+ (void)userRecoverWithPhone:(NSString *)phone andTarget:(id)target andSelector:(SEL)selector;

+ (void)getUserMessageWithTarget:(id)target andSelector:(SEL)selector;

+ (void)getUserLikeWithTarget:(id)target andSelector:(SEL)selector;

+ (void)getUserCommentWithTarget:(id)target andSelector:(SEL)selector;

+ (void)sendUpdateWithNickname:(NSString *)nickname andTarget:(id)target andSelector:(SEL)selector;
@end
