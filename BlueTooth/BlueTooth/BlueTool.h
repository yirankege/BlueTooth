//
//  BlueTool.h
//  BlueTooth
//
//  Created by xjk on 16/6/6.
//  Copyright © 2016年 lianchong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueTool : NSObject

//10转16进制
+ (NSString *)ToHex:(unsigned long)tmpid;

//字符串转data
+ (NSData*)hexToBytes:(NSString *)str;
//data转字符串
+ (NSString *)bytesToHex:(NSData *)data;

//16转10
+ (unsigned long)hexToInt:(NSString *)str;

//16进制字符串转字符串
+ (NSString *)hexToString:(NSString *)hexString ;

//字符串高低位转换
+(NSString *)heightToLow:(NSString *)string;

//16转long
+(NSString *)hexToLong:(NSString *)data;

//16转date
+(NSString *)hexToDate :(NSString *)data;
@end
