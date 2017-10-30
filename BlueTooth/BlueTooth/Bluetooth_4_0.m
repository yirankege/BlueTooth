//
//  Bluetooth_4_0.m
//  TestThirdParty
//
//  Created by JDHR-MacBook on 16/5/26.
//  Copyright © 2016年 LuoYe. All rights reserved.
//

#import "Bluetooth_4_0.h"

#import "BlueTool.h"

#define SPLITNum    0x0A

@interface Bluetooth_4_0 ()

@property (nonatomic, strong) NSArray  *characteristics;
@property (nonatomic, strong) NSMutableData *cmdValue;
@property (nonatomic, strong) NSString *strCmd;
@end

@implementation Bluetooth_4_0


-(instancetype)init{
    self = [super init];
    if (self) {
        self.centralmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
        
    }
    return self;
}

//扫描回调－－每扫描到一次都会回调
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    if (!peripheral || !peripheral.name || ([peripheral.name isEqualToString:@""])) {
        return;
    }
    
    //打印名字
    if(![peripheral.name isEqual:@"MI1S"])
        NSLog(@"搜索到的蓝牙名称%@",peripheral.name);

        [self.delegate Bluetooth_4_0ScannerCBPeripheral:peripheral];
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"蓝牙正常，搜索中");
        [self.delegate Bluetooth_4_0BackState:@"0"];
        [self.centralmanager scanForPeripheralsWithServices:nil options:nil];
    }else{
        NSString *title     = @"蓝牙权限";
        NSString *message   = @"您必须打开蓝牙设置，以便使用";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        
        NSLog(@"蓝牙异常，请检查");
        [self.delegate Bluetooth_4_0BackState:@"1"];
    }
}
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"蓝牙连接状态：已连接");
    [self.delegate Bluetooth_4_0BackState:@"2"];
    peripheral.delegate = self;
    [self.cdCBPeripheral setDelegate:self];
    //查询服务
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
{
    NSLog(@"蓝牙连接状态：已断开");
    [self.delegate Bluetooth_4_0BackState:@"3"];
}

//重新连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    NSLog(@"error:%@",error);
    NSLog(@"蓝牙连接状态：重新连接中");
    [self.delegate Bluetooth_4_0BackState:@"4"];
    if (self.cdCBPeripheral) {
         [self.centralmanager connectPeripheral:self.cdCBPeripheral options:nil];
    }
   
}

//查询服务所带的特征值
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    NSArray *services = nil;
    
    if (peripheral != self.cdCBPeripheral) {
        NSLog(@"Wrong Peripheral.\n");
        return ;
    }
    
    if (error != nil) {
        NSLog(@"Error %@\n", error);
        return ;
    }
    
    services = [peripheral services];
    if (!services || ![services count]) {
        NSLog(@"No Services");
        return ;
    }
    
    for (CBService *service in services) {
        NSLog(@"service:%@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
    for (CBService *service in peripheral.services)
    {
        NSLog(@"___service:%@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//处理返回的特征值
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    for (CBCharacteristic * characteristic in service.characteristics) {
       // NSLog(@"当前蓝牙特征值:%@",characteristic.UUID.UUIDString);
        
        if([characteristic.UUID.UUIDString isEqualToString:@"FF02"]){
            self.readCharacteristic=characteristic;
            //得到特征的值    读取
            //
           // [peripheral readValueForCharacteristic:characteristic];
            //订阅这个特征
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
           
              [self.delegate Bluetooth_4_0BackNotifiState:@"1"];
           
        }
        if([characteristic.UUID.UUIDString isEqualToString:@"FF01"]){
             self.characteristic=characteristic;
        }
     
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    for (CBDescriptor * descriptor in characteristic.descriptors) {
               NSLog(@"descriptor: %@",descriptor);
        [peripheral readValueForDescriptor:descriptor];
    }
}



//处理特征的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //处理获取的特征值，转化为温度
    if (error) {
        NSLog(@"更新Value时发生错误:%@",error);
        return;
    }
    
    if (characteristic.value.length) {  //数据不为空
      // NSLog(@"characteristic.value: %@, %ld",characteristic.value,characteristic.value.length);
        
        if (self.cmdValue.length == 0) {  //判断是否是第一串命令
            self.cmdValue = [NSMutableData dataWithData:[characteristic.value copy]];
        }else{  //从第二串命令开始检查隔离
            [_cmdValue appendData:characteristic.value]; // 数据拼接
            
           self.strCmd= [BlueTool bytesToHex:_cmdValue];
            
           NSArray * array= [self rangesOfStringArray:@"4844"];
            
            for (NSValue * value in array) {
               NSRange range= [value rangeValue];
               NSString * subStr= [self.strCmd substringWithRange:NSMakeRange(range.location, self.strCmd.length -range.location)];
                [self.delegate Bluetooth_4_0BackStr:subStr];
                
            }
           
        }
        
    }

    
}

- (NSArray *)rangesOfStringArray:(NSString *)searchString{
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [searchString length]);
    
    NSRange range;
    
    
    
    while ((range = [searchString rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [searchString length] - NSMaxRange(range));
    }
    return results;
    
}


//处理订阅的特征
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{

    if (!characteristic.isNotifying) {
        if (error) {
            
            NSLog(@"Error changing notification state:%ld %@",
                  
                  (long)[error code],[error localizedDescription]);
        }
        return;
    }
//        //处理获取的特征值状态
//    NSLog(@"*********************************%@",characteristic);
//    
//    NSString *str= [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
//    NSLog(@"处理获取的特征值状态%@",str);
}



-(void)ConnentCBPeripheral:(CBPeripheral *)peripheral{
    self.cdCBPeripheral = peripheral;
    [self.centralmanager connectPeripheral:peripheral options:nil];
    [self.centralmanager stopScan];
    
   
    
}


-(void)sendData:(NSString *)str{
 
    //处理获取的特征值状态
  
   NSData * data=[Bluetooth_4_0 stringToAscii:str];
      NSLog(@"data === ===%@",data);
   
    if (self.cdCBPeripheral && self.characteristic) {  //如果其中一个为空就不发送
        if (CBCharacteristicPropertyWriteWithoutResponse == self.characteristic.properties) {
            for (int i=0; i<= data.length /20; i++) {
                NSInteger subLength=20;
                if (data.length / 20 == i) {
                    subLength = data.length - i * 20;
                }
                NSData *subData=[data subdataWithRange:NSMakeRange(i*20, subLength)];
              //  NSLog(@"subdata:%@",subData);
                [self.cdCBPeripheral writeValue:subData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];//给周边发送数据
            }
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error.code) {
        NSLog(@"%@",error);
    }
}

-(void)closeBluetooth{
    [self.centralmanager stopScan];//取消查询
    [self.centralmanager cancelPeripheralConnection:self.cdCBPeripheral];//断开连接
}



+(NSData *)stringToAscii:(NSString *)string{
    Byte bytes[string.length/2];
    
    for (int i=0; i< string.length / 2; i++) {
        
        NSString * subStr=[string substringWithRange:NSMakeRange(i * 2, 2)];
        
        unsigned long ints=  [BlueTool  hexToInt: subStr];
        
        bytes[i]=ints;
        // NSLog(@"for count:%d  subStr:%@ ints:%c  appStr:%@",i,subStr,ints,str);
    }
    NSData * data=[NSData dataWithBytes:bytes length:string.length / 2];
    return data;
    
}
@end
