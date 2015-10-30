//
//  DetailViewController.h
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/4/30.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property(nonatomic, assign)NSInteger message_id;

- (void)getMessageDetail;

@end
