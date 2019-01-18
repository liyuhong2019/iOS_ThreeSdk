#import "AppDelegate.h"
/**
 宏我绑定到pch文件了
 将MobAppKey 绑定到第三方
 */

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self CustomMethod_BindThreeSDKFor_ShareSdk];
    return YES;
}

/**
 (ShareSdk) 初始化、绑定第三方开放平台
 */
- (void)CustomMethod_BindThreeSDKFor_ShareSdk
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister){
        // QQ
        [platformsRegister setupQQWithAppId:MOBAppIdFor_QQ appkey:MOBAppkeyFor_QQ];
        // 微信
        [platformsRegister setupWeChatWithAppId:MOBAppIdFor_WeChat appSecret:MOBAppkeyFor_WeChat];
    }];

}
@end

/**
 
 默认分享、授权、获取用户信息 在ViewController里面实现
 自定义UI、自定义分享按钮 在CustomShareUIViewController里面实现
 */


/**
 文档参考
 http://wiki.mob.com/快速集成/
 
 一、集成
     0、将shareSDK下载的sdk扔到项目里面
     1、导入shareSDK的依赖库
     2、在info.plist绑定Mob后台应用的应用健 和应用密钥 (MOBAppKey、MOBAppSecret)
     4、在Build Settings中的Other Linker Flags添加"-ObjC"
     5、在info.plist 配置urlScheme
     6、配置白名单 用于 应用能打开第三方平台
        6.1. 在项目的info.plist中添加key:LSApplicationQueriesSchemes，类型为Array
        plist里面的源代码
             <key>LSApplicationQueriesSchemes</key>
             <array>
             <!--   QZONE和QQ     -->
             <string>mqzoneopensdk</string>
             <string>mqzoneopensdkapi</string>
             <string>mqzoneopensdkapi19</string>
             <string>mqzoneopensdkapiV2</string>
             <string>mqqOpensdkSSoLogin</string>
             <string>mqqopensdkapiV2</string>
             <string>mqqopensdkapiV3</string>
             <string>wtloginmqq2</string>
             <string>mqqapi</string>
             <string>mqqwpa</string>
             <string>mqzone</string>
             <string>mqq</string>
             <string>mqqopensdkapiV4</string>
             <!--   wechat     -->
             <string>wechat</string>
             <string>weixin</string>
             </array>
 
 
二、实现
 导入 #import <ShareSDK/ShareSDK.h>
    3、在Appdelegate里面绑定各个平台申请的key
        比如QQ、微信等等
        实现 CustomMethod_BindThreeSDKFor_ShareSdk方法
    7、实现按钮功能
        具体查看代码
    8、允许项目使用http请求
        在info.plist 添加
        App Transport Security Settings 类型为dict
            再从下面添加 Allow Arbitrary Loads 为 yes
    9、设置成中文显示
 
        在info.plist里面 添加 Localizations 类型为 array
        添加 Chinese 字段
        如果想修改指定的文字 需要到sdk里面的
        ShareSDK->Support->Optional-> zh-hans 是中文
    10、自定义分享按钮
 
         SSUIPlatformItem *item_1 = [[SSUIPlatformItem alloc] init];
         item_1.iconNormal = [UIImage imageNamed:@"1"];//默认版显示的图标
         item_1.iconSimple = [UIImage imageNamed:@"apple.png"];//简洁版显示的图标
         item_1.platformName = @"girls";
         item_1.platformId = @"我爱这个娜娜";
         //添加点击事件
         [item_1 addTarget:self action:@selector(costomPlatFormClick:)];
    11、自定义UI按钮的位置调整
        在 customItems 里面按照顺序存入即可
    12、复制链接功能
        UIPasteboard *pasted=[UIPasteboard generalPasteboard];
        pasted.string=self.shareUrl;
 
三、自定义UI
 (看这个)http://wiki.mob.com/ui重构之后的一些接口调用/
 
四、修改 UI 使用开源代码 (头部信息) 到时候 删除 ShareSDKUI 直接拿开源的代码存放到项目里面
 https://github.com/MobClub/ShareSDKUI/tree/master/ShareSDK/ShareSDKUI/ShareSDKUI
 */
