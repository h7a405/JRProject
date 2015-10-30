//
//  UserModel.h
//  GuildSpace
//
//  Created by SilversRayleigh on 9/7/15.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (assign, nonatomic) NSInteger user_id;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *mobilePhone;

+ (UserModel *) sharedUser;

- (void) setupModelWithDictionary:(NSDictionary *)dic;

@end
