//
//  BlueMacro.h
//  BlueTooth
//
//  Created by xjk on 16/6/2.
//  Copyright © 2016年 lianchong. All rights reserved.
//

#ifndef BlueMacro_h
#define BlueMacro_h

#include <stdio.h>

#endif /* BlueMacro_h */




// 命令字:用户鉴权
#define CM_AUTH  @"01"
// 充电启停控制命令
#define CM_CHARGE @"02"
// 功率控制命令
#define CM_POWER 03
// 运行数据命令
#define CM_DATA @"04"
// 系统参数操作命令
#define CM_SYSTEM 05
// 出厂调试命令
#define CM_DEBUG 06
// 充电设备返回异常代码
#define CM_ERROR 99

// 命令参数：绑定操作
#define PM_BIND 01
// 命令参数：更新桩主KEY_UUID
#define PM_UPDATE_OWNER 02
// 命令参数：读取充电桩ID
#define PM_GET_POLE_ID @"04"
// 命令参数：合法测试
#define PM_VALID_TEST 05
// 命令参数：启动充电
#define PM_START_CHARGE @"01"
// 命令参数：停止充电
#define PM_STOP_CHARGE @"02"
// 命令参数：暂停充电，只有在充电时才可以执行。
#define PM_PAUSE_CHARGE 03
// 命令参数：恢复充电，只有在暂停充电时才可以执行。
#define PM_RECOVER_CHARGE 04
// 命令参数：延时启动充电
#define PM_POSTPONE_CHARGE 05
// 命令参数：调节充电桩A口输出功率
#define PM_ADJUST_POWER_A 01
// 命令参数：调节充电桩B口输出功率
#define PM_ADJUST_POWER_B 02
// 命令参数：读设备状态，包括工作状态、告警状态。
#define PM_GET_DEVICE_STATUS 01
// 命令参数：读实时充电参数，包括充电电压、电量。
#define PM_GET_CHARGE_STATE 02
// 命令参数：读充电记录号。
#define PM_GET_CHARGE_RECORD_ID @"03"
// 命令参数：读充电记录。
#define PM_GET_CHARGE_RECORD @"04"
// 命令参数：清除全部充电记录。
#define PM_DELETE_CHARGE_RECORD 05
// 命令参数：设置设备时间。
#define PM_SET_POLE_TIME 01
// 命令参数：读取设备时间
#define PM_GET_POLE_TIME 02
// 命令参数：恢复到出厂状态。
#define PM_RESET 01
// 命令参数：读取充电桩ID
#define PM_SET_POLE_ID @"04"
// 命令参数：读取充电实时数据
#define PM_SET_REALTIME @"02"

// 补填8个0
#define EIGHT_ZERO @"0000000000000000"
// 补填6个0
#define SIX_ZERO @"000000000000"
// 结束字节(0x45)
#define kETX @"45"
// 隔离数据(0x0A)
#define SPLIT @"0A"


// 起始4字节(0x48 0x44) STX (‘HD’)
#define kSTX  @"4844"
//版本号
#define VERSION  @"30"

//KeyType   普通用户
#define kKEYTYPENORMAL @"01"

//KeyType   管理员用户
#define kKEYTYPEMANAGE  @"02"




#define CMD_INFO_OK                 1    //成功
#define CMD_INFO_KEY_ERR            2   //合法性验证不能通过
#define CMD_INFO_INVALID_USER       3   //非法用户
#define CMD_INFO_CHARGING_INVALID   4   //设备充电,非法用户操作
#define CMD_INFO_CHARGE_STOP        5   //充电机已经停止充电:
#define CMD_INFO_CHARGING           6   //充电机已经正在充电:
#define CMD_INFO_GUN_OFF            7   //充电枪不在线:不可以启动充电
#define CMD_INFO_OTHER_CHARGING     8   //其他用户正在充电:不可以再充电
#define CMD_INFO_TEST_STATUE        9   //设备正在调试状态:不可以充电



#define kKeyTypeAndKeyCmdLength     17   // 1+16   命令type + 命令包





