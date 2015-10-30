//
//  AlertMessage.h
//  WisdomZhuHai
//
//  Created by JasonLee on 15/2/6.
//  Copyright (c) 2015年 wyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface DropDownNotification : UIView

+ (id)sharedDropDown;

- (void)setupTitle:(NSString *)title;
- (void)showWithDuration:(CGFloat)duration andAnimated:(BOOL)animated;
- (void)showWithTitle:(NSString *)title andDuration:(CGFloat)duration andAnimated:(BOOL)animated;
- (void)showWithTitle:(NSString *)title andAnimated:(BOOL)animated;
- (void)showWithCover:(BOOL)clickable andAnimated:(BOOL)animated;
- (void)dismissCoverOneWithAnimated:(BOOL)animated;
@end
