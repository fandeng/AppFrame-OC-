//
//  CommonConfig.h
//  BabyLove
//
//  Created by 樊登 on 2017/9/28.
//  Copyright © 2017年 樊登. All rights reserved.
//

#ifndef CommonConfig_h
#define CommonConfig_h

//----------------------------微信配置------------------------
//#define WEIXIN_KEY   @"891c2204762c6ba735fb00178c3d852f"
#define WEIXIN_APPID   @"wx318297703af9fc6d"

//----------------------------支付宝配置------------------------
#define AlipayAPPID   @"2017102409491509"  //支付宝APPID

//签名
#define secretKey @"d6582f13b87b50870cc70b17fe4e5b19"

#define RequestLimit @"20"

#define HOSTNAME @""//测试

//#define HOSTNAME @""//正式

#define baseRequestUrl   [NSString stringWithFormat:@"http://%@/", HOSTNAME]

#define APP_DELEGATE    (AppDelegate *)[[UIApplication sharedApplication] delegate]

//----------------------------屏幕尺寸定义------------------------
#define ScreenSize      [UIScreen mainScreen].bounds.size

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width

#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

#define iOS11         ([UIDevice currentDevice].systemVersion.floatValue >= 11.0)

#define iOS10         ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)

#define iPhone5       (ScreenHeight == 568)

#define iPhone6       (ScreenWidth == 375 && ScreenHeight > 568)

#define iPhone6P      (ScreenWidth > 375)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//----------------------------字体大小定义------------------------
#define autoSizeScaleXFor6Plus  (iPhone5 ? 0.8 : (iPhone6 ? 1 : 1.2))

#define kNavFont(x)      [UIFont systemFontOfSize:x*autoSizeScaleXFor6Plus]   //导航栏字体大小

#define kWeightBoldFont(x)   [UIFont fontWithName:@"Helvetica-Bold" size:x*autoSizeScaleXFor6Plus]  //加粗字体大小

#define kTitleFont    [UIFont systemFontOfSize:15*autoSizeScaleXFor6Plus] //标题类字体大小

#define kMainFont     [UIFont systemFontOfSize:14*autoSizeScaleXFor6Plus]  //正文字体大小

#define kSubtitleFont [UIFont systemFontOfSize:13*autoSizeScaleXFor6Plus]  //副标题字体大小

#define kCaptionFont  [UIFont systemFontOfSize:12*autoSizeScaleXFor6Plus]   //时间字体大小

#define kSmallFont    [UIFont systemFontOfSize:11*autoSizeScaleXFor6Plus]   //时间字体大小

//----------------------------颜色定义------------------------
#define kThemeColor     [UIColor colorWithHex:@"#4093c2"]  //app主色调

#define kGrayColor     [UIColor colorWithHex:@"#BBBBBB"]  //按钮不可点击颜色

#define kBgColor       [UIColor colorWithHex:@"#f0f1f2"]  //view背景色

#define kNavColor      [UIColor blackColor]    //导航栏字体颜色

#define kTitleColor    [UIColor colorWithHex:@"#333333"] //标题类字体颜色

#define kMainColor     [UIColor colorWithHex:@"#666666"]  //正文字体颜色

#define kSubtitleColor [UIColor colorWithHex:@"#999999"]  //副标题字体颜色

#define kCaptionColor  [UIColor lightGrayColor]   //时间字体颜色



#endif /* CommonConfig_h */
