//
//  YYButton.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/27.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYButton.h"

@implementation YYButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment  =NSTextAlignmentCenter;
    }
    return self;
}

-(void)setImageSize:(CGRect)imageSize{
    _imageSize = imageSize;
}
// 设置UIImageView的尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.imageSize.size.width>0) return _imageSize;
    else return contentRect;
}

-(void)setTitleSize:(CGRect)titleSize{
    _titleSize = titleSize;
}
//设置UIButton的title的尺寸
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (_titleSize.size.width)return _titleSize;
    else return contentRect;
}

-(UIButtonType)buttonType{
    return UIButtonTypeCustom;
}

@end
