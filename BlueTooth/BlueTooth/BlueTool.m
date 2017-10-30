//
//  BlueTool.m
//  BlueTooth
//
//  Created by xjk on 16/6/6.
//  Copyright © 2016年 lianchong. All rights reserved.
//

#import "BlueTool.h"
#import "BlueMacro.h"
@implementation BlueTool


+ (NSString *)ToHex:(unsigned long)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    if(str.length == 1){
        return [NSString stringWithFormat:@"0%@",str];
    }else{
        return str;
    }
}

//字符串转data
+ (NSData*)hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

//16转int
+ (unsigned long)hexToInt:(NSString *)str{
   unsigned long num=strtoul([str UTF8String],0,16);
    return  num ;
}


//data转字符串
+ (NSString *)bytesToHex:(NSData *)data{
    NSMutableString * string=[NSMutableString string];
    Byte *testByte = (Byte *)[data bytes];
    for(int i=0;i<[data length];i++){
        
        [string appendString:[BlueTool ToHex:testByte[i]]];
    }
    return string;
}




// 十六进制转换为普通字符串的。
+ (NSString *)hexToString:(NSString *)hexString { 
    
     char * myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
  //  NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;   

}





+(NSString *)heightToLow:(NSString *)string{
     NSMutableArray * hexArray = [[NSMutableArray alloc] init];
    
    //2位16进制数据表示一个字符，默认最后不满2位的16进制数据放一起
    for (int i=0; i<ceil(string.length/2.0); i++) {
        NSString *subString;
        if (i==ceil(string.length/2.0)-1) {
            subString = [string substringFromIndex:i*2];
        }
        else{
            subString = [string substringWithRange:NSMakeRange(i*2, 2)];
        }
        [hexArray addObject:subString];
    }
    
    
    for (int i =0, j = (int)(hexArray.count) - 1 ; i<hexArray.count / 2; i++) {
        [hexArray exchangeObjectAtIndex:i withObjectAtIndex:j];
        j--;
    }
  
    NSMutableString * strMutable=[NSMutableString string];
    for (NSString * str in hexArray) {
        [strMutable appendString:str];
    }
    return  strMutable;

}


+(NSString *)hexToLong:(NSString *)data{
    
    
    unsigned long  long intValue;
    
    NSString * strHex=  [BlueTool heightToLow:data];
    
    NSScanner * scanner=[NSScanner scannerWithString:strHex];
    
    [scanner scanHexLongLong:&intValue];
    
   // NSLog(@"intValue:%llu",intValue);
    
    return [NSString stringWithFormat:@"%llu",intValue];
    
}

//+(NSString *)hexToDate :(NSString *)data{
//    unsigned long strtIntervali = [BlueTool hexToInt:[BlueTool heightToLow:data]] ;
//    
//    //  NSLog(@"%lu",strtIntervali);
//     return  [NSDate TimeStamp:[NSString stringWithFormat:@"%lu",strtIntervali]];
//    
//
//}

@end
