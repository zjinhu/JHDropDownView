//
//  UIImageView+LoadURL.m
//  IKToolsModule
//
//  Created by HU on 2018/8/3.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIImageView+LoadURL.h"
#import "UIColor+BaseUI.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (LoadURL)
 
- (void)imageWithURL:(NSString*)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)imageWithPlaceHolder:(NSString*)imageName
                    imageURL:(NSString*)imageURL {
     [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:imageName]];
}
- (void)imageCenterPlaceHolder:(UIImage*)imagePlaceHolder
                      imageURL:(NSString*)imageURL {
    self.clipsToBounds = YES;
    [self configImageView:imagePlaceHolder];
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            self.image = image;
            self.contentMode = UIViewContentModeScaleAspectFill;
            self.backgroundColor = [UIColor clearColor];
        }else{
            [self configImageView:imagePlaceHolder];
        }
    }];
}
-(void)configImageView:(UIImage*)imagePlaceHolder{
    self.backgroundColor = [UIColor baseNaviBackGroundColor];
    self.contentMode = UIViewContentModeCenter;
    self.image = imagePlaceHolder;
    if (CGRectGetWidth(self.frame)<imagePlaceHolder.size.width) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
}
@end
