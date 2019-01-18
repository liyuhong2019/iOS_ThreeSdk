

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end



/**
 手动集成 依赖库
 CoreTelephony.framework    获取运营商标识
 libz.tbd  数据压缩
 libsqlite.tbd  数据缓存
 SystemConfiguration.framework  判断网络状态
 */
