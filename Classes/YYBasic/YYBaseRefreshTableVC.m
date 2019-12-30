//
//  YYBaseRefreshTableVC.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/28.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYBaseRefreshTableVC.h"
#import "YYRefreshGifHeader.h"
#import "YYRefreshBackGifFooter.h"
@interface YYBaseRefreshTableVC ()

@end

@implementation YYBaseRefreshTableVC

-(UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, YYScreenWidth, _tabH)];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    return _footerView;
}

-(NSMutableArray *)dataSouce{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    _heightNav = YYHeight_NavBar();
    _showRefreshHeader = NO;
    _showRefreshFooter = NO;
    _tabH = YYIS_IPHONE_X()==YES?34:0;
    self.heightTab = YYIS_IPHONE_X()==YES?83:50;
}

#pragma mark - setter
- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
            __weak typeof(self) weakSelf = self;
            self.tableView.mj_header = [YYRefreshGifHeader yy_headerWithRefreshingBlock:^{
                [weakSelf yy_tableViewDidTriggerHeaderRefresh];
            }];
            self.tableView.mj_header.accessibilityIdentifier = @"refresh_header";
        }else{
            [self.tableView setMj_header:nil];
        }
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
            __weak typeof(self) weakSelf = self;
            self.tableView.mj_footer = [YYRefreshBackGifFooter yy_footerWithRefreshingBlock:^{
                [weakSelf yy_tableViewDidTriggerFooterRefresh];
            }];
            self.tableView.mj_footer.accessibilityIdentifier = @"refresh_footer";
        }else{
            [self.tableView setMj_footer:nil];
        }
    }
}

//- (void)zq_tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload haveMore:(BOOL)more
//{
//    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (reload) {
//            [weakSelf.tableView reloadData];
//        }
//
//        if (isHeader) {
//            [weakSelf.tableView.mj_header endRefreshing];
//        }
//        else{
//            if (more) {
//                [weakSelf.tableView.mj_footer endRefreshing];
//            }else{
//                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
//            }
//        }
//    });
//}

- (void)yy_tableViewDidTriggerHeaderRefresh{
    
}

- (void)yy_tableViewDidTriggerFooterRefresh{
    
}
-(void)dealloc{
    
}

@end
