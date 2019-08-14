//
//  UIControl+Block.h
//  AFNetworking
//
//  Created by HU on 2018/8/7.
//

#import <UIKit/UIKit.h>

@interface UIControl (Block)
- (void)addActionforControlEvents:(UIControlEvents)controlEvents Completion:(void (^)(void))completion;
@end
