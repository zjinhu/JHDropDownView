//
//  UITextView+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UITextView+Masonry.h"
#import <objc/runtime.h>

// 占位文字
static const void *MASPlaceholderViewKey = &MASPlaceholderViewKey;
// 占位文字颜色
static const void *MASPlaceholderColorKey = &MASPlaceholderColorKey;
// 最大高度
static const void *MASTextViewMaxHeightKey = &MASTextViewMaxHeightKey;
// 最小高度
static const void *MASTextViewMinHeightKey = &MASTextViewMinHeightKey;
// 高度变化的block
static const void *MASTextViewHeightDidChangedBlockKey = &MASTextViewHeightDidChangedBlockKey;
// 存储添加的图片
static const void *MASTextViewImageArrayKey = &MASTextViewImageArrayKey;
// 存储最后一次改变高度后的值
static const void *MASTextViewLastHeightKey = &MASTextViewLastHeightKey;

@interface UITextView ()
// 存储添加的图片
@property (nonatomic, strong) NSMutableArray *masImageArray;
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;

@end

@implementation UITextView (Masonry)

+(instancetype)masTextViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints{
    return [self masTextViewWithFontSize:fontSize textColor:textColor borderColor:nil borderWidth:0 cornerRadiu:0 placeColor:placeColor placeText:placeText superView:superView constraints:constraints];
}

+(instancetype)masTextViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                           borderColor:(UIColor *)borderColor
                           borderWidth:(CGFloat)borderWidth
                           cornerRadiu:(CGFloat)cornerRadiu
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints{
    UITextView *textView = [[UITextView alloc]init];
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textColor = textColor;
    [textView masTextViewsSetPlaceholderWithText:placeText Color:placeColor];
    textView.layer.borderColor = borderColor.CGColor;
    textView.layer.borderWidth = borderWidth;
    textView.layer.cornerRadius = cornerRadiu;
    
    
    if (superView && constraints) {
        [superView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    
    return textView;
}



+(void)load{
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method mas_setFontMethod =class_getInstanceMethod(self, @selector(mas_setFont:));
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, mas_setFontMethod);
    
    Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
    Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
    method_exchangeImplementations(dealoc, myDealloc);
    
}

-(void)masTextViewsSetPlaceholderWithText:(NSString *)text Color:(UIColor *)color{
    //多余 强指针换了指向以后label自动销毁
    //防止重复设置 cell复用等问题
    //    for (UIView *view in self.subviews) {
    //        if ([view isKindOfClass:[UILabel class]]) {
    //            [view removeFromSuperview];
    //        }
    //    }
    
    //设置占位label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = self.font;
    label.textColor = color;
    label.numberOfLines = 0;
    [self addSubview:label];
    [self setValue:label forKey:@"_placeholderLabel"];
}
- (void)masTextViewsSetPlaceholderWithAttributedText:(NSAttributedString *)attributedPlaceholder{
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributedPlaceholder;
    label.numberOfLines = 0;
    [self addSubview:label];
    [self setValue:label forKey:@"_placeholderLabel"];
}
- (void)mas_setFont:(UIFont *)font{
    //调用原方法 setFont:
    [self mas_setFont:font];
    //设置占位字符串的font
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.font = font;
    NSLog(@"%s", __func__);
}


- (void)myDealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UITextView *placeholderView = objc_getAssociatedObject(self, MASPlaceholderViewKey);
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        for (NSString *property in propertys) {
            @try {
                [self removeObserver:self forKeyPath:property];
            } @catch (NSException *exception) {}
        }
    }
    [self myDealloc];
}

#pragma mark - set && get
- (UITextView *)masPlaceholderView {
    // 为了让占位文字和textView的实际文字位置能够完全一致，这里用UITextView
    UITextView *placeholderView = objc_getAssociatedObject(self, MASPlaceholderViewKey);
    if (!placeholderView) {
        // 初始化数组
        self.masImageArray = [NSMutableArray array];
        
        placeholderView = [[UITextView alloc] init];
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, MASPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholderView = placeholderView;
        // 设置基本属性
        placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
        //        self.scrollEnabled = placeholderView.scrollEnabled = placeholderView.showsHorizontalScrollIndicator = placeholderView.showsVerticalScrollIndicator = placeholderView.userInteractionEnabled = NO;
        placeholderView.textColor = [UIColor lightGrayColor];
        placeholderView.backgroundColor = [UIColor clearColor];
        [self refreshPlaceholderView];
        [self addSubview:placeholderView];
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
        // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        // 监听属性
        for (NSString *property in propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return placeholderView;
}

- (void)setMasPlaceholder:(NSString *)masPlaceholder{
    // 为placeholder赋值
    [self masPlaceholderView].text = masPlaceholder;
}

- (NSString *)masPlaceholder{
    // 如果有placeholder值才去调用，这步很重要
    if (self.placeholderExist) {
        return [self masPlaceholderView].text;
    }
    return nil;
}

- (void)setMasPlaceholderColor:(UIColor *)masPlaceholderColor{
    // 如果有placeholder值才去调用，这步很重要
    if (!self.placeholderExist) {
        NSLog(@"请先设置placeholder值！");
    } else {
        self.masPlaceholderView.textColor = masPlaceholderColor;
        
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, MASPlaceholderColorKey, masPlaceholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)masPlaceholderColor{
    return objc_getAssociatedObject(self, MASPlaceholderColorKey);
}

- (void)setMasMaxHeight:(CGFloat)masMaxHeight{
    CGFloat max = masMaxHeight;
    // 如果传入的最大高度小于textView本身的高度，则让最大高度等于本身高度
    if (masMaxHeight < self.frame.size.height) {
        max = self.frame.size.height;
    }
    objc_setAssociatedObject(self, MASTextViewMaxHeightKey, [NSString stringWithFormat:@"%lf", max], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)masMaxHeight{
    return [objc_getAssociatedObject(self, MASTextViewMaxHeightKey) doubleValue];
}

- (void)setMasMinHeight:(CGFloat)masMinHeight{
    objc_setAssociatedObject(self, MASTextViewMinHeightKey, [NSString stringWithFormat:@"%lf", masMinHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)masMinHeight{
    return [objc_getAssociatedObject(self, MASTextViewMinHeightKey) doubleValue];
}

- (void)setMasTextViewHeightDidChanged:(TextViewHeightDidChangedBlock)masTextViewHeightDidChanged{
    objc_setAssociatedObject(self, MASTextViewHeightDidChangedBlockKey, masTextViewHeightDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TextViewHeightDidChangedBlock)masTextViewHeightDidChanged{
    void(^textViewHeightDidChanged)(CGFloat currentHeight) = objc_getAssociatedObject(self, MASTextViewHeightDidChangedBlockKey);
    return textViewHeightDidChanged;
}

- (NSArray *)masGetImages{
    return self.masImageArray;
}

- (void)setLastHeight:(CGFloat)lastHeight{
    objc_setAssociatedObject(self, MASTextViewLastHeightKey, [NSString stringWithFormat:@"%lf", lastHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)lastHeight{
    return [objc_getAssociatedObject(self, MASTextViewLastHeightKey) doubleValue];
}

- (void)setMasImageArray:(NSMutableArray *)masImageArray{
    objc_setAssociatedObject(self, MASTextViewImageArrayKey, masImageArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)masImageArray{
    return objc_getAssociatedObject(self, MASTextViewImageArrayKey);
}

- (void)masAutoHeightWithMaxHeight:(CGFloat)maxHeight{
    [self masAutoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:nil];
}
// 是否启用自动高度，默认为NO
static bool autoHeight = NO;
- (void)masAutoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(TextViewHeightDidChangedBlock)textViewHeightDidChanged{
    autoHeight = YES;
    [self masPlaceholderView];
    self.masMaxHeight = maxHeight;
    if (textViewHeightDidChanged) self.masTextViewHeightDidChanged = textViewHeightDidChanged;
}

#pragma mark - addImage
/* 添加一张图片 */
- (void)masAddImage:(UIImage *)image{
    [self masAddImage:image size:CGSizeZero];
}

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)masAddImage:(UIImage *)image size:(CGSize)size{
    [self masInsertImage:image size:size index:self.attributedText.length > 0 ? self.attributedText.length : 0];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)masInsertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index{
    [self masAddImage:image size:size index:index multiple:-1];
}

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)masAddImage:(UIImage *)image multiple:(CGFloat)multiple{
    [self masAddImage:image size:CGSizeZero index:self.attributedText.length > 0 ? self.attributedText.length : 0 multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)masInsertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index{
    [self masAddImage:image size:CGSizeZero index:index multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 multiple:放大／缩小的倍数 */
- (void)masAddImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index multiple:(CGFloat)multiple {
    if (image) [self.masImageArray addObject:image];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    CGRect bounds = textAttachment.bounds;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        bounds.size = size;
        textAttachment.bounds = bounds;
    } else if (multiple <= 0) {
        CGFloat oldWidth = textAttachment.image.size.width;
        CGFloat scaleFactor = oldWidth / (self.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    } else {
        bounds.size = image.size;
        textAttachment.bounds = bounds;
    }
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(index, 0) withAttributedString:attrStringWithImage];
    self.attributedText = attributedString;
    [self textViewTextChange];
    [self refreshPlaceholderView];
}

#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self refreshPlaceholderView];
    if ([keyPath isEqualToString:@"text"]) [self textViewTextChange];
}

// 刷新PlaceholderView
- (void)refreshPlaceholderView {
    UITextView *placeholderView = objc_getAssociatedObject(self, MASPlaceholderViewKey);
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.masPlaceholderView.frame = self.bounds;
        if (self.masMaxHeight < self.bounds.size.height) self.masMaxHeight = self.bounds.size.height;
        self.masPlaceholderView.font = self.font;
        self.masPlaceholderView.textAlignment = self.textAlignment;
        self.masPlaceholderView.textContainerInset = self.textContainerInset;
        self.masPlaceholderView.hidden = (self.text.length > 0 && self.text);
    }
}

// 处理文字改变
- (void)textViewTextChange {
    UITextView *placeholderView = objc_getAssociatedObject(self, MASPlaceholderViewKey);
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.masPlaceholderView.hidden = (self.text.length > 0 && self.text);
    }
    // 如果没有启用自动高度，不执行以下方法
    if (!autoHeight) return;
    if (self.masMaxHeight >= self.bounds.size.height) {
        // 计算高度
        NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        // 如果高度有变化，调用block
        if (currentHeight != self.lastHeight) {
            // 是否可以滚动
            self.scrollEnabled = currentHeight >= self.masMaxHeight;
            CGFloat currentTextViewHeight = currentHeight >= self.masMaxHeight ? self.masMaxHeight : currentHeight;
            // 改变textView的高度
            if (currentTextViewHeight >= self.masMinHeight) {
                CGRect frame = self.frame;
                frame.size.height = currentTextViewHeight;
                self.frame = frame;
                // 调用block
                if (self.masTextViewHeightDidChanged) self.masTextViewHeightDidChanged(currentTextViewHeight);
                // 记录当前高度
                self.lastHeight = currentTextViewHeight;
            }
        }
    }
    if (!self.isFirstResponder) [self becomeFirstResponder];
}

// 判断是否有placeholder值，这步很重要
- (BOOL)placeholderExist {
    // 获取对应属性的值
    UITextView *placeholderView = objc_getAssociatedObject(self, MASPlaceholderViewKey);
    // 如果有placeholder值
    if (placeholderView) return YES;
    return NO;
}

@end
