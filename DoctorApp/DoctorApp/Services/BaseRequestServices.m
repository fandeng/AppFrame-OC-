//
//  BaseRequestServices.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "BaseRequestServices.h"

@implementation BaseRequestServices

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSTimeInterval)requestTimeoutInterval {
    
    return 10;
}

- (NSDictionary *)responseDictionary {
    
    return [CommonMethod dictionaryWithJsonString:self.responseString];
}

- (NSMutableDictionary *)publicRequestHeader:(BOOL)processType{
    
    NSMutableDictionary *publicDic = [NSMutableDictionary dictionary];
    
    if (processType) {
        
        [publicDic setValue:@"" forKey:@"token"];
    }
    
    [publicDic setValue:@"ios" forKey:@"appKey"];
    
    return publicDic;
}

- (NSString *)requestUrl {
    
    return [NSString stringWithFormat:@"%@%@",baseRequestUrl, self.processcode];
}


@end
