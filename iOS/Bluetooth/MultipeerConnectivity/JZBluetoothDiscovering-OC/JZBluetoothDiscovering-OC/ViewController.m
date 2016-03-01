//
//  ViewController.m
//  JZBluetoothDiscovering-OC
//
//  Created by Jason.Chengzi on 16/01/27.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

#import "ViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ViewController ()<MCSessionDelegate, MCBrowserViewControllerDelegate, UITextFieldDelegate>

@property (strong,nonatomic) MCSession *session;
@property (strong,nonatomic) MCBrowserViewController *browserController;


@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ViewController

#pragma mark - 控制器视图事件
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建节点
    MCPeerID *peerID=[[MCPeerID alloc]initWithDisplayName:@"Discover Device"];
    //创建会话
    _session=[[MCSession alloc]initWithPeer:peerID];
    _session.delegate=self;
    
    
}
#pragma mark- UI事件
- (IBAction)browserClick:(UIBarButtonItem *)sender {
    _browserController=[[MCBrowserViewController alloc]initWithServiceType:@"cmj-stream" session:self.session];
    _browserController.delegate=self;
    
    [self presentViewController:_browserController animated:YES completion:nil];
}
- (IBAction)selectClick:(UIBarButtonItem *)sender {
    
}

- (IBAction)didSendButtonClicked:(id)sender {
    [self writeLog: (@"消息将会发送到：")];
    
    NSString * stringToSend = self.textField.text;
    
    if (stringToSend.length <= 0) {
        stringToSend = @"空信息";
    }
    
    [self.textField setText:@""];
    
    //发送数据给所有已连接设备
    NSError *error=nil;
    [self.session sendData: [stringToSend dataUsingEncoding:NSUTF8StringEncoding] toPeers:[self.session connectedPeers] withMode:MCSessionSendDataUnreliable error:&error];
    
    for (MCPeerID *peerID in [self.session connectedPeers]) {
        [self writeLog:[NSString stringWithFormat:@"%@;", peerID.displayName]];
    }
    
    if (error) {
        [self writeLog:[NSString stringWithFormat:@"发送数据过程中发生错误，错误信息：%@。",error.localizedDescription]];
    } else {
        [self writeLog:[NSString stringWithFormat:@"消息【%@】已发送。", stringToSend]];
    }
}


#pragma mark - MCBrowserViewController代理方法
-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    NSLog(@"已选择");
    [self.browserController dismissViewControllerAnimated:YES completion:nil];
}
-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    NSLog(@"取消浏览.");
    [self.browserController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MCSession代理方法
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    [self writeLog: (@"连接状态发生改变：")];
    switch (state) {
        case MCSessionStateConnected:
            [self writeLog: (@"连接成功.")];
//            [self presentViewController:_browserController animated:YES completion:nil];
            break;
        case MCSessionStateConnecting:
            [self writeLog: (@"正在连接...")];
            break;
        default:
            [self writeLog:(@"连接失败.")];
            break;
    }
}

//接收数据
-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    [self writeLog:[NSString stringWithFormat:@"开始从【%@】接收数据...", peerID.displayName]];
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self writeLog:[NSString stringWithFormat:@"%@", dataString]];
    
    [self writeLog:@"接收结束。"];
}

#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void) writeLog: (NSString *)log {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textView setText:[NSString stringWithFormat:@"%@\r\n%@", log, self.textView.text]];
    });
    NSLog(log);
}
- (void) cleanLog {
    [self.textView setText:@""];
}
@end
