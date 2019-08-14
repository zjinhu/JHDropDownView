//
//  UILabel+AttributeClick.m
//  IKToolsModule
//
//  Created by 狄烨 . on 2018/11/28.
//  Copyright © 2018 HU. All rights reserved.
//

#import "UILabel+AttributeClick.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@interface AttributeModel : NSObject
@property (nonatomic, copy) NSString *str;
@property (nonatomic) NSRange range;
@end

@implementation AttributeModel

@end

@implementation UILabel (AttributeClick)
#pragma mark - 添加属性

- (NSMutableArray *)attributeStrings{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAttributeStrings:(NSMutableArray *)attributeStrings{
    objc_setAssociatedObject(self, @selector(attributeStrings), attributeStrings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)clickDic{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClickDic:(NSMutableDictionary *)clickDic{
    objc_setAssociatedObject(self, @selector(clickDic), clickDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isClickAction{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsClickAction:(BOOL)isClickAction{
    objc_setAssociatedObject(self, @selector(isClickAction), @(isClickAction), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(NSString *,NSInteger))clickBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClickBlock:(void (^)(NSString *,NSInteger))clickBlock{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)supportClick{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setSupportClick:(BOOL)supportClick{
    objc_setAssociatedObject(self, @selector(supportClick), @(supportClick), OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)highLightColor{
    UIColor * color = objc_getAssociatedObject(self, _cmd);
    if (!color) {
        color = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, _cmd, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return color;
}

- (void)setHighLightColor:(UIColor *)highLightColor{
    objc_setAssociatedObject(self, @selector(highLightColor), highLightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 回掉方法
- (void)addAttributeClickWithStrings:(NSArray <NSString *> *)strings
                        clickBlock:(void (^) (NSString *string,NSInteger index))clickBlock{
    [self getRangesWithStrings:strings];
    self.userInteractionEnabled = YES;
    if (self.clickBlock != clickBlock) {
        self.clickBlock = clickBlock;
    }
}

- (void)addAttributeClickWithRanges:(NSArray<NSString *> *)ranges
                        clickBlock:(void (^)(NSString *,NSInteger index))clickBlock{
    [self getRangesWithRanges:ranges];
    self.userInteractionEnabled = YES;
    if (self.clickBlock != clickBlock) {
        self.clickBlock = clickBlock;
    }
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    if (!self.isClickAction) {
        [super touchesBegan:touches withEvent:event];
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak typeof(self) weakSelf = self;
    BOOL ret = [self getClickFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        if (weakSelf.supportClick) {
            [weakSelf saveClickDicWithRange:range];
            [weakSelf clickWithStatus:YES];
        }
    }];
    if (!ret) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    if (!self.isClickAction) {
        [super touchesEnded:touches withEvent:event];
        return;
    }
    if (self.supportClick) {
        [self performSelectorOnMainThread:@selector(clickWithStatus:) withObject:nil waitUntilDone:NO];
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak typeof(self) weakSelf = self;
    BOOL ret = [self getClickFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock (string,index);
        }
    }];
    if (!ret) {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches
               withEvent:(UIEvent *)event{
    if (!self.isClickAction) {
        [super touchesCancelled:touches withEvent:event];
        return;
    }
    if (self.supportClick) {
        [self performSelectorOnMainThread:@selector(clickWithStatus:) withObject:nil waitUntilDone:NO];
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak typeof(self) weakSelf = self;
    BOOL ret = [self getClickFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock (string,index);
        }
    }];
    if (!ret) {
        [super touchesCancelled:touches withEvent:event];
    }
}

#pragma mark - 获取点击区域
- (BOOL)getClickFrameWithTouchPoint:(CGPoint)point
                             result:(void (^) (NSString *string , NSRange range, NSInteger index))resultBlock{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + 20));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    CFArrayRef lines = CTFrameGetLines(frame);
    CGFloat total_height =  [self textSizeWithAttributedString:self.attributedText width:self.bounds.size.width numberOfLines:0].height;
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        return NO;
    }
    CFIndex count = CFArrayGetCount(lines);
    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    CGAffineTransform transform = [self transformForCoreText];
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        CGFloat lineOutSpace = (self.bounds.size.height - total_height) / 2;
        rect.origin.y = lineOutSpace + [self getLineOrign:line];
//        if (self.isLargeClickArea) {
//            rect.origin.y -= 5;
//            rect.size.height += 10;
//        }
        if (CGRectContainsPoint(rect, point)) {
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            CGFloat offset;
            CTLineGetOffsetForStringIndex(line, index, &offset);
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            NSInteger link_count = self.attributeStrings.count;
            for (int j = 0; j < link_count; j++) {
                AttributeModel *model = self.attributeStrings[j];
                NSRange link_range = model.range;
                if (NSLocationInRange(index, link_range)) {
                    if (resultBlock) {
                        resultBlock (model.str , model.range, (NSInteger)j);
                    }
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    return YES;
                }
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    return NO;
}

- (CGAffineTransform)transformForCoreText{
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}

- (CGRect)getLineBounds:(CTLineRef)line
                  point:(CGPoint)point{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = 0.0f;
    CFRange range = CTLineGetStringRange(line);
    NSAttributedString * attributedString = [self.attributedText attributedSubstringFromRange:NSMakeRange(range.location, range.length)];
    height = [self textSizeWithAttributedString:attributedString width:self.bounds.size.width numberOfLines:0].height;
    return CGRectMake(point.x, point.y , width, height);
}

- (CGFloat)getLineOrign:(CTLineRef)line{
    CFRange range = CTLineGetStringRange(line);
    if (range.location == 0) {
        return 0.;
    }else {
        NSAttributedString * attributedString = [self.attributedText attributedSubstringFromRange:NSMakeRange(0, range.location)];
        return [self textSizeWithAttributedString:attributedString width:self.bounds.size.width numberOfLines:0].height;
    }
}

- (CGSize)textSizeWithAttributedString:(NSAttributedString *)attributedString width:(float)width numberOfLines:(NSInteger)numberOfLines{
    @autoreleasepool {
        UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        sizeLabel.numberOfLines = numberOfLines;
        sizeLabel.attributedText = attributedString;
        CGSize fitSize = [sizeLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)];
        return fitSize;
    }
}

#pragma mark - 添加点击效果
- (void)clickWithStatus:(BOOL)status{
    if (self.supportClick) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        NSMutableAttributedString *subAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[[self.clickDic allValues] firstObject]];
        NSRange range = NSRangeFromString([[self.clickDic allKeys] firstObject]);
        if (status) {
            [subAtt addAttribute:NSBackgroundColorAttributeName value:self.highLightColor range:NSMakeRange(0, subAtt.string.length)];
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }else {
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }
        self.attributedText = attStr;
    }
}

- (void)saveClickDicWithRange:(NSRange)range{
    self.clickDic = [NSMutableDictionary dictionary];
    NSAttributedString *subAttribute = [self.attributedText attributedSubstringFromRange:range];
    [self.clickDic setObject:subAttribute forKey:NSStringFromRange(range)];
}

#pragma mark - 获取字符的Range
- (void)getRangesWithStrings:(NSArray <NSString *>  *)strings{
    if (self.attributedText == nil) {
        self.isClickAction = NO;
        return;
    }
    self.isClickAction = YES;
    self.supportClick = YES;
    __block  NSString *totalStr = self.attributedText.string;
    self.attributeStrings = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [totalStr rangeOfString:obj];
        if (range.length != 0) {
            totalStr = [totalStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
            AttributeModel *model = [AttributeModel new];
            model.range = range;
            model.str = obj;
            [weakSelf.attributeStrings addObject:model];
        }
    }];
}

- (void)getRangesWithRanges:(NSArray <NSString *>  *)ranges{
    if (self.attributedText == nil) {
        self.isClickAction = NO;
        return;
    }
    self.isClickAction = YES;
    self.supportClick = YES;
    __block  NSString *totalStr = self.attributedText.string;
    self.attributeStrings = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    
    [ranges enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = NSRangeFromString(obj);
        NSAssert(totalStr.length >= range.location + range.length, @"NSRange(%ld,%ld) is out of bounds",range.location,range.length);
        NSString * string = [totalStr substringWithRange:range];
        AttributeModel *model = [AttributeModel new];
        model.range = range;
        model.str = string;
        [weakSelf.attributeStrings addObject:model];
    }];
}

- (NSString *)getStringWithRange:(NSRange)range{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < range.length ; i++) {
        [string appendString:@" "];
    }
    return string;
}

#pragma mark - KVO监听
- (void)addObserver{
    [self addObserver:self forKeyPath:@"attributedText" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

- (void)removeObserver{
    id info = self.observationInfo;
    NSString * key = @"attributedText";
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath]) {
            [self removeObserver:self forKeyPath:@"attributedText" context:nil];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"attributedText"]) {
        if (self.isClickAction) {
            if (![change[NSKeyValueChangeNewKey] isEqual: change[NSKeyValueChangeOldKey]]) {
                
            }
        }
    }
}

- (void)dealloc{
    [self removeObserver];
}

#pragma mark - 设置富文本
- (void)setAttributeWith:(id)sender
                  string:(NSString *)string
              normalFont:(UIFont *)normalFont
             normalColor:(UIColor *)normalColor
           attributeFont:(UIFont *)attributeFont
          attributeColor:(UIColor *)attributeColor{
    __block  NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:string];
    [totalStr addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, string.length)];
    if ([sender isKindOfClass:[NSArray class]]) {
        __block NSString *oringinStr = string;
        __weak typeof(self) weakSelf = self;
        [sender enumerateObjectsUsingBlock:^(NSString *  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [oringinStr rangeOfString:str];
            [totalStr addAttribute:NSFontAttributeName value:attributeFont range:range];
            [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
            oringinStr = [oringinStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
        }];
    }else if ([sender isKindOfClass:[NSString class]]) {
        NSRange range = [string rangeOfString:sender];
        [totalStr addAttribute:NSFontAttributeName value:attributeFont range:range];
        [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
    }
    self.attributedText = totalStr;
}

@end
