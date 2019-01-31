#import "ThreeSDK_Tentcent_Bugly.h"

// 1.导入腾讯的bugly框架
#import <Bugly/Bugly.h>

@interface ThreeSDK_Tentcent_Bugly ()
<
BuglyDelegate
>
@end
@implementation ThreeSDK_Tentcent_Bugly
// 单例对象
+ (ThreeSDK_Tentcent_Bugly *)getInstance{
    static ThreeSDK_Tentcent_Bugly *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 初始化的时候调用
- (id)init{
    if (self = [super init]) {
        NSLog(@"%s , 初始化腾讯bugly --- start",__func__);
        [self lyh_initTencentBugly];
        NSLog(@"%s , 初始化腾讯bugly --- end",__func__);
        
        // 故意演示闪退代码
        //        [self lyh_tencentBuglyTestDebug];
    }
    return self;
}

#pragma mark - 初始化 腾讯bugly start
- (void)lyh_initTencentBugly
{
    NSLog(@"%s , 初始化",__func__);
    [Bugly startWithAppId:ThreeLib_TencentBugly_AppID config:^{
        BuglyConfig *config = [[BuglyConfig alloc] init];
        config.blockMonitorEnable = YES;
        config.blockMonitorTimeout = 2;
        config.consolelogEnable = YES;
        config.delegate = self;
        return config;
    }()];
}
#pragma mark  初始化 腾讯bugly end
/**
 故意演示闪退代码
 */
- (void)lyh_tencentBuglyTestDebug
{
    NSLog(@"%s , 故意演示闪退代码",__func__);
    // 延迟1秒左右 制造错误
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%s , 延迟1.5发生错误",__func__);
        NSArray *array = @[@"l",@"y",@"h"];
        NSLog(@"array %@",array[5]);
    });
}

#pragma mark -  腾讯bugly代理 start
- (NSString *)attachmentForException:(NSException *)exception {
    return @"Do you want to do...";
}
#pragma mark  初始化 腾讯bugly代理 end
@end
