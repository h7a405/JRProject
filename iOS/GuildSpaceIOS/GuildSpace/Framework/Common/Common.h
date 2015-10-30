//
//  Common.h
//  RouteInHand
//
//  Created by JasonLee on 15/2/12.
//  Copyright (c) 2015年 CrazyOrangeTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkAPI.h"
#import "DropDownNotification.h"
#import "MJRefresh.h"
#import "FileManager.h"
#import "UserModel.h"

#define FRAME_SCREEN [UIScreen mainScreen].bounds

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define HEIGHT_NAVIGATIONBAR 45
#define HEIGHT_STATUSBAR 20
#define HEIGHT_NAVIGATIONBAR_STATUSBAR 65
#define HEIGHT_BOTTOMBAR 40

@interface Common : NSObject

+(id)sharedCommon;

- (void)setUserWithUsername:(NSString *)username andUser_id:(NSString *)user_id andPhone:(NSString *)phone;
- (NSDictionary *)getCurrentUser;

+(UIColor *)getColorWithRGB:(int)rgb;
+(UIColor *)getColorWithRed:(float)red andGreen:(float)green andBlue:(float)blue andAlpha:(float)alpha;

+(CGSize)getContentSizeWithContent:(NSString *)content andFont:(UIFont *)font;
+(CGRect)getCenterRectWithSuperView:(UIView *)superView andContent:(NSString *)content andFont:(UIFont *)font;
+(CGRect)getVerticaRectlWithSuperView:(UIView *)superView andYOrigin:(float)y andSize:(CGSize)size;
+(CGRect)getOrientedRectWithSuperView:(UIView *)superView andXOrgin:(float)x andSize:(CGSize)size;
+(CGRect)getCenterRectWithSuperView:(UIView *)superView andSize:(CGSize)size;


+(NSString *)getUrlCombineWithModule:(NSString *)module andFunction:(NSString *)function;
+(NSString *)getTimeStamp;
+(NSString *)getStringWithInteger:(NSInteger)integer;

+(UITableView *)getPullTableWithFrame:(CGRect)frame style:(UITableViewStyle)style hasRefresh:(BOOL)hasRefresh refreshSelector:(SEL)refreshSelector hasLoad:(BOOL)hasLoad loadSelector:(SEL)selector target:(id)target;

+(void)printRectOfView:(UIView *)view andIdentify:(NSString *)identify;
+(void)showSignUp;

#pragma mark - Network
+ (void)getDeviceNetworkStatus;
+ (void)getServerStatus;

@end
