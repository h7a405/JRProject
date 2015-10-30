//
//  DetailViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/4/30.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "DetailViewController.h"
#import "Common.h"
#import "SendViewController.h"

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSDictionary *dic_message;
@property(nonatomic, strong)NSArray *array_comment;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dic_message = [NSDictionary dictionary];
    self.array_comment = [NSArray array];
    
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
//    [self getMessageDetail];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"详细";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithTitle:@"评论" style:UIBarButtonItemStyleDone target:self action:@selector(gotoSendComment:)];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.array_comment.count;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 165;
            break;
        case 1:
            return 80;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return @"评论";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array_nib = [[NSBundle mainBundle]loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
            if(cell == nil){
                cell = array_nib[1];
                UIButton *btn_nickname = (UIButton *)[cell viewWithTag:900001];
                [btn_nickname setTitle:[self.dic_message objectForKey:@"nickname"] forState:UIControlStateNormal];
                btn_nickname.titleLabel.textAlignment = NSTextAlignmentLeft;
                UITextView *view_text = (UITextView *)[cell viewWithTag:900002];
                view_text.text = [self.dic_message objectForKey:@"content"];
                UIButton *btn_like = (UIButton *)[cell viewWithTag:900003];
                [btn_like setTitle:[NSString stringWithFormat:@"%@", [self.dic_message objectForKey:@"likeCount"]] forState:UIControlStateNormal];
                btn_like.tag = 1000001;
                [btn_like addTarget:self action:@selector(sendMessageLike:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *lb_date = (UILabel *)[cell viewWithTag:900005];
                lb_date.text = [self.dic_message objectForKey:@"time"];
            }
            break;
        case 1:
            if(cell == nil){
                cell = array_nib[2];
                UIButton *btn_nickname = (UIButton *)[cell viewWithTag:900001];
                [btn_nickname setTitle:[self.array_comment[indexPath.row] objectForKey:@"nickname"] forState:UIControlStateNormal];
                UITextView *view_text = (UITextView *)[cell viewWithTag:900002];
                view_text.text = [self.array_comment[indexPath.row] objectForKey:@"content"];
                UIButton *btn_like = (UIButton *)[cell viewWithTag:900003];
                [btn_like setTitle:[NSString stringWithFormat:@"%@", [self.array_comment[indexPath.row] objectForKey:@"likeCount"]] forState:UIControlStateNormal];
                btn_like.tag = 800000 + indexPath.row;
                [btn_like addTarget:self action:@selector(sendMessageLike:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *lb_date = (UILabel *)[cell viewWithTag:900005];
                lb_date.text = [self.array_comment[indexPath.row] objectForKey:@"time"];
            }
            break;
        default:
            cell = [[UITableViewCell alloc]init];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)getMessageDetail{
    [NetworkAPI getMessageDetailWithID:self.message_id andTarget:self andSelector:@selector(getMessageDetailCallBack:)];
}

- (void)getMessageDetailCallBack:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 返回数据：%@", __FUNCTION__, dic);
    if([[dic objectForKey:@"code"]isEqualToString:@"0000"]){
        self.dic_message = [NSDictionary dictionaryWithDictionary:[dic objectForKey:@"message"]];
        if([dic objectForKey:@"commentList"] != [NSNull null]){
            self.array_comment = [NSArray arrayWithArray:[dic objectForKey:@"commentList"]];
        }else{
            self.array_comment = [NSArray array];
        }
    }
    [self.tableView reloadData];
}

- (void)gotoSendComment:(UIButton *)button{
    SendViewController *sendViewCtrl = [[SendViewController alloc]init];
    [sendViewCtrl.view setFrame:self.view.frame];
    sendViewCtrl.message_id = self.message_id;
    sendViewCtrl.isComment = YES;
    sendViewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sendViewCtrl animated:YES];
}

- (void)sendMessageLike:(UIButton *)button{
    NSInteger parent_id;
    NSInteger type;
    if(button.tag == 1000001){
        type = 0;
        parent_id = self.message_id;
    }else{
        type = 1;
        parent_id = [[self.array_comment[(button.tag - 800000)] objectForKey:@"id"] integerValue];
    }
    [NetworkAPI sendLikeWithType:type andParent_id:parent_id andTarget:self andSelector:@selector(sendMessageLikeCallBack:)];
}

- (void)sendMessageLikeCallBack:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 返回数据：%@", __FUNCTION__, dic);
    if([[dic objectForKey:@"code"] isEqualToString:@"0000"]){
//        [self.tableView.header refreshingAction];
    }
}

@end
