//
//  TabBarViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/19.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "TabBarViewController.h"
#import "Common.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "PlayerViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initTabBar{
    HomeViewController *homeViewCtrl = [[HomeViewController alloc]init];
    //    FriendViewController *friendViewCtrl = [[FriendViewController alloc]init];
    MessageViewController *messageViewCtrl = [[MessageViewController alloc]init];
    PlayerViewController *playerViewCtrl = [[PlayerViewController alloc]init];
    
    UINavigationController *homeNaviCtrl = [[UINavigationController alloc]initWithRootViewController:homeViewCtrl];
    homeNaviCtrl.tabBarItem.title = @"首页";
    homeNaviCtrl.tabBarItem.image = [UIImage imageNamed:@"首页2.png"];
    homeNaviCtrl.tabBarItem.selectedImage = [UIImage imageNamed:@"首页1.png"];
    //    UINavigationController *friendNaviCtrl = [[UINavigationController alloc]initWithRootViewController:friendViewCtrl];
    //    friendNaviCtrl.tabBarItem.title = @"聚玩";
    UINavigationController *messageNaviCtrl = [[UINavigationController alloc]initWithRootViewController:messageViewCtrl];
    messageNaviCtrl.tabBarItem.title = @"消息";
    messageNaviCtrl.tabBarItem.image = [UIImage imageNamed:@"玩法2.png"];
    messageNaviCtrl.tabBarItem.selectedImage = [UIImage imageNamed:@"玩法1.png"];
    UINavigationController *playerNaviCtrl = [[UINavigationController alloc]initWithRootViewController:playerViewCtrl];
    playerNaviCtrl.tabBarItem.title = @"我的";
    playerNaviCtrl.tabBarItem.image = [UIImage imageNamed:@"我的2.png"];
    playerNaviCtrl.tabBarItem.selectedImage = [UIImage imageNamed:@"我的1.png"];
    
    self.viewControllers = @[homeNaviCtrl, messageNaviCtrl, playerNaviCtrl];
}

@end
