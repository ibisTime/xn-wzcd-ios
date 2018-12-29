//
//  AccrssApplyDetailsVC.m
//  WenZhouCarLansB
//
//  Created by QinBao Zheng on 2018/9/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccrssApplyDetailsVC.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
#import "DetailsTableView1.h"
#import "DetailsTableView2.h"
#import "DetailsTableView3.h"
#import "DetailsTableView4.h"
#import "DetailsTableView5.h"
#import "DetailsTableView6.h"
#import "DetailsTableView7.h"
#import "DetailsTableView8.h"
#import "DetailsTableView9.h"
#import "DetailsTableView10.h"
@interface AccrssApplyDetailsVC ()<UIScrollViewDelegate,RefreshDelegate>
{
    NSInteger selectTableViewTag;
    NSInteger selectSection;
    //银行数组
    NSArray *bankRateListArray;

    NSInteger selectCell;

    NSIndexPath *ReloadIndexPath;

}
@property (nonatomic, assign)NSInteger currentPages;
@property (nonatomic, assign)NSInteger selectRow;
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)NSArray *dvalueArray;
@property (nonatomic, strong)UIButton *titleBtn;

@property (nonatomic, strong)DetailsTableView1 *tableView1;
@property (nonatomic, strong)DetailsTableView2 *tableView2;
@property (nonatomic, strong)DetailsTableView3 *tableView3;
@property (nonatomic, strong)DetailsTableView4 *tableView4;
@property (nonatomic, strong)DetailsTableView5 *tableView5;
@property (nonatomic, strong)DetailsTableView6 *tableView6;
@property (nonatomic, strong)DetailsTableView7 *tableView7;
@property (nonatomic, strong)DetailsTableView8 *tableView8;
@property (nonatomic, strong)DetailsTableView9 *tableView9;
@property (nonatomic, strong)DetailsTableView10 *tableView10;
@end

@implementation AccrssApplyDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dvalueArray = @[@"预算单申请",@"职业与收入情况",@"资产情况",@"紧急联系人",@"其他情况",@"费用情况",@"贷款材料",@"家访材料",@"企业照片",@"其他材料"];
    [self navigativeView];
    [self initScrollView];
    [self initTableView1];
    [self initTableView2];
    [self initTableView3];
    [self initTableView4];
    [self initTableView5];
    [self initTableView6];
    [self initTableView7];
    [self initTableView8];
    [self initTableView9];
    [self initTableView10];

    bankRateListArray = self.model.bankSubbranch[@"bank"][@"bankRateList"];
}


-(void)initScrollView
{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 10, SCREEN_HEIGHT - kNavigationBarHeight);
    [self.view addSubview:_scroll];
    self.currentPages = 0;
}

-(void)navigativeView
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
    self.RightButton.titleLabel.font = HGfont(18);
    [self.LeftBackbButton addTarget:self action:@selector(leftButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"下一页" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    _titleBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor whiteColor] backgroundColor:kClearColor titleFont:18];
    _titleBtn.frame = CGRectMake(0, 0, 150, 44);
    [_titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = _titleBtn;
    [self titleBtnCustom];

}

-(void)leftButtonClick
{
    if (self.currentPages == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * (self.currentPages - 1);
    self.selectRow = self.currentPages - 1;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}

-(void)titleBtnClick
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < _dvalueArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_dvalueArray[i]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);

            SelectedListModel *model = array[0];
            CGRect frame;
            self.selectRow = model.sid;
            frame.origin.x = self.scroll.frame.size.width * (model.sid);
            frame.origin.y = 0;
            frame.size = self.scroll.frame.size;
            [self.scroll scrollRectToVisible:frame animated:YES];
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}

-(void)rightButtonClick
{
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * (self.currentPages + 1);
    self.selectRow = self.currentPages + 1;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    NSLog(@"%ld",self.currentPages);
    self.selectRow = self.currentPages;
    [self titleBtnCustom];
}

-(void)titleBtnCustom
{
    [_titleBtn setTitle:_dvalueArray[self.selectRow] forState:(UIControlStateNormal)];
    [_titleBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
    }];
    if (self.currentPages == 0) {
        [self.LeftBackbButton setTitle:@"" forState:(UIControlStateNormal)];
        [self.LeftBackbButton setImage:HGImage(@"返回") forState:(UIControlStateNormal)];
    }else
    {

        [self.LeftBackbButton setTitle:@"上一页" forState:(UIControlStateNormal)];
        [self.LeftBackbButton setImage:HGImage(@"") forState:(UIControlStateNormal)];
    }

    if (self.currentPages == 9)
        {
        self.RightButton.hidden=YES;
    }else
    {
        self.RightButton.hidden=NO;
        [self.RightButton setTitle:@"下一页" forState:(UIControlStateNormal)];
    }
}

- (void)initTableView1 {

    self.tableView1 = [[DetailsTableView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView1.refreshDelegate = self;
    self.tableView1.backgroundColor = kBackgroundColor;
    self.tableView1.tag = 100;
    self.tableView1.model = self.model;
    [self.scroll addSubview:self.tableView1];
}
- (void)initTableView2 {
    self.tableView2 = [[DetailsTableView2 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView2.refreshDelegate = self;
    self.tableView2.backgroundColor = kBackgroundColor;
    self.tableView2.tag = 101;
    self.tableView2.model = self.model;
    [self.scroll addSubview:self.tableView2];
}



- (void)initTableView3 {

    self.tableView3 = [[DetailsTableView3 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView3.refreshDelegate = self;
    self.tableView3.backgroundColor = kBackgroundColor;
    self.tableView3.tag = 102;
    self.tableView3.model = self.model;
    [self.scroll addSubview:self.tableView3];
}
- (void)initTableView4 {
    self.tableView4 = [[DetailsTableView4 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView4.refreshDelegate = self;
    self.tableView4.backgroundColor = kBackgroundColor;
    self.tableView4.tag = 103;
    self.tableView4.model = self.model;
    [self.scroll addSubview:self.tableView4];
}
- (void)initTableView5 {
    self.tableView5 = [[DetailsTableView5 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 4, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView5.refreshDelegate = self;
    self.tableView5.backgroundColor = kBackgroundColor;
    self.tableView5.tag = 104;
    self.tableView5.model = self.model;
    [self.scroll addSubview:self.tableView5];
}
- (void)initTableView6 {
    self.tableView6 = [[DetailsTableView6 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 5, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView6.refreshDelegate = self;
    self.tableView6.backgroundColor = kBackgroundColor;
    self.tableView6.tag = 105;
    self.tableView6.model = self.model;
    [self.scroll addSubview:self.tableView6];
}
- (void)initTableView7 {
    self.tableView7 = [[DetailsTableView7 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 6, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView7.refreshDelegate = self;
    self.tableView7.backgroundColor = kBackgroundColor;
    self.tableView7.tag = 106;
    self.tableView7.model = self.model;
    [self.scroll addSubview:self.tableView7];
}
- (void)initTableView8 {
    self.tableView8 = [[DetailsTableView8 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 7, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView8.refreshDelegate = self;
    self.tableView8.backgroundColor = kBackgroundColor;
    self.tableView8.tag = 107;
    self.tableView8.model = self.model;
    [self.scroll addSubview:self.tableView8];
}
- (void)initTableView9 {
    self.tableView9 = [[DetailsTableView9 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 8, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView9.refreshDelegate = self;
    self.tableView9.backgroundColor = kBackgroundColor;
    self.tableView9.tag = 108;
    self.tableView9.model = self.model;
    [self.scroll addSubview:self.tableView9];
}
- (void)initTableView10 {
    self.tableView10 = [[DetailsTableView10 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 9, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView10.refreshDelegate = self;
    self.tableView10.backgroundColor = kBackgroundColor;
    self.tableView10.tag = 109;
    self.tableView10.model = self.model;
    [self.scroll addSubview:self.tableView10];
}


@end
