//
//  NSString+Base.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "NSString+Base.h"

#import <CoreText/CoreText.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Base)
- (NSString *)getMD5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString  stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12],
            result[13], result[14], result[15]
            ];
}
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)getBase64{
    NSData *theData = [self dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (BOOL)isNotNull{
    if ([self length] == 0){
        return NO;
    }else if ([self isEqualToString:@"null"]){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)empty{
    return [self length] > 0 ? NO : YES;
}

- (BOOL)isTelephone{
    NSString * MOBILE = @"^(1)\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestmobile evaluateWithObject:self]  ;
}

- (BOOL)isIdentifyNo{
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]&&![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
    //    /*
    //     必须满足以下规则
    //     1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
    //     2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
    //     3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
    //     4. 第17位表示性别，双数表示女，单数表示男
    //     5. 第18位为前17位的校验位
    //     算法如下：
    //     （1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
    //     （2）余数 ＝ 校验和 % 11
    //     （3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
    //     6. 出生年份的前两位必须是19或20
    //     */
    //
    //    if (self.length !=18) {
    //        return NO;
    //    }
    //    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    //    NSString *leapMmdd = @"0229";
    //    NSString *year = @"(19|20)[0-9]{2}";
    //    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    //    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    //    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    //    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    //    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    //    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    //    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //
    //    if (![regexTest evaluateWithObject:self]) {
    //        return NO;
    //    }
    //
    //    int summary = ([self substringWithRange:NSMakeRange(0,1)].intValue + [self substringWithRange:NSMakeRange(10,1)].intValue) *7
    //                 + ([self substringWithRange:NSMakeRange(1,1)].intValue + [self substringWithRange:NSMakeRange(11,1)].intValue) *9
    //                 + ([self substringWithRange:NSMakeRange(2,1)].intValue + [self substringWithRange:NSMakeRange(12,1)].intValue) *10
    //                 + ([self substringWithRange:NSMakeRange(3,1)].intValue + [self substringWithRange:NSMakeRange(13,1)].intValue) *5
    //                 + ([self substringWithRange:NSMakeRange(4,1)].intValue + [self substringWithRange:NSMakeRange(14,1)].intValue) *8
    //                 + ([self substringWithRange:NSMakeRange(5,1)].intValue + [self substringWithRange:NSMakeRange(15,1)].intValue) *4
    //                 + ([self substringWithRange:NSMakeRange(6,1)].intValue + [self substringWithRange:NSMakeRange(16,1)].intValue) *2
    //                 + [self substringWithRange:NSMakeRange(7,1)].intValue *1 + [self substringWithRange:NSMakeRange(8,1)].intValue *6
    //                 + [self substringWithRange:NSMakeRange(9,1)].intValue *3;
    //         NSInteger remainder = summary % 11;
    //         NSString *checkBit = @"";
    //         NSString *checkString = @"10X98765432";
    //         checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    //
    //    return [checkBit isEqualToString:[[self substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

- (CGSize)getSizeWithFont:(UIFont *)font{
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:attributes];
    
}

- (CGSize)getSizeWithAtt:(NSDictionary *)att ConstrainedToSize:(CGSize)size{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:att context:nil].size;
}
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size AndLineHeight:(CGFloat)lineHeight{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineHeight];
    NSDictionary * attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

//单行的
- (CGSize)textSizeWithFont:(UIFont*)font{
    
    CGSize textSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    textSize = CGSizeMake((int)ceil(textSize.width), (int)ceil(textSize.height));
    return textSize;
}

/**
 根据字体、行数、行间距和constrainedWidth计算多行文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth
          isLimitedToLines:(BOOL *)isLimitedToLines{
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows > numberOfLines) {
            rows = numberOfLines;
            if (isLimitedToLines) {
                *isLimitedToLines = YES;  //被限制
            }
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    
    return CGSizeMake(ceil(constrainedWidth),ceil(realHeight));
}

@end
