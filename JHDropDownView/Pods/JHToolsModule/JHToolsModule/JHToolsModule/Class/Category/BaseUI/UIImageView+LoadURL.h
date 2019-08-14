//
//  UIImageView+LoadURL.h
//  IKToolsModule
//
//  Created by HU on 2018/8/3.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadURL)
- (void)imageWithURL:(NSString*)url;
- (void)imageWithPlaceHolder:(NSString*)imageName
                    imageURL:(NSString*)imageURL;
//手动设置占位图
- (void)imageCenterPlaceHolder:(UIImage*)imagePlaceHolder
                      imageURL:(NSString*)imageURL;
@end
