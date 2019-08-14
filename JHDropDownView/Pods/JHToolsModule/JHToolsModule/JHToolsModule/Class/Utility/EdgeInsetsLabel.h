//
//  EdgeInsetsLabel.h
//  JHToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, EdgeInsetsLabelTextAlignment) {
    EdgeInsetsLabelTextAlignment_None, //default
    EdgeInsetsLabelTextAlignment_Top,
    EdgeInsetsLabelTextAlignment_Down,
};

@interface EdgeInsetsLabel : UILabel
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic, assign) EdgeInsetsLabelTextAlignment alignment;
@end
