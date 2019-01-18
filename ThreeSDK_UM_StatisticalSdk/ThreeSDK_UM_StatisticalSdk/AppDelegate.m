

#import "AppDelegate.h"
// 已经在pch 导入 
//#import <UMCommon/UMCommon.h>
//#import <UMAnalytics/MobClickGameAnalytics.h>
//#import <UMAnalytics/MobClick.h>
#import <UMCommonLog/UMCommonLogManager.h> // 打印日志
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self ThreeSDK_UM_Init];
    return YES;
}
/**
 初始化 友盟游戏统计的sdk
 */
- (void)ThreeSDK_UM_Init
{
    NSLog(@"初始化友盟统计sdk");
    
    [UMCommonLogManager setUpUMCommonLogManager];
    //此处在初始化函数前面是为了打印初始化的日志
    [UMConfigure setLogEnabled:YES];
    // 设置支持游戏统计场景
    [MobClick setScenarioType:E_UM_GAME];
    // 启用崩溃报告
    [MobClick setCrashReportEnabled:YES];
    
    NSString * deviceID =[UMConfigure deviceIDForIntegration];
    NSLog(@"集成测试的deviceID:%@", deviceID);
    // 1.初始化sdk
    [UMConfigure initWithAppkey:UM_Appkey channel:@"App Store"];
}

- (void)ThreeSdk_UM_AdvancedFunction
{
    NSLog(@"友盟统计 高级功能");
    
    // 1.充值操作
    /*
    1.说明和用途
    玩家支付货币兑换虚拟币,用于统计游戏的收入情况
     */
    
    // 使用了支付宝渠道
    [MobClickGameAnalytics pay:10 source:2 coin:1000];
    NSLog(@"使用了支付宝渠道 花费10元rmb 购买1000金币");
}
@end


/**
 集成步骤1
 
 1、导入 #import <UMCommon/UMCommon.h>
 
 
 */


/**
 #import <UMCommon/UMCommon.h>
 #import <UMAnalytics/MobClick.h>
 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
 [UMConfigure setLogEnabled:YES];//此处在初始化函数前面是为了打印初始化的日志
 [MobClick setScenarioType:E_UM_NORMAL|E_UM_GAME|E_UM_DPLUS];
 [MobClick setCrashReportEnabled:YES];
 [UMConfigure initWithAppkey:@"your appkey" channel:@"App Store"];
 }
 */
