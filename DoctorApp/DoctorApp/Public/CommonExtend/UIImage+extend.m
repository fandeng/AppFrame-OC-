//
// Created by allen on 13-7-17.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIImage+extend.h"

@implementation UIImage (extend)

+ (UIImage *)imageNamedMC:(NSString *)imgName
{
    //FXTRACE(FXT_INFO_LVL, @"image%@", @"imageNamedMC",imgName);
    return [UIImage imageNamed:imgName];
}
@end