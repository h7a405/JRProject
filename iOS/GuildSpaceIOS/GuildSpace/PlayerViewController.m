//
//  PlayerViewController.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/19.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "PlayerViewController.h"
#import "Common.h"

#define NUMBERSOFSECTION 4
#define ROWSOFSECTIONONE 2
#define ROWSOFSECTIONTWO 3
#define ROWSOFSECTIONTHREE 1
#define ROWSOFSECTIONFOUR 2
#define HEIGHTOFSECTIONONE 48
#define HEIGHTOFSECTIONDEFAULT 46
#define DEFAULT_CELLIDENTIFIER @"CELL"
#define FIRSTROW_CELLIDENTIFIER @"FIRST"

@interface PlayerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
//@property(nonatomic, strong)PlayerTopView *topView;
//@property(nonatomic, assign)BOOL isLoading;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationController setNavigationBarHidden:YES];
    
//    UIView *statusBarView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 20)];
//    statusBarView.backgroundColor = [Common getColorWithRGB:0x66CCFF];
//    [statusBarView setAlpha:0.85];
//    [self.view addSubview:statusBarView];
    
//    self.isLoading = NO;
    [self.navigationController.navigationBar setBarTintColor:[Common getColorWithRGB:0x66ccff]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.navigationItem.title = @"我的";

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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
//    self.tableView = [Common getPullTableWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped hasRefresh:NO hasLoad:NO target:self selector:@selector(loadNewData)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.topView.backgroundColor = [Common getColorWithRGB:0x66ccff];
//    [self.topView setAlpha:0.8];
//    [self.topView setupTopViewWithStatus:NO];
//    self.topView.navCtrl = self.navigationController;
    self.tableView.tableHeaderView = topView;
//    [self.tableView setScrollEnabled:NO];
    [self.view addSubview:self.tableView];
    
//    [self connectionTest];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return NUMBERSOFSECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return ROWSOFSECTIONONE;
            break;
        case 1:
            return ROWSOFSECTIONTWO;
            break;
        case 2:
            return ROWSOFSECTIONTHREE;
            break;
        case 3:
            return ROWSOFSECTIONFOUR;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return HEIGHTOFSECTIONONE;
    }else
    return HEIGHTOFSECTIONDEFAULT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DEFAULT_CELLIDENTIFIER];
    UITableViewCell *cell;
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:FIRSTROW_CELLIDENTIFIER];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:DEFAULT_CELLIDENTIFIER];
    }
    if(!cell){
        switch (indexPath.section) {
            case 0:
//                cell = [[PlayerTopView alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FIRSTROW_CELLIDENTIFIER];
//                [(PlayerTopView *)cell setupTopViewWithStatus:NO andHeight:HEIGHTOFSECTIONONE];
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DEFAULT_CELLIDENTIFIER];
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"当前昵称：";
                        cell.detailTextLabel.text = @"点击更改";
                        break;
                    case 1:
                        cell.textLabel.text = @"未绑定手机";
                        cell.detailTextLabel.text = @"立即绑定";
                        break;
                    default:
                        break;
                }
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                break;
            case 1:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DEFAULT_CELLIDENTIFIER];
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"我的发布";
                        break;
                    case 1:
                        cell.textLabel.text = @"我的评论";
                        break;
                    case 2:
                        cell.textLabel.text = @"我的喜欢";
                        break;
                    default:
                        break;
                }
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                break;
            case 2:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DEFAULT_CELLIDENTIFIER];
                cell.textLabel.text = @"设置";
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                break;
            case 3:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DEFAULT_CELLIDENTIFIER];
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"关于";
                        break;
                    case 1:
                        cell.textLabel.text = @"建议与反馈";
                        break;
                    default:
                        break;
                }
                
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                break;
            default:
                break;
        }
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LoginViewController *loginViewCtrl = [[LoginViewController alloc]init];
//    [self.navigationController pushViewController:loginViewCtrl animated:YES];
//    [[DropDownNotification sharedDropDown]showWithTitle:@"test" nadAnimated:YES];
//    [[DropDownNotification sharedDropDown]showWithCover:NO andAnimated:YES];
//    [NetworkAPI connectingTestWithTarget:self andSelector:@selector(connectingTestCallBack:)];
}

- (void)connectingTestCallBack:(NSDictionary *)dic{
    NSLog(@"%s || dic:%@", __FUNCTION__, dic);
}

@end
