//
//  Bluetooth_4_0.h
//  TestThirdParty
//
//  Created by JDHR-MacBook on 16/5/26.
//  Copyright © 2016年 LuoYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

//代理
@protocol Bluetooth_4_0Delegate <NSObject>



@optional

//返回扫描到的数据
-(void)Bluetooth_4_0ScannerCBPeripheral:(CBPeripheral *)peripheral;

//返回蓝牙的连接状态0-搜索中,1-蓝牙异常,2-已连接,3-已断开,4-重连中
-(void)Bluetooth_4_0BackState:(NSString*)state;

//返回接收到的数据
-(void)Bluetooth_4_0BackStr:(NSString *)str;

//返回订阅状态0-订阅失败,1-成功
-(void)Bluetooth_4_0BackNotifiState:(NSString*)state;

@end

@interface Bluetooth_4_0 : NSObject<CBPeripheralDelegate,CBCentralManagerDelegate>


//定义代理
@property(nonatomic, weak) id <Bluetooth_4_0Delegate> delegate;

//蓝牙控制中心
@property(nonatomic,strong)CBCentralManager *centralmanager;

//连接的蓝牙设备
@property(nonatomic,strong)CBPeripheral *cdCBPeripheral;

//查找到的特征        写入特征
@property (nonatomic,strong)CBCharacteristic * characteristic;
//查找到的特征        读书notity 特征
@property (nonatomic,strong)CBCharacteristic * readCharacteristic;

//连接蓝牙的名称(必须)
@property (nonatomic,strong)NSString* bluetoothName;

//连接蓝牙的特征值(必须)
@property (nonatomic,strong)NSString* bluetoothCharacter;

//往外接设备发送数据
-(void)sendData:(NSString*)str;

//连接设备
-(void)ConnentCBPeripheral:(CBPeripheral *)peripheral;

//断开连接
-(void)closeBluetooth;

@end
