//
//  UIImageView+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIImageView+Masonry.h"

@implementation UIImageView (Masonry)
+(instancetype)masImageView{
    return [self masImageViewWithImage:nil];
}

+(instancetype)masImageViewWithImage:(id)image{
    return [self masImageViewWithImage:image SuperView:nil constraints:nil];
}

+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         constraints:(JHConstrainMaker)constraints{
    return [self masImageViewWithImage:image SuperView:superView constraints:constraints imgViewTap:nil];
}

+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         constraints:(JHConstrainMaker)constraints
                          imgViewTap:(JHTapGestureBlock)imgViewTap{
    return [self masImageViewWithImage:image SuperView:superView contentMode:UIViewContentModeScaleAspectFill isClip:YES constraints:constraints imgViewTap:imgViewTap];
}


+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         contentMode:(UIViewContentMode)contentMode
                              isClip:(BOOL)isClip
                         constraints:(JHConstrainMaker)constraints{
    return [self masImageViewWithImage:image SuperView:superView contentMode:contentMode isClip:isClip constraints:constraints imgViewTap:nil];
}

+(instancetype)masImageViewWithImage:(id)image
                           SuperView:(UIView *)superView
                         contentMode:(UIViewContentMode)contentMode
                              isClip:(BOOL)isClip
                         constraints:(JHConstrainMaker)constraints
                          imgViewTap:(JHTapGestureBlock)imgViewTap{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    if ([image isMemberOfClass:[NSString class]]) {
        UIImage *img = [UIImage imageNamed:image];
        imageView.image = img;
        
    }else if ([image isMemberOfClass:[UIImage class]]){
        
        imageView.image = image;
    }
    imageView.contentMode = contentMode;
    [superView addSubview:imageView];
    imageView.clipsToBounds = isClip;
    if (constraints && superView) {
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    if (imgViewTap) {
        
    }
    return imageView;
}

// 重新绘制图片,避免图层混合
+(UIImage *)masReDrawImage:(UIImage *)image size:(CGSize)size{
    if (!image) {
        return nil;
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [image drawInRect:rect];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return result;
}
@end
