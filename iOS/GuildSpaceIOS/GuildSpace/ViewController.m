//
//  ViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/18.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "TabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)initView{
//    self.view.backgroundColor = [UIColor lightGrayColor];
    NSString *filePath = [FileManager getFullDocumentPath:@"userData"];
    NSMutableDictionary *userData = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    NSLog(@"%s || user_data:%@", __FUNCTION__, userData);
    
    id firstOpenFlag = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstOpenFlag"];
    if (firstOpenFlag == nil || [userData objectForKey:USER_USERNAME] == nil) {
        [self showSignUp];
//        [self showMain];
    }else{
        [self showMain];
        
        [[Common sharedCommon]setUserWithUsername:[userData objectForKey:USER_USERNAME] andUser_id:[userData objectForKey:USER_ID] andPhone:[userData objectForKey:USER_PHONE]];
    }
}

- (void)showMain{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.view removeFromSuperview];
    TabBarViewController *tabBarViewCtrl = [[TabBarViewController alloc]init];
    [appDelegate.window setRootViewController:tabBarViewCtrl];
}

- (void)showSignUp{
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
//    [self.view removeFromSuperview];
    SignUpViewController *signUpViewCtrl = [[SignUpViewController alloc]init];
//    [self.view addSubview:signUpViewCtrl.view];
    appDelegate.window.rootViewController = signUpViewCtrl;
    [appDelegate.window setRootViewController:signUpViewCtrl];
}

@end
