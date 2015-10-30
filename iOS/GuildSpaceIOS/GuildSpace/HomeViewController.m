//
//  HomeViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/19.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"
#import "SendViewController.h"
#import "DetailViewController.h"

static NSInteger const SECTIONOFTABLEVIEW = 1;
static NSInteger const ROWOFSECTION = 1;
static CGFloat const HEIGHTOFROW = 139.5f;

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *array_messages;
@property(nonatomic, assign)int currentPage;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentPage = 0;
    self.array_messages = [NSMutableArray array];
    
    [self.navigationController.navigationBar setBarTintColor:[Common getColorWithRGB:0x66ccff]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *btn_send = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(gotoSend)];
    btn_send.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = btn_send;
    self.navigationItem.title = @"首页";
    
    [self initTableView];
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

- (void)initTableView{
    self.tableView = [Common getPullTableWithFrame:self.view.frame style:UITableViewStylePlain hasRefresh:YES refreshSelector:@selector(refreshData) hasLoad:YES loadSelector:@selector(loadMoreData) target:self];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView.header beginRefreshing];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return SECTIONOFTABLEVIEW;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array_messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array_nib = [[NSBundle mainBundle]loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DEFAULTINDENTIFIER];
        cell = array_nib[0];
        NSDictionary *dic = self.array_messages[indexPath.row];
        UIButton *btn_nickname = (UIButton *)[cell viewWithTag:900001];
        btn_nickname.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn_nickname setTitle:[dic objectForKey:@"nickname"] forState:UIControlStateNormal];
        UITextView *view_text = (UITextView *)[cell viewWithTag:900002];
        view_text.text = [dic objectForKey:@"content"];
        UIButton *btn_like = (UIButton *)[cell viewWithTag:900003];
        [btn_like setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCount"]] forState:UIControlStateNormal];
        btn_like.tag = 700000 + indexPath.row;
        [btn_like addTarget:self action:@selector(sendMessageLike:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *btn_comment = (UIButton *)[cell viewWithTag:900004];
        btn_comment.tag = 800000 + indexPath.row;
        [btn_comment setTitle:[NSString stringWithFormat:@"%@", [dic objectForKey:@"commentCount"]] forState:UIControlStateNormal];
        [btn_comment addTarget:self action:@selector(gotoSendComment:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lb_date = (UILabel *)[cell viewWithTag:900005];
        lb_date.text = [dic objectForKey:@"time"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHTOFROW;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewCtrl = [[DetailViewController alloc]init];
    [detailViewCtrl.view setFrame:self.view.frame];
    detailViewCtrl.hidesBottomBarWhenPushed = YES;
    detailViewCtrl.message_id = [[self.array_messages[indexPath.row] objectForKey:@"id"] integerValue];
//    NSLog(@"%s || message_id: %@, indexPath.row: %@", __FUNCTION__, detailViewCtrl.message_id, indexPath);
    [detailViewCtrl getMessageDetail];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

- (void)gotoSend{
    SendViewController *sendViewCtrl = [[SendViewController alloc]init];
    [sendViewCtrl.view setFrame:self.view.frame];
    sendViewCtrl.isComment = NO;
    sendViewCtrl.string_navigationTitle = @"发布消息";
    sendViewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sendViewCtrl animated:YES];
}

- (void)gotoSendComment:(UIButton *)button{
    SendViewController *sendViewCtrl = [[SendViewController alloc]init];
    [sendViewCtrl.view setFrame:self.view.frame];
    sendViewCtrl.message_id = [[self.array_messages[(button.tag - 800000)]objectForKey:@"id"]integerValue];
    sendViewCtrl.isComment = YES;
    sendViewCtrl.string_navigationTitle = @"发表评论";
    sendViewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sendViewCtrl animated:YES];
}

- (void)sendMessageLike:(UIButton *)button{
    NSInteger message_id = [[self.array_messages[(button.tag - 700000)] objectForKey:@"id"] integerValue];
    [NetworkAPI sendLikeWithType:0 andParent_id:message_id andTarget:self andSelector:@selector(sendMessageLikeCallBack:)];
}

- (void)refreshData{
    self.currentPage = 0;
    self.array_messages = [NSMutableArray array];
    [NetworkAPI getMessageListWithPage:self.currentPage andTarget:self andSelector:@selector(getMessageListCallBack:)];
}

- (void)loadMoreData{
    [NetworkAPI getMessageListWithPage:self.currentPage andTarget:self andSelector:@selector(getMessageListCallBack:)];
}

- (void)getMessageListCallBack:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 返回数据：%@", __FUNCTION__, dic);
    if([[dic objectForKey:@"code"] isEqualToString:@"0000"]){
        NSArray *array_temp = [dic objectForKey:@"message"];
        for(NSDictionary *obj in array_temp){
//            NSLog(@"%s || %i", __FUNCTION__, self.currentPage);
            self.currentPage++;
            [self.array_messages addObject:obj];
        }
        [self.tableView reloadData];
    }else if([[dic objectForKey:@"code"] isEqualToString:@"0005"]){
        
    }
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

- (void)sendMessageLikeCallBack:(NSDictionary *)dic{
    NSLog(@"当前方法：%s || 返回数据：%@", __FUNCTION__, dic);
    if([[dic objectForKey:@"code"] isEqualToString:@"0000"]){
        [self.tableView.header refreshingAction];
    }
}

@end
