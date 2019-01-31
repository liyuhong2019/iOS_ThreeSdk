//
//  AppDelegate.m
//  ThreeSDK_Tencent_Bugly
//
//  Created by lee on 2019/1/30.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "AppDelegate.h"

#import "ThreeSDK_Tentcent_Bugly.h" // 腾讯bugly
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ThreeSDK_Tentcent_Bugly *tencentBugly = [ThreeSDK_Tentcent_Bugly getInstance];
    [tencentBugly lyh_tencentBuglyTestDebug];

    return YES;
}



@end
