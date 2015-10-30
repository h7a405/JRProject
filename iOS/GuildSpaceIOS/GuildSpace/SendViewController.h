//
//  SendViewController.h
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/4/30.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendViewController : UIViewController

@property(nonatomic, assign)BOOL isComment;
@property(nonatomic, assign)NSInteger message_id;

@property (nonatomic, strong) NSString *string_navigationTitle;
@property (nonatomic, strong) NSString *string_navigationRightButton;

@end
