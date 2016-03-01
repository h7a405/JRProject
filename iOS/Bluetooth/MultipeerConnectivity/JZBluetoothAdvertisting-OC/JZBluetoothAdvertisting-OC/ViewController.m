//
//  ViewController.m
//  JZBluetoothAdvertisting-OC
//
//  Created by Jason.Chengzi on 16/01/27.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

#import "ViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ViewController ()<MCSessionDelegate,MCAdvertiserAssistantDelegate, UITextFieldDelegate>

@property (strong,nonatomic) MCSession *session;
@property (strong,nonatomic) MCAdvertiserAssistant *advertiserAssistant;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ViewController

#pragma mark - 控制器视图事件
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建节点，displayName是用于提供给周边设备查看和区分此服务的
    MCPeerID *peerID=[[MCPeerID alloc]initWithDisplayName:@"Advertiser Device"];
    _session=[[MCSession alloc]initWithPeer:peerID];
    _session.delegate=self;
    //创建广播
    _advertiserAssistant=[[MCAdvertiserAssistant alloc]initWithServiceType:@"cmj-stream" discoveryInfo:nil session:_session];
    _advertiserAssistant.delegate=self;
    
}

#pragma mark - UI事件
- (IBAction)advertiserClick:(UIBarButtonItem *)sender {
    //开始广播
    [self cleanLog];
    [self writeLog: (@"开始广播。")];
    [self.advertiserAssistant start];
    [self writeLog:[NSString stringWithFormat:@"广播名称：%@。", self.session.myPeerID.displayName]];
    
    [sender setEnabled:NO];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self.sendButton setEnabled:YES];
}
- (IBAction)selectClick:(UIBarButtonItem *)sender {
    [self writeLog: (@"广播已停止。")];
    [self.advertiserAssistant stop];
    
    [sender setEnabled:NO];
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
    [self.sendButton setEnabled:NO];
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

#pragma mark - MCSession代理方法
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    [self writeLog: (@"连接状态发生改变：")];
    switch (state) {
        case MCSessionStateConnected:
            [self writeLog: (@"连接成功.")];
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
    [self writeLog:(@"开始接收数据...")];
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self writeLog:[NSString stringWithFormat:@"%@", dataString]];
    
    [self writeLog:@"接收结束。"];
}
#pragma mark - MCAdvertiserAssistant代理方法
#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void) writeLog: (NSString *)log {
    
    NSLog(log);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textView setText:[NSString stringWithFormat:@"%@\r\n%@", log, self.textView.text]];
    });
}
- (void) cleanLog {
    [self.textView setText:@""];
}
@end
