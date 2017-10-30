//
//  ViewController.m
//  BlueTooth
//
//  Created by xjk on 01/08/2017.
//  Copyright © 2017 xjk. All rights reserved.
//

#import "ViewController.h"
#import "Bluetooth_4_0.h"
@interface ViewController ()<Bluetooth_4_0Delegate>
@property (nonatomic, strong) Bluetooth_4_0 *BlueMgr;
@property (nonatomic, strong) NSMutableArray *perArray;
@end

@implementation ViewController

-(NSMutableArray *)perArray{
    if (_perArray == nil) {
        _perArray=[NSMutableArray array];
    }
    return _perArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    Bluetooth_4_0 * mgr=[[Bluetooth_4_0 alloc]init];
    mgr.delegate =self;
    self.BlueMgr=mgr;
    [mgr.centralmanager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey :[NSNumber numberWithBool:NO],
                                                                     CBConnectPeripheralOptionNotifyOnConnectionKey:[NSNumber numberWithBool:YES],
                                                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:[NSNumber numberWithBool:YES]}];
    
}

//返回扫描到的数据
-(void)Bluetooth_4_0ScannerCBPeripheral:(CBPeripheral *)peripheral{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 44, 44)];
    [label setText:peripheral.name];
    
    [self.view addSubview:label];
}

//返回蓝牙的连接状态0-搜索中,1-蓝牙异常,2-已连接,3-已断开,4-重连中
-(void)Bluetooth_4_0BackState:(NSString*)state{

}

//返回接收到的数据
-(void)Bluetooth_4_0BackStr:(NSString *)str{

}

//返回订阅状态0-订阅失败,1-成功
-(void)Bluetooth_4_0BackNotifiState:(NSString*)state{


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
