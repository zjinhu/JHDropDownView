//
//  JHBaseViewController.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//
#define KNavigationBarButtonHeight 40
#import "JHToolsDefine.h"
#import "JHBaseViewController.h"
#import "BaseUI.h"
#import "EasyShow.h" 
@interface JHBaseViewController ()

@end

@implementation JHBaseViewController

-(UIRectEdge)preferredScreenEdgesDeferringSystemGestures{
    return UIRectEdgeAll;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //判断是否二次展示页面
//    if ([self isBeingPresented] || [self isMovingToParentViewController]) {
//        // push / present
//        NSLog(@"OneViewController push / present");
//    } else {
//        NSLog(@"OneViewController pop");
//        // pop to here
//    }
//    [self showLoading];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count==1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBackBarButton];
    [self.leftBarButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  返回上一级页面
 */
- (void)goBack{
    if (self.navigationController &&self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  设置导航默认返回按钮
 */
- (void)setLeftBackBarButton{
    
    _leftBarButton = [[UIButton alloc] init];
    
    [_leftBarButton setImage:[UIImage loadImageNamed:@"nav_ic_back"] forState:UIControlStateHighlighted];
    [_leftBarButton setImage:[UIImage loadImageNamed:@"nav_ic_back"] forState:UIControlStateNormal];
    _leftBarButton.frame = CGRectMake(0, 0, KNavigationBarButtonHeight, KNavigationBarButtonHeight);
    
    [_leftBarButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftBarButton.contentEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}
/**
 *  设置导航左侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setLeftBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage{
    
    _leftBarButton                        = [[UIButton alloc] init];
    _leftBarButton.frame                  = CGRectMake(0, 0, KNavigationBarButtonHeight, KNavigationBarButtonHeight);
    [_leftBarButton setImage:normalImage forState:UIControlStateNormal];
    [_leftBarButton setImage:highLightImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftBarButton.contentEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}

/**
 *  设置导航左侧按钮文本
 *
 *  @param text 导航按钮文本
 */
- (void)setLeftBarButtonWithText:(NSString *)text{
    
    CGSize buttonSize                     = [text getSizeWithFont:Font(16)];
    _leftBarButton                        = [[UIButton alloc] init];
    _leftBarButton.frame                  = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    _leftBarButton.titleLabel.font        = Font(16);
    [_leftBarButton setTitle:text forState:UIControlStateNormal];
    [_leftBarButton setTitle:text forState:UIControlStateHighlighted];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextColor forState:UIControlStateNormal];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextHighLightColor forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}
- (void)setLeftBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage AndText:(NSString *)text{
    CGSize textSize = [text getSizeWithFont:Font(15)];
    CGFloat height = normalImage.size.height > textSize.height ? normalImage.size.height : textSize.height;
    CGFloat width = textSize.width + normalImage.size.width + 8;
    _leftBarButton                        = [[UIButton alloc] init];
    _leftBarButton.frame                  = CGRectMake(0, 0, width, height);
    _leftBarButton.titleLabel.font        = Font(15);
    [_leftBarButton setImage:normalImage forState:UIControlStateNormal];
    [_leftBarButton setImage:highLightImage forState:UIControlStateHighlighted];
    [_leftBarButton setTitle:text forState:UIControlStateNormal];
    [_leftBarButton setTitle:text forState:UIControlStateHighlighted];
    
    //    [_leftBarButton setTitleColor:BaseNaviBarTextColor forState:UIControlStateNormal];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextColor forState:UIControlStateHighlighted];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextDisableColor forState:UIControlStateDisabled];
    //    _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6);
    //    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    //    self.navigationItem.leftBarButtonItem = leftButtonItem;
    //
    //    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    space.width = -4;
    //    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space,leftButtonItem, nil];
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftBarButton.contentEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}
/**
 *  设置导航右侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setRightBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage{
    
    _rightBarButton                        = [[UIButton alloc] init];
    _rightBarButton.frame                  = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    [_rightBarButton setImage:normalImage forState:UIControlStateNormal];
    [_rightBarButton setImage:highLightImage forState:UIControlStateHighlighted];
    UIBarButtonItem *rightButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -4;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space,rightButtonItem, nil];
}
/**
 *  设置导航右侧按钮文本
 *
 *  @param text 导航按钮文本
 */
- (void)setRightBarButtonWithText:(NSString *)text{
    
    CGSize buttonSize                      = [text getSizeWithFont:Font(16)];
    _rightBarButton                        = [[UIButton alloc] init];
    _rightBarButton.frame                  = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    _rightBarButton.titleLabel.font        = Font(16);
    [_rightBarButton setTitle:text forState:UIControlStateNormal];
    [_rightBarButton setTitle:text forState:UIControlStateHighlighted];
    [_rightBarButton setTitleColor:[UIColor baseTextColor] forState:UIControlStateNormal];
    [_rightBarButton setTitleColor:[UIColor baseTextGrayColor]  forState:UIControlStateHighlighted];
    UIBarButtonItem *rightButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -4;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space,rightButtonItem, nil];
}

- (void)showToast:(NSString *)msg{
    [EasyShow showText:msg];
}

-(void)showLoading{
    [EasyShow showLoading];
}

-(void)hideLoading{
    [EasyShow hidenLoading];
}

-(void)dealloc{
    [EasyShow hidenLoading];
}

@end
