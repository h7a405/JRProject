//
//  AlertMessage.h
//  WisdomZhuHai
//
//  Created by JasonLee on 15/2/6.
//  Copyright (c) 2015年 wyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertMessage : UIView

-(id)initWithY:(CGFloat)y andTitle:(NSString *)title;
-(id)initWithY:(CGFloat)y;
-(id)initWithTitle:(NSString *)title;
-(void)setStartWithY:(CGFloat)y;
-(void)setTitle:(NSString *)title;
-(void)showWithCover:(BOOL)boolean;
-(void)dismiss;
-(void)setTitleColor:(UIColor *)titleColor;
-(void)setAlertColor:(UIColor *)alertColor;
-(void)setAlertColor:(UIColor *)alertColor andTitleColor:(UIColor *)titleColor;
-(void)setDismissOnLeft:(BOOL)isOnLeft;
@end
