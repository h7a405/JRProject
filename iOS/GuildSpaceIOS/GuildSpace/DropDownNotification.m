//
//  AlertMessage.m
//  WisdomZhuHai
//
//  Created by JasonLee on 15/2/6.
//  Copyright (c) 2015年 wyd. All rights reserved.
//

#import "AlertMessage.h"

#define HEIGHT_ALERT 55
#define WIDTH_ALERT 180
#define Y_OFFSET_ALERT 100
#define X_OFFSET_ALERT (320 - WIDTH_ALERT)
#define HEIGHT_TITLE 25
#define GAP_DEFAULT 10
#define FONT_TITLE [UIFont systemFontOfSize:16]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface AlertMessage()

@property (nonatomic, strong) NSString *string_title;

@property (nonatomic, strong) UIColor *color_title;
@property (nonatomic, strong) UIColor *color_background;

@property (nonatomic, strong) UILabel *lb_title;

@property (nonatomic, strong) UIButton *btn_cover;

@property (nonatomic, assign) BOOL isOnLeft;

@property (nonatomic, assign) CGFloat y;

@end

@implementation AlertMessage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithY:(CGFloat)y andTitle:(NSString *)title{
    self = [self initAlert];
    if(self){
        [self setStartWithY:y];
        [self initContentWithTitle:title];
    }
    return self;
}

-(id)initWithY:(CGFloat)y{
    self = [self initAlert];
    if(self){
        [self setStartWithY:y];
    }
    return self;
}

-(id)initWithTitle:(NSString *)title{
    self = [self initAlert];
    if(self){
        [self initContentWithTitle:title];
    }
    return self;
}

-(id)initAlert{
    self = [self initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, Y_OFFSET_ALERT, WIDTH_ALERT, HEIGHT_ALERT)];
    if(self){
        self.y = Y_OFFSET_ALERT;
        self.backgroundColor = [UIColor blackColor];
        [self setAlpha:0.85];
        self.isOnLeft = NO;
    }
    return self;
}

-(void)setStartWithY:(CGFloat)y{
    self.y = y;
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.y, WIDTH_ALERT, HEIGHT_ALERT);
}

-(void)setTitle:(NSString *)title{
    self.string_title = [NSString stringWithString:title];
    self.lb_title.text = self.string_title;
}

- (void)initContentWithTitle:(NSString *)title{
    self.string_title = [NSString stringWithString:title];
    self.lb_title = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width + GAP_DEFAULT, (HEIGHT_ALERT - HEIGHT_TITLE) / 2 + self.y, WIDTH_ALERT, HEIGHT_TITLE)];
    self.lb_title.text = self.string_title;
    self.lb_title.textColor = [UIColor whiteColor];
    self.lb_title.font = FONT_TITLE;
}

-(void)showWithCover:(BOOL)boolean{
    CGRect rect_cover = CGRectZero;
    if(boolean){
        rect_cover = [UIScreen mainScreen].bounds;
    }
    self.btn_cover = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_cover setFrame:rect_cover];
    [self.btn_cover setBackgroundColor:[UIColor clearColor]];
    [self.btn_cover addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_cover addSubview:self];
    [self.btn_cover addSubview:self.lb_title];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.btn_cover];
    
    [UIView animateWithDuration:0.35f animations:^{
        [self setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - WIDTH_ALERT, self.y, WIDTH_ALERT, HEIGHT_ALERT)];
        [self.lb_title setFrame:CGRectMake(self.frame.origin.x + GAP_DEFAULT, (HEIGHT_ALERT - HEIGHT_TITLE) / 2 + self.y, WIDTH_ALERT, HEIGHT_TITLE)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss{
    CGFloat endPoint;
    CGFloat duration;
    if(self.isOnLeft){
        duration = 0.5;
        endPoint = 0 - WIDTH_ALERT;
    }else{
        duration = 0.3;
        endPoint = [UIScreen mainScreen].bounds.size.width;
    }
    [UIView animateWithDuration:duration animations:^{
        [self setFrame:CGRectMake(endPoint, Y_OFFSET_ALERT, WIDTH_ALERT, HEIGHT_ALERT)];
        [self.lb_title setFrame:CGRectMake(self.frame.origin.x, (HEIGHT_ALERT - HEIGHT_TITLE) / 2 + self.y, WIDTH_ALERT, HEIGHT_TITLE)];
    } completion:^(BOOL finished) {
        [self.btn_cover removeFromSuperview];
        [self.lb_title removeFromSuperview];
    }];
}

-(void)setTitleColor:(UIColor *)titleColor{
    self.color_title = titleColor;
    self.lb_title.textColor = self.color_title;
}

-(void)setAlertColor:(UIColor *)alertColor{
    self.color_background = alertColor;
    self.backgroundColor = self.color_background;
    [self setAlpha:0.9];
}

-(void)setAlertColor:(UIColor *)alertColor andTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor];
    [self setAlertColor:alertColor];
}

-(void)setDismissOnLeft:(BOOL)isOnLeft{
    self.isOnLeft = isOnLeft;
}

@end
