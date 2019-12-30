//
//  YYRefreshGifHeader.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/4/15.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "MJRefreshGifHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYRefreshGifHeader : MJRefreshGifHeader

+(MJRefreshGifHeader *)yy_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end

NS_ASSUME_NONNULL_END
