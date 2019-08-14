//
//  JHDropDownView.m
//  JHDropDownView
//
//  Created by 张金虎 on 2019/8/14.
//  Copyright © 2019 张金虎. All rights reserved.
//

#import "JHDropDownView.h"
static JHDropDownView   *_dropDown;       // 遮罩
static UIView           *_fromView;       // 显示在此视图上
static UIView           *_contentView;    // 显示的视图
static dispatch_block_t _showBlock;       // 显示时的回调block
static dispatch_block_t _hideBlock;       // 隐藏时的回调block
static BOOL             _canClick;        // 是否能点击的判断
static BOOL             _hasDropDown;        // 遮罩是否已经显示的判断值
@implementation JHDropDownView

- (instancetype)init{
    self = [super init];
    if (self) {
        // 自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

+ (instancetype)dropDown{
    _hasDropDown = YES;
    return [[self alloc] init];
}

+ (void)coverTabbar:(UIView *)contentView
              fromY:(CGFloat)fromY
           canClick:(BOOL)canClick
          showBlock:(dispatch_block_t)showBlock
          hideBlock:(dispatch_block_t)hideBlock{
    if ([self hasDropDown]) return;
    
    UIView *coverView = [UIView new];
    coverView.frame = CGRectMake(0, fromY, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - fromY);
    coverView.backgroundColor = [UIColor clearColor];
    coverView.clipsToBounds = YES;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:coverView];
    
    _fromView      = coverView;
    _contentView   = contentView;
    _canClick     = canClick;
    _showBlock     = showBlock;
    _hideBlock     = hideBlock;
    
    // 创建遮罩
    JHDropDownView *dropDown = [self dropDown];
    // 设置大小和颜色
    dropDown.frame = coverView.bounds;
    // 添加遮罩
    [coverView addSubview:dropDown];
    _dropDown = dropDown;
    
    [self setupTranslucentCover:dropDown];
    
    [self showDropDown];
}

+ (void)showDropDown {
    [_fromView addSubview:_contentView];
    _contentView.jh_centerX = _fromView.jh_centerX;
    _contentView.jh_top = -_contentView.jh_height;
    
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.jh_top = 0;
    }completion:^(BOOL finished) {
        !_showBlock ? : _showBlock();
    }];
}

+ (void)hideDropDown {
    // 这里为了防止动画未完成导致的不能及时判断cover是否存在，实际上cover再这里并没有销毁
    _hasDropDown = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.jh_top = -_contentView.jh_height;
    }completion:^(BOOL finished) {
        [self remove];
    }];
    
}
+ (void)remove{
    [_dropDown removeFromSuperview];
    [_contentView removeFromSuperview];
    [_fromView removeFromSuperview];
    _dropDown       = nil;
    _fromView    = nil;
    _contentView = nil;
    
    // 隐藏block放到最后，修复多个cover不能隐藏的bug
    !_hideBlock ? : _hideBlock();
}
/**
 半透明遮罩
 */
+ (void)setupTranslucentCover:(UIView *)cover{
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.2;
    [self coverAddTap:cover];
}

+ (void)coverAddTap:(UIView *)cover{
    if (_canClick) {
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDropDown)]];
    }
}

+ (BOOL)hasDropDown{
    return _hasDropDown;
}
@end
