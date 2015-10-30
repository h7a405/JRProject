//
//  Common.m
//  RouteInHand
//
//  Created by JasonLee on 15/2/12.
//  Copyright (c) 2015年 CrazyOrangeTeam. All rights reserved.
//

#import "Common.h"

@interface Common()

@property(nonatomic, strong)NSString *user_id;
@property(nonatomic, strong)NSString *username;
@property(nonatomic, strong)NSString *phone;

@end

@implementation Common

static Common *common = nil;

+ (id)sharedCommon{
    if(common == nil){
        common = [[Common alloc]init];
    }
    return common;
}

- (void)setUserWithUsername:(NSString *)username andUser_id:(NSString *)user_id andPhone:(NSString *)phone{
    self.user_id = user_id;
    self.username = username;
    self.phone = phone;
}

- (NSDictionary *)getCurrentUser{
    NSDictionary *dic_user = @{USER_ID: self.user_id, USER_USERNAME: self.username, USER_PHONE: self.phone};
    return dic_user;
}

+(UIColor *)getColorWithRGB:(int)rgb{
    return HexRGB(rgb);
}
+(UIColor *)getColorWithRed:(float)red andGreen:(float)green andBlue:(float)blue andAlpha:(float)alpha{
    return RGBAlpha(red, green, blue, alpha);
}

+(CGSize)getContentSizeWithContent:(NSString *)content andFont:(UIFont *)font{
    CGSize size_content = [content sizeWithAttributes:@{NSFontAttributeName:font}];
    return size_content;
}
+(CGRect)getCenterRectWithSuperView:(UIView *)superView andContent:(NSString *)content andFont:(UIFont *)font{
    CGSize size_content = [Common getContentSizeWithContent:content andFont:font];
    CGRect rect_content = CGRectMake((superView.frame.size.width - size_content.width) / 2, (superView.frame.size.height - size_content.height) / 2, size_content.width, size_content.height);
    return rect_content;
}
+(CGRect)getVerticaRectlWithSuperView:(UIView *)superView andYOrigin:(float)y andSize:(CGSize)size{
    CGRect rect_view = CGRectMake((superView.frame.size.width - size.width) / 2, y, size.width, size.height);
    return rect_view;
}
+(CGRect)getOrientedRectWithSuperView:(UIView *)superView andXOrgin:(float)x andSize:(CGSize)size{
    CGRect rect_view = CGRectMake(x, (superView.frame.size.height - size.height) / 2, size.width, size.height);
    return rect_view;
}
+(CGRect)getCenterRectWithSuperView:(UIView *)superView andSize:(CGSize)size{
    CGRect rect_view = CGRectMake((superView.frame.size.width - size.width) / 2, (superView.frame.size.height - size.height) / 2, size.width, size.height);
    return rect_view;
}

+(NSString *)getUrlCombineWithModule:(NSString *)module andFunction:(NSString *)function{
    return [NSString stringWithFormat:@"%@%@/%@", BASE_URL, module, function];
}
+(NSString *)getTimeStamp{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString = [dateFormatter stringFromDate:currentDate];
    return locationString;
}
+(NSString *)getStringWithInteger:(NSInteger)integer{
    return [NSString stringWithFormat:@"%ld", (long)integer];
}

+(UITableView *)getPullTableWithFrame:(CGRect)frame style:(UITableViewStyle)style hasRefresh:(BOOL)hasRefresh refreshSelector:(SEL)refreshSelector hasLoad:(BOOL)hasLoad loadSelector:(SEL)selector target:(id)target{
    UITableView *tableview = [[UITableView alloc]initWithFrame:frame style:style];
    if(hasRefresh){
        [tableview addLegendHeaderWithRefreshingTarget:target refreshingAction:refreshSelector];
        tableview.header.updatedTimeHidden = YES;
    }
    if(hasLoad){
        [tableview addLegendFooterWithRefreshingTarget:target refreshingAction:selector];
        tableview.footer.automaticallyRefresh = NO;
    }
    return tableview;
}

+(void)printRectOfView:(UIView *)view andIdentify:(NSString *)identify{
    NSLog(@"%s || rect of view (%@) is: %@", __FUNCTION__,identify, NSStringFromCGRect(view.frame));
}

+ (void)getDeviceNetworkStatus{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(NSInteger status){
        NSString *string;
        switch (status) {
            case 0:
                string = @"不可用。";
                break;
            case 1:
                string = @"移动网络（流量）。";
                break;
            case 2:
                string = @"WIFI网络。";
                break;
            default:
                string = @"未知网络状态。";
                break;
        }
        NSLog(@"当前网络状态：%@(%ld)", string, status);
    }];
}
+ (void)showSignUp{
    
}

+ (void)getServerStatus{
    [NetworkAPI connectingTestWithTarget:self andSelector:@selector(printServerStatus:)];
}

+ (void)printServerStatus:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 服务器连接测试结构：%@", __FUNCTION__, dic);
}

@end
