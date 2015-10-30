//
//  FriendViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/19.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "FriendViewController.h"
#import "Common.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[Common getColorWithRGB:0x66ccff]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
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

@end
