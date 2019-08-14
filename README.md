# JHButton
iOS图文自定义按钮，基于Masonry实现，支持OC，Swift
可以实现各种各样的按钮，点击也可以实现根据图片自动适应按钮大小，详见demo
依赖Masonry

##样式
```objc
typedef NS_ENUM(NSInteger, JHImageButtonType){
    
    /**
     *  按钮图片居左 文案居右 可以影响父布局的大小
     */
    JHImageButtonTypeLeft = 0,
    
    /**
     *  按钮图片居右 文案居左 可以影响父布局的大小
     */
    JHImageButtonTypeRight,
    
    /**
     *  按钮图片居上 文案居下 可以影响父布局的大小
     */
    JHImageButtonTypeTop,
    
    /**
     *  按钮图片居下 文案居上 可以影响父布局的大小
     */
    JHImageButtonTypeBottom,
};
```
##属性
```objc
/**
 *  文本
 */
@property (nonatomic,strong) NSString * text;

/**
 *  图片
 */
@property (nonatomic,strong) UIImage * image;

/**
 *  背景图片
 */
@property (nonatomic,strong) UIImage * backgroundImage;


/**
 *  展示文本的Label 可以用来自定义一些属性
 */
@property (nonatomic,strong) UILabel * contentLabel;

/**
 *  展示图片的ImageView 用来自定义部分属性
 */
@property (nonatomic,strong) UIImageView * imageView;


/**
 *  展示背景图片的ImageView 用来自定义部分属性
 */
@property (nonatomic,strong) UIImageView * backgroundImageView;
```
##API
```objc
/**
 *  设置按钮背景颜色 可以为nil
 *
 *  @param normalColor    正常颜色
 *  @param highLightColor 高亮颜色
 */
- (void)setNormolBackgroundColor:(UIColor *)normalColor
               AndHighLightColor:(UIColor *)highLightColor;

/**
 *  设置按钮背景颜色 可以为nil
 *
 *  @param normalColor    正常颜色
 *  @param highLightColor 高亮颜色
 *  @param selectedColor  选中颜色
 *  @param disableColor   不可用颜色
 */
- (void)setNormolBackgroundColor:(UIColor *)normalColor
               AndHighLightColor:(UIColor *)highLightColor
                AndSelectedColor:(UIColor *)selectedColor
                 AndDisableColor:(UIColor *)disableColor;

/**
 *  设置按钮图片 可以为nil
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setNormolImage:(UIImage *)normalImage
     AndHighLightImage:(UIImage *)highLightImage;

/**
 *  设置按钮图片 可以为nil
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 *  @param selectedImage  选中图片
 *  @param disableImage   不可用图片
 */
- (void)setNormolImage:(UIImage *)normalImage
     AndHighLightImage:(UIImage *)highLightImage
      AndSelectedImage:(UIImage *)selectedImage
       AndDisableImage:(UIImage *)disableImage;

/**
 *  设置按钮文本点击颜色 可以为nil
 *
 *  @param normalTextColor    正常文本颜色
 *  @param highLightTextColor 高亮文本颜色
 */
- (void)setNormolTextColor:(UIColor *)normalTextColor
     AndHighLightTextColor:(UIColor *)highLightTextColor;

/**
 *  设置按钮文本点击颜色 可以为nil
 *
 *  @param normalTextColor    正常文本颜色
 *  @param highLightTextColor 高亮文本颜色
 *  @param selectedTextColor  高亮文本颜色
 *  @param disableTextColor   不可用文本颜色
 */
- (void)setNormolTextColor:(UIColor *)normalTextColor
     AndHighLightTextColor:(UIColor *)highLightTextColor
      AndSelectedTextColor:(UIColor *)selectedTextColor
       AndDisableTextColor:(UIColor *)disableTextColor;

/**
 *  设置按钮边框颜色
 *
 *  @param normalLayColor      正常边框颜色
 *  @param highLightLayerColor 高亮边框颜色
 */
- (void)setNormolLayerColor:(UIColor *)normalLayColor
     AndhighLightLayerColor:(UIColor *)highLightLayerColor;

/**
 *  设置按钮边框颜色
 *
 *  @param normalLayColor      正常边框颜色
 *  @param highLightLayerColor 高亮边框颜色
 *  @param selectedLayerColor   选中边框颜色
 *  @param disableLayerColor   不可用边框颜色
 */
- (void)setNormolLayerColor:(UIColor *)normalLayColor
     AndHighLightLayerColor:(UIColor *)highLightLayerColor
      AndSelectedLayerColor:(UIColor *)selectedLayerColor
       AndDisableLayerColor:(UIColor *)disableLayerColor;


/**
 *  设置背景图片
 *
 *  @param normalBackgroundImage    正常背景图片
 *  @param highLightBackgroundImage 高亮背景图片
 */
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
     AndHighLightBackgroundImage:(UIImage *)highLightBackgroundImage;

/**
 *  设置背景图片
 *
 *  @param normalBackgroundImage    正常背景图片
 *  @param highLightBackgroundImage 高亮背景图片
 *  @param selectedBackgroundImage  选中背景图片
 *  @param disableBackgroundImage   不可用背景图片
 */
- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
     AndHighLightBackgroundImage:(UIImage *)highLightBackgroundImage
      AndSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
       AndDisableBackgroundImage:(UIImage *)disableBackgroundImage;


/**
 *  初始化
 *
 *  @param type 按钮生产类型 具体看JHImageButtonType注释
 *  @param arr  一个NSNumber的数组，用来标示 图片和文本之间的间距 默认 从左到右，从上到下，默认取数组的前三个值 （且当数组 有且仅有1个值时，表示图片和文本之间的间距）如果自适应距离 请设置 JHImageButtonDefaultUnSetMargin
 *
 *  @return JHImageButtonType
 */
- (instancetype)initWithType:(JHImageButtonType)type
                AndMarginArr:(NSArray *)arr;
```

## 使用方法
```objc
JHButton *btn1 = [[JHButton alloc] initWithType:JHImageButtonTypeTop AndMarginArr:@[@5]];
    btn1.backgroundColor = ColorOfRandom;
    btn1.image = [UIImage imageNamed:@"image1"];
    btn1.text = @"按钮1";
    btn1.contentLabel.textColor = [UIColor redColor];
    btn1.contentLabel.font = [UIFont systemFontOfSize:13];
    btn1.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(20);
    }];

    JHButton *btn2 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@5]];
    btn2.backgroundColor = ColorOfRandom;
    btn2.image = [UIImage imageNamed:@"image3"];
    btn2.text = @"按钮2";
    btn2.contentLabel.textColor = [UIColor redColor];
    btn2.contentLabel.font = [UIFont systemFontOfSize:13];
    btn2.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(btn1.mas_right).offset(10);
    }];
    
    JHButton *btn3 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@5]];
    btn3.backgroundColor = ColorOfRandom;
    btn3.text = @"按钮2";
    btn3.contentLabel.textColor = [UIColor redColor];
    btn3.contentLabel.font = [UIFont systemFontOfSize:13];
    btn3.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(btn2.mas_right).offset(10);
    }];
    
    JHButton *btn4 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@0]];
    btn4.backgroundColor = ColorOfRandom;
    btn4.image = [UIImage imageNamed:@"image3"];
    btn4.contentLabel.textColor = [UIColor redColor];
    btn4.contentLabel.font = [UIFont systemFontOfSize:13];
    btn4.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(btn3.mas_right).offset(10);
    }];
    
    JHButton *btn5 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@0]];
    [btn5 setNormolImage:[UIImage imageNamed:@"image1"] AndHighLightImage:[UIImage imageNamed:@"image3"]];
    [btn5 setNormolTextColor:[UIColor redColor] AndHighLightTextColor:[UIColor greenColor]];
    [btn5 setNormolLayerColor:[UIColor purpleColor] AndhighLightLayerColor:[UIColor blueColor]];
    btn5.text = @"123123";
    btn5.contentLabel.textColor = [UIColor redColor];
    btn5.contentLabel.font = [UIFont systemFontOfSize:13];
    btn5.contentLabel.textAlignment =NSTextAlignmentLeft;
    btn5.layer.borderWidth = 2;
    [self.view addSubview:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn1.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
    }];
    
    JHButton *btn6 = [[JHButton alloc] initWithType:JHImageButtonTypeLeft AndMarginArr:@[@10]];
    btn6.backgroundColor = ColorOfRandom;
    btn6.image = [UIImage imageNamed:@"image3"];
    btn6.text = @"123123";
    btn6.contentLabel.textColor = [UIColor redColor];
    btn6.contentLabel.font = [UIFont systemFontOfSize:13];
    btn6.contentLabel.textAlignment =NSTextAlignmentLeft;
    [self.view addSubview:btn6];
    [btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn5.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.width.height.mas_equalTo(100);
    }];
    //这样可以移动文字或者图片位置
//    [btn6.imageView updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(0);
//        make.width.priorityHigh();
//    }];
```
##  安装
### 1.手动添加:<br>
*   1.将 JHButton 文件夹添加到工程目录中<br>
*   2.导入 JHButton.h

### 2.CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'JHButton'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 JHButton.h



##  许可证
JHButton 使用 MIT 许可证，详情见 LICENSE 文件
