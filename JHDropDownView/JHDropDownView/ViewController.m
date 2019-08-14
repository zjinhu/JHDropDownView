//
//  ViewController.m
//  JHDropDownView
//
//  Created by 张金虎 on 2019/8/14.
//  Copyright © 2019 张金虎. All rights reserved.
//

#import "ViewController.h"
#import "JHDropDownView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self setRightBarButtonWithText:@"导航栏下弹出"];
    [self.rightBarButton addActionforControlEvents:UIControlEventTouchUpInside Completion:^{

        [weakSelf dropView:NAVIGATION_BAR_HEIGHT];
    }];
    
    
    UIButton *button = [UIButton masButtonWithTitle:@"视图下弹出"
                                         titleColor:[UIColor blackColor]
                                          backColor:[UIColor yellowColor]
                                           fontSize:18
                                             weight:UIFontWeightBold
                                       cornerRadius:0
                                            supView:self.view
                                        constraints:^(MASConstraintMaker *make) {
                                            make.top.left.right.equalTo(self.view);
                                            make.height.mas_equalTo(50);
                                        } touchUp:^(id sender) {
                                            
                                            [weakSelf dropView:NAVIGATION_BAR_HEIGHT+50];
                                        }];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor]] forState:UIControlStateHighlighted];
    
    [UILabel masLabelWithFontSize:20
                            lines:0
                             text:@"下拉菜单，可以遮盖tabbar\n不影响上边的视图按钮点击"
                        superView:self.view
                      constraints:^(MASConstraintMaker *make) {
                          make.center.equalTo(self.view);
                      }];
}

-(void)dropView:(CGFloat)hright{
    if ([JHDropDownView hasDropDown]) {
        [JHDropDownView hideDropDown];
        return;
    }
    UIView *imgView = [[UIView alloc] init];
    imgView.backgroundColor = [UIColor cyanColor];
    imgView.jh_size = CGSizeMake(SCREEN_WIDTH, 300);
    [JHDropDownView coverTabbar:imgView fromY:hright canClick:YES
                      showBlock:^{
                          NSLog(@"show");
                      }
                      hideBlock:^{
                          NSLog(@"hide");
                      }];
}
@end
