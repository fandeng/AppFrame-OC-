//
//  CommonMethod.m
//  BabyLove
//
//  Created by tl1207 on 16/1/8.
//  Copyright © 2016年 bengo. All rights reserved.
//

#import "CommonMethod.h"
#import <AFNetworking/AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

#define COMMON_DATA_REQ_PROG_HUD_TAG                9998
static UIAlertView *_alertView = nil;

@implementation CommonMethod

//手机号识别
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString * MOBILE = @"^[1][3,4,5,7,8][0-9]{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    BOOL isMobileNum = NO;
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)) {
        isMobileNum = YES;
    }
    
    return isMobileNum;
}

+ (BOOL)isShowGuidePage {
    
    NSString * appVersion =  [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
    
    if (appVersion == nil || ![appVersion isEqualToString:[CommonMethod clientVersionCode]]) {
        
        return YES;
    }

    return NO;
}

// 获取当前版本的版本号
+ (NSString *)clientVersionCode {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)clientBundleCode{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDic objectForKey:@"CFBundleVersion"];
    return app_build;
}

+ (NSString *)curTimeWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *curTime = [dateFormatter stringFromDate:[NSDate date]];

    return curTime;
}

+ (NSString *)deviceUUIDString {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:DeviceUUIDKey]) {
        NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [defaults setObject:uuid forKey:DeviceUUIDKey];
        [defaults synchronize];
    }
    return [defaults objectForKey:DeviceUUIDKey];
}

//网络错误提示
+ (void)networkBadBack {

    [CommonMethod createAlertView:nil message:@"请求失败，请稍候再试" time:1];
}

+ (BOOL)isServerBadBack:(NSDictionary *)dic {
    
    if (dic) {
        
        if (dic[@"result"] == nil) {
            
            return NO;
        }
        
        NSString *retcode = dic[@"result"];
        
        if ([retcode integerValue] < 10) {
            
            if ([retcode isEqualToString:@"1"] && dic[@"message"]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [CommonMethod createAlertView:nil message:dic[@"message"] time:1.0];
                });
            }
            
            return YES;
            
        } else {
            
            NSString * lastChar = [retcode substringWithRange:NSMakeRange(retcode.length - 1, 1)];
            
            if ([lastChar isEqualToString:@"1"]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [CommonMethod createAlertView:nil message:dic[@"message"] time:1.0];
                });
                
            } else {
                
                if ([retcode isEqualToString:@"100003"] || [retcode isEqualToString:@"100004"] || [retcode isEqualToString:@"100005"]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSUserDefaults * useDefaults = [NSUserDefaults standardUserDefaults];
                        
                        [useDefaults objectForKey:@"token"];
                        
                       
                    });
                }
            }
            
            return NO;
        }
        
    }
    return NO;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DoctorLog(@"json解析失败error:[%@] andString:[%@]",err,jsonString);
        return nil;
    }
    DoctorLog(@"server call back:[%@]",dic);
    return dic;
}

//显示小菊花
+ (void)showProgressHUDWithTitle:(NSString *)title inView:(UIView *)superView animated:(BOOL)animated {
    MBProgressHUD *requestHUD = (MBProgressHUD *)[superView viewWithTag:COMMON_DATA_REQ_PROG_HUD_TAG];
    
    if (!requestHUD) {
        requestHUD = [[MBProgressHUD alloc] initWithView:superView];
        requestHUD.mode = MBProgressHUDModeIndeterminate;
        requestHUD.tag = COMMON_DATA_REQ_PROG_HUD_TAG;
        [superView addSubview:requestHUD];
    }
    requestHUD.hidden = NO;
    [superView bringSubviewToFront:requestHUD];
    
    if (!title) {
        title = @"正在加载...";
    }
    requestHUD.label.text = title;
    
    [requestHUD showAnimated:animated];
}

//隐藏小菊花
+ (void)hideProgressHUDInView:(UIView *)superView delegate:(id)hudDelegate animated:(BOOL)animated afterDelay:(NSTimeInterval)delayTime {
    MBProgressHUD *requestHUD = (MBProgressHUD *)[superView viewWithTag:COMMON_DATA_REQ_PROG_HUD_TAG];
    if (requestHUD) {
        animated = NO;
        if (hudDelegate) {
            requestHUD.delegate = hudDelegate;
            
             [requestHUD hideAnimated:animated afterDelay:delayTime];
        } else {
            requestHUD.hidden = YES;
        }
    }
}

// 将时间戳传为时间串
+ (NSString *)timestampFormatterTimeString:(NSString *)string isHour:(BOOL)isHour {
    
    NSString * temp = [NSString stringWithFormat:@"%@", string];
    
    if (temp.length < 10) {
        
        return @"";
    }
    NSTimeInterval timestamp= [temp doubleValue]/1000;
    
    NSDate *timeDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:isHour ? TimeFormatWithSecond : TimeFormatWithDay];
    
    temp = [dateFormatter stringFromDate: timeDate];
    
    return temp;
}

//绘制图片 以免变形
+ (UIImage *)drawImage:(NSString *)name {
    UIImage * backgroundImage = [UIImage imageNamed:name];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake((backgroundImage.size.height/2.0 - 0.5), (backgroundImage.size.width/2.0 - 0.5), (backgroundImage.size.height/2.0 - 0.5), (backgroundImage.size.width/2.0 - 0.5)) resizingMode:UIImageResizingModeStretch];
    return backgroundImage;
}

//计算文本高度
+ (CGFloat)compareTextHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    
    if (text.length <= 0) {
        
        return 0;
    }
    CGSize size = CGSizeMake(width, 2000);
    NSDictionary * dic = @{NSFontAttributeName:font};
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:NULL];
    
    return rect.size.height+1;
}

//弱提示
/**
 *  弱提示
 *
 *  @param title   标题
 *  @param message 提示语
 *  @param time    时间
 */
+ (void)createAlertView:(NSString *)title message:(NSString *)message time:(NSTimeInterval)time {
    if (_alertView.isVisible) {
        return;
    }
    if (_alertView != nil) {
        _alertView = nil;
    }
    _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [_alertView show];
    [self performSelector:@selector(removeAlertView:) withObject:_alertView afterDelay:time];
}

//alertView消失
+ (void)removeAlertView:(UIAlertView *)alertView {
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

/**
 输入框字数限制
 
 @param textField 输入框
 @param range 位置
 @param text 输入字符
 @param count 允许输入个数
 */
+ (BOOL)limitTextFieldWithWords:(UITextField *)textField range:(NSRange)range text:(NSString *)text count:(NSInteger)count {
    
    NSMutableString *newString = [NSMutableString stringWithString:textField.text];
    
    [newString replaceCharactersInRange:range withString:text];
    
    return newString.length <= count;

}

+ (NSMutableAttributedString *)dealWithText:(NSString *)text oneText:(NSString *)oneText otherText:(NSString *)otherText {
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:kTitleColor range:NSMakeRange(0, oneText.length)];
    
    
     [attributedString addAttribute:NSForegroundColorAttributeName value:kThemeColor range:NSMakeRange(oneText.length, otherText.length)];
    
    return attributedString;
}

//签名加密
+ (NSString *)dicSort:(NSDictionary *)dic {
    
    NSArray *keyArray = [dic allKeys];
    
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    
    for (NSString *sortString in sortArray) {
        
        [valueArray addObject:[dic objectForKey:sortString]];
    }
    
    NSMutableString * signString = [NSMutableString string];
    
    for (int i = 0; i < sortArray.count; i++) {
        
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArray[i],valueArray[i]];
        
        [signString appendString:keyValueStr];
    }
    
    NSString * sign = [NSString stringWithFormat:@"%@%@",signString,secretKey];
    
    return [self md5:sign];
}

//加密
+ (NSString *)md5:(NSString *)inPutText {
    
    //    const char * cStr = [inPutText UTF8String];
    //    unsigned char result[CC_MD5_DIGEST_LENGTH];
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}





+ (NSString *)getJSONStringFromArray:(NSArray *)array {
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+ (NSString *)getJSONStringFromADictionary:(NSDictionary *)dic {
    
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        
        return @"";
    }
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonStr;
}

+ (NSURLSessionUploadTask *)uploadTaskWithImage:(UIImage*)image dic:(NSDictionary *)dic completion:(void (^)(NSURLResponse *, id, NSError *))completionBlock {
    
    // 构造 NSURLRequest
    NSError* error = NULL;
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/upload/uploadFile", baseRequestUrl] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData* imageData = UIImageJPEGRepresentation(image, 0.3);
        
        NSInteger time = [[NSDate date] timeIntervalSince1970];
        
        NSString * fileName = [NSString stringWithFormat:@"%ld.jpg",(long)time];
        
        /*
         *该方法的参数
         1. appendPartWithFileData：要上传的照片[二进制流]
         2. name：接口对应图片字段
         3. fileName：图片类型
         4. mimeType：上传的文件的类型
         */
        if (imageData!=nil) {
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"multipart/form-data"];
        }
        
    } error:&error];
    
    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:completionBlock];
    
    return uploadTask;
    
}

//退出登录
+ (void)clearLoginData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginTime"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"province"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"species"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandss"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"city"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"district"];
}

//颜色转换为图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (CGFloat)compareLabelLayoutHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width space:(CGFloat)space {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;  // 段落高度
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:text];
    [attributes addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    [attributes addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    CGSize attSize = [attributes boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return attSize.height+1;
}

+ (NSAttributedString*)getAttributedStringWithLineSpace:(NSString *)text space:(CGFloat)space {
    NSMutableParagraphStyle*paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;
    NSDictionary*attriDict =@{NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc]initWithString:text attributes:attriDict];
    return attributedString;
}

+ (NSString *)compareCurrentTime:(NSString *)timeStr timestamp:(NSString *)timestamp {
    NSString * timestring = timestamp;
    if (timestamp == nil && timestamp.length == 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:TimeFormatWithSecond];
        NSDate* dateTodo = [formatter dateFromString:timeStr];
        NSString *timeSp = [NSString stringWithFormat:@"%ld000", (long)[dateTodo timeIntervalSince1970]];
        timestring = timeSp;
    }
    NSTimeInterval time= [timestring doubleValue]/1000;
    NSDate *timeDate=[NSDate dateWithTimeIntervalSince1970:time];
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    } else if((temp = temp/60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else {
        result = timeStr;
    }
    return  result;
}








@end
