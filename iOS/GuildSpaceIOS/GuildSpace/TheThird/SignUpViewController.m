//
//  SignUpViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/5/1.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "SignUpViewController.h"
#import "Common.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@property(nonatomic, strong)UITextField *txt_username;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
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

- (void)initView{
    
    self.txt_username = [[UITextField alloc]init];
    [self.txt_username setFrame:[Common getCenterRectWithSuperView:self.view andSize:CGSizeMake(160, 30)]];
    self.txt_username.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.txt_username];
    
    UILabel *lb_content = [[UILabel alloc]init];
    NSString *str_content = @"输入你的昵称";
    CGSize size_content = [Common getContentSizeWithContent:str_content andFont:lb_content.font];
    [lb_content setFrame:CGRectMake(30, self.txt_username.frame.origin.y - size_content.height - 5, size_content.width, size_content.height)];
    lb_content.text = str_content;
    
    [self.view addSubview:lb_content];
    
    UIButton *btn_start = [[UIButton alloc]init];
    [btn_start setTitle:@"开启密旅" forState:UIControlStateNormal];
    [btn_start setFrame:[Common getVerticaRectlWithSuperView:self.view andYOrigin:self.txt_username.frame.origin.y + self.txt_username.frame.size.height + 10 andSize:[Common getContentSizeWithContent:btn_start.titleLabel.text andFont:btn_start.titleLabel.font]]];
    [self.view addSubview:btn_start];
    [btn_start setTitleColor:[Common getColorWithRGB:0x66ccff] forState:UIControlStateNormal];
    
    [btn_start addTarget:self action:@selector(doSignUp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)doSignUp:(id)sender{
    if(self.txt_username.text == nil || self.txt_username.text.length < 1){
        [[DropDownNotification sharedDropDown]showWithTitle:@"内容不能为空" andAnimated:YES];
    }
    [NetworkAPI signUpWithNickname:self.txt_username.text andTarget:self andSelector:@selector(signUpCallBack:)];
}

- (void)signUpCallBack:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 返回数据：%@", __FUNCTION__, dic);
    if([[dic objectForKey:@"code"] isEqualToString:@"0000"]){
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"firstOpenFlag"];
        [userDefault synchronize];
        
        NSDictionary *dic_user = [dic objectForKey:@"user"];
        [[Common sharedCommon]setUserWithUsername:[dic_user objectForKey:USER_USERNAME] andUser_id:[dic_user objectForKey:USER_ID] andPhone:[dic_user objectForKey:USER_PHONE]];
        NSLog(@"%s || isWriteToFileSucceeded:%i", __FUNCTION__ ,[dic_user writeToFile:[FileManager getFullDocumentPath:@"userData"] atomically:YES]);
        
//        [[UserModel sharedUser]setupModelWithDictionary:dic_user];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.rootViewCtrl showMain];
    } else if ([[dic objectForKey:@"code"] isEqualToString:@"0007"]){
        [[DropDownNotification sharedDropDown]showWithTitle:@"昵称已存在" andAnimated:YES];
    }
    
}

@end
