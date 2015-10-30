//
//  UserModel.m
//  GuildSpace
//
//  Created by SilversRayleigh on 9/7/15.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "UserModel.h"

static UserModel *userModel = nil;

@implementation UserModel

+ (UserModel *) sharedUser{
    if (!userModel){
        userModel = [UserModel new];
    }
    return userModel;
}

- (void) setupModelWithDictionary:(NSDictionary *)dic{
    self.user_id = [[dic objectForKey:@"id"] integerValue];
    self.username = [dic objectForKey:@"username"];
    self.mobilePhone = [dic objectForKey:@"phone"];
}

- (NSInteger)user_id{
    if(!_user_id){
        _user_id = 0;
    }
    return _user_id;
}

- (NSString *)username{
    if(!_username){
        _username = @"Unknown";
    }
    return _username;
}

- (NSString *)mobilePhone{
    if(!_mobilePhone){
        _mobilePhone = @"00000000000";
    }
    return _mobilePhone;
}

@end
