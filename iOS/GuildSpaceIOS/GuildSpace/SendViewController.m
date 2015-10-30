//
//  SendViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/4/30.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "SendViewController.h"
#import "Common.h"

@interface SendViewController ()<UIAlertViewDelegate>

@property(nonatomic, strong)UITextView *view_text;

@end

@implementation SendViewController

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
    self.navigationItem.title = self.string_navigationTitle;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelSending)];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(confirmSending)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.view_text = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.view_text];
}

- (void)confirmSending{
    UIAlertView *view_alert_confirm = [[UIAlertView alloc]initWithTitle:@"确认发布" message:@"是否确认发布？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    view_alert_confirm.tag = 900002;
    [view_alert_confirm show];
}

- (void)cancelSending{
    UIAlertView *view_alert_cancel = [[UIAlertView alloc]initWithTitle:@"取消并返回" message:@"确认取消发布？" delegate:self cancelButtonTitle:@"继续编辑" otherButtonTitles:@"确认返回", nil];
    view_alert_cancel.tag = 900001;
    [view_alert_cancel show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 900001){
        if(buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if(alertView.tag == 900002){
        if(buttonIndex == 1){
            [self doSend];
        }
    }
}

- (void)doSend{
    if(self.view_text.text.length < 1){
        [[DropDownNotification sharedDropDown]showWithTitle:@"内容不能为空！" andDuration:1.5f andAnimated:YES];
//        return;
    }else{
        if(self.isComment){
            [NetworkAPI sendCommentWithContent:self.view_text.text andMessage_id:self.message_id andTarget:self andSelector:@selector(sendCallBack:)];
        }else{
            [NetworkAPI sendMessageWithContent:self.view_text.text andTarget:self andSelector:@selector(sendCallBack:)];
        }
    }
}

- (void)sendCallBack:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 返回数据：%@", __FUNCTION__, dic);
    if([[dic valueForKey:@"code"] isEqualToString:@"0000"]){
        [self. navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)string_navigationTitle{
    if(_string_navigationTitle == nil){
        _string_navigationTitle = @"加载失败";
    }
    return _string_navigationTitle;
}

@end
