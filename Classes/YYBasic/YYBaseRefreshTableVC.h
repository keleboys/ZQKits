//
//  YYBaseRefreshTableVC.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/28.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
NS_ASSUME_NONNULL_BEGIN

@interface YYBaseRefreshTableVC : UIViewController
@property (nonatomic , strong) UITableView           *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSouce;
/** @brief 是否启用下拉加载更多，默认为NO */
@property (nonatomic) BOOL showRefreshHeader;
/** @brief 是否启用上拉加载更多，默认为NO */
@property (nonatomic) BOOL showRefreshFooter;
/** @brief 导航条高度 */
@property (nonatomic, assign) float heightNav;
/** @brief tabber高度  */
@property (nonatomic, assign) float heightTab;

@property (nonatomic, assign) float tabH;
/**  */
@property (nonatomic, assign) NSInteger       page;
/** 总分页数 */
@property (nonatomic, assign) NSInteger       total_Page;
/**  */
@property (nonatomic, strong) UIView *footerView;
/*!
 @method
 @brief 下拉加载更多(下拉刷新)
 */
- (void)yy_tableViewDidTriggerHeaderRefresh;
/*!
 @method
 @brief 上拉加载更多
 */
- (void)yy_tableViewDidTriggerFooterRefresh;
/*!
 @method
 @brief 加载结束
 @discussion 加载结束后，通过参数reload来判断是否需要调用tableView的reloadData，判断isHeader来停止加载
 @param isHeader   是否结束下拉加载(或者上拉加载)
 @param reload     是否需要重载TabeleView
 @param more   是否还有数据
 */
//- (void)zq_tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload haveMore:(BOOL)more;
/*!
 @method
 @string 没有数据需要提示的话
 */
//-(void)noDateSouceAlertView:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
