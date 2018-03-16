//
//  CommonMethod.h
//  BabyLove
//
//  Created by tl1207 on 16/1/8.
//  Copyright © 2016年 bengo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const TimeFormatWithSecond = @"yyyy-MM-dd HH:mm:ss";
static NSString *const TimeFormatWithDay = @"yyyy-MM-dd";
static NSString *const DeviceUUIDKey = @"DeviceUUIDKey";

@interface CommonMethod : NSObject

//格式化时间格式
+ (NSString *)curTimeWithFormat:(NSString *)format;

//手机号识别
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 获取当前版本的版本号
+ (NSString *)clientVersionCode;

//  获取当前版本的bundle号
+ (NSString *)clientBundleCode;

//设备的唯一标示符
+ (NSString *)deviceUUIDString;

//引导页
+ (BOOL)isShowGuidePage;

/**
 *  密码加密
 *
 *  @param inPutText 需要加密字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)md5:(NSString *)inPutText;

//签名加密
+ (NSString *)dicSort:(NSDictionary *)dic;

//判断请求是否失败
+ (BOOL)isServerBadBack:(NSDictionary *)dic;

//网络请求失败
+ (void)networkBadBack;

//json string 转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//显示小菊花
+ (void)showProgressHUDWithTitle:(NSString *)title inView:(UIView *)superView  animated:(BOOL)animated;

//隐藏小菊花
+ (void)hideProgressHUDInView:(UIView *)superView delegate:(id)hudDelegate animated:(BOOL)animated afterDelay:(NSTimeInterval)delayTime;

/**
 将时间戳传为时间串
 **/
+ (NSString *)timestampFormatterTimeString:(NSString *)string isHour:(BOOL)isHour;

/**
 绘制图片 以免变形
 
 @param name 图片名称
 @return 图片
 */
+ (UIImage *)drawImage:(NSString *)name;


/**
 颜色转换为图片

 @param color 颜色值
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  计算文本高度
 *
 *  @param text 文本
 *  @param font   字体大小
 *  @param width  宽度
 *
 *  @return 高度
 */
+ (CGFloat)compareTextHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

/**
 *  计算富文本高度
 *
 *  @param text 文本
 *  @param font   字体大小
 *  @param width  宽度
 *  @param space  行高
 *
 *  @return 高度
 */
+ (CGFloat)compareLabelLayoutHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width space:(CGFloat)space;

/**
 *  计算富文本行高
 *
 *  @param text 文本
 *  @param space  行高
 *
 *  @return 高度
 */
+ (NSAttributedString*)getAttributedStringWithLineSpace:(NSString *)text space:(CGFloat)space;

//弱提示
/**
 *  弱提示
 *
 *  @param title   标题
 *  @param message 提示语
 *  @param time    时间
 */
+ (void)createAlertView:(NSString *)title message:(NSString *)message time:(NSTimeInterval)time;

/**
 输入框字数限制

 @param textField 输入框
 @param range 位置
 @param text 输入字符
 @param count 允许输入个数
 */
+ (BOOL)limitTextFieldWithWords:(UITextField *)textField range:(NSRange)range text:(NSString *)text count:(NSInteger)count;


/**
 富文本，显示不同颜色

 @param text 字符串
 @param oneText 第一种颜色
 @param otherText 第二种颜色
 @return 富文本
 */
+ (NSMutableAttributedString *)dealWithText:(NSString *)text oneText:(NSString *)oneText otherText:(NSString *)otherText;

//清除缓存
+ (void)clearLoginData;

/**
 //将数组转为json字符串
 **/
+ (NSString *)getJSONStringFromArray:(NSArray *)array;

/**
 //将字典转为json字符串
 **/
+ (NSString *)getJSONStringFromADictionary:(NSDictionary *)dic;

//上传图片
+ (NSURLSessionUploadTask *)uploadTaskWithImage:(UIImage*)image dic:(NSDictionary *)dic completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;

/**
 对时间字符串或时间戳处理
 @param timeStr 时间字符串
 @param timestamp 时间戳
 @return 字符串
 */
+ (NSString *) compareCurrentTime:(NSString *)timeStr timestamp:(NSString *)timestamp;

@end
