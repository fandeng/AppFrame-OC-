//
//  BaseRequestServices.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>
#import <YTKNetwork/YTKBatchRequest.h>

@interface BaseRequestServices : YTKRequest

@property (nonatomic, copy) NSDictionary *requestBody;//request_body的内容

@property (nonatomic, copy) NSString * processcode; // 接口关键字

/**
 *  把接口返回的数据格式化为字典数据
 *
 *  @return 字典
 */
- (NSDictionary *)responseDictionary;

/**
 *  公共的请求字典
 *
 *  @param processType 是否包含token
 *
 *  @return 公共的字典
 */
- (NSMutableDictionary *)publicRequestHeader:(BOOL)processType;

@end
