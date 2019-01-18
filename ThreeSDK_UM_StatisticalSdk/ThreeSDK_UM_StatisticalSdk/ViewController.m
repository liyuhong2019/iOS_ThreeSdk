

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)go2UMPay:(UIButton *)sender
{
    NSLog(@"友盟统计 高级功能");

    // 1.充值操作
    /*
     1.说明和用途
     玩家支付货币兑换虚拟币,用于统计游戏的收入情况
     */
#warning 测试支付 需要添加测试设备号
        // 测试设备通过sdk 获取
        /**
         NSString * deviceID =[UMConfigure deviceIDForIntegration];
         NSLog(@"集成测试的deviceID:%@", deviceID);
         */
    [MobClickGameAnalytics pay:324 source:2 coin:32400];
}




@end
