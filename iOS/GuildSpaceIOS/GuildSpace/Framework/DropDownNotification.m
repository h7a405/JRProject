//
//  AlertMessage.m
//  WisdomZhuHai
//
//  Created by JasonLee on 15/2/6.
//  Copyright (c) 2015年 wyd. All rights reserved.
//

#import "DropDownNotification.h"

#define HEIGHT_ALERT 65
#define WIDTH_ALERT FRAME_SCREEN.size.width
#define Y_OFFSET_ALERT 0
#define X_OFFSET_ALERT 0
#define HEIGHT_TITLE 25
#define GAP_DEFAULT 10
#define FONT_TITLE [UIFont fontWithName:@"Arial" size:16.0]
#define COLOR_TITLE [UIColor whiteColor]
#define COLOR_BACKGROUND [Common getColorWithRGB:0x66ccee]

@interface DropDownNotification()

@property(nonatomic, strong)UILabel *lb_title;
@property(nonatomic, strong)UIView *view_cover;

@end

@implementation DropDownNotification

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
static DropDownNotification *dropDown = nil;
static Boolean isShown = NO;

+(id)sharedDropDown{
    if(!dropDown){
        dropDown = [[DropDownNotification alloc]init];
    }
    return dropDown;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupNotification{
    [self setFrame:CGRectMake(X_OFFSET_ALERT, Y_OFFSET_ALERT - HEIGHT_ALERT, WIDTH_ALERT, HEIGHT_ALERT)];
    self.backgroundColor = COLOR_BACKGROUND;
}

- (void)setupTitle:(NSString *)title{
    [self setupNotification];
    
    self.lb_title = [[UILabel alloc]init];
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    self.lb_title.textColor = COLOR_TITLE;
    self.lb_title.font = FONT_TITLE;
    self.lb_title.text = title;
    [self.lb_title setFrame:[Common getCenterRectWithSuperView:self andContent:self.lb_title.text andFont:self.lb_title.font]];
    [self addSubview:self.lb_title];
}

- (void)setupCover:(BOOL)clickable{
    self.view_cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view_cover.backgroundColor = [UIColor clearColor];
    [self addSubview:self.view_cover];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    if(clickable){
        [self.view_cover addGestureRecognizer:tapGesture];
    }
}

- (void)showWithDuration:(CGFloat)duration andAnimated:(BOOL)animated{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    CGFloat animatedDuration = 0;
    
    if(animated){
        animatedDuration = 0.35f;
    }
    [UIView animateWithDuration:animatedDuration animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, Y_OFFSET_ALERT, self.frame.size.width, self.frame.size.height)];
        [self.lb_title setFrame:CGRectMake(self.lb_title.frame.origin.x, self.lb_title.frame.origin.y + GAP_DEFAULT, self.lb_title.frame.size.width, self.lb_title.frame.size.height)];
    }];
    isShown = YES;
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(dismiss:) userInfo:nil repeats:NO];
}

- (void)showWithTitle:(NSString *)title andAnimated:(BOOL)animated{
    if(isShown)return;
    [self setupTitle:title];
    [self showWithDuration:1.2 andAnimated:animated];
}

- (void)showWithTitle:(NSString *)title andDuration:(CGFloat)duration andAnimated:(BOOL)animated{
    if(isShown)return;
    [self setupTitle:title];
    [self showWithDuration:duration andAnimated:animated];
}

- (void)showWithCover:(BOOL)clickable andAnimated:(BOOL)animated{
    if(isShown)return;
    [self setupTitle:@"加载中……"];
    self.backgroundColor = [UIColor blackColor];
    [self setupCover:clickable];
    [self showWithDuration:15 andAnimated:animated];
}

- (void)show{
    
}

- (void)dismissWithAnimated:(BOOL)animated{
    CGFloat animateDuration = 0;
    if(animated){
        animateDuration = 0.25f;
    }
    [UIView animateWithDuration:animateDuration animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y - HEIGHT_ALERT, self.frame.size.width, self.frame.size.height)];
        [self.lb_title setAlpha:0];
    }completion:^(BOOL finished){
        [self.lb_title removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)dismissCoverOneWithAnimated:(BOOL)animated{
    CGFloat animatedDuration = 0;
    if(animated){
        animatedDuration = 0.25f;
    }
    [UIView animateWithDuration:animatedDuration animations:^{
        [self setAlpha:0];
        [self.lb_title setAlpha:0];
    }completion:^(BOOL finished){
        [self.lb_title removeFromSuperview];
        [self removeFromSuperview];
        isShown = NO;
    }];
}

- (void)dismiss:(NSTimer *)timer{
    [self dismissWithAnimated:YES];
}

@end
