#import "ViewController.h"
//#import <ShareSDK/ShareSDK.h> 这个已经在pch导入了
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 用来配置按钮分享界面的样式的
#import <ShareSDKUI/SSUIShareSheetConfiguration.h>

@interface ViewController ()
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)go2CustomShareUI_VC:(UIButton *)sender {
    NSLog(@"跳转到自定义ShareUI界面");
    CustomShareUIViewController *vc =[[CustomShareUIViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


/**
 分享类型 是根据
 type 去决定
 */
- (IBAction)go2Share:(UIButton *)sender {
    NSLog(@"弹起分享");
    [self shareMune];
}
- (IBAction)go2QQShare:(UIButton *)sender {
    [self shareAfter];
//    [self auth]; // 授权获取第三方开放平台的登录 并且回返回第三方开放平台的个人信息
//    [self getUserInfo]; // 获取授权之后的第三方开放平台的数据
}

// 分享
- (void)share1
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params SSDKSetupShareParamsByText:@"test" images:[UIImage imageNamed:@"app.png"] url:[NSURL URLWithString:@"http://www.mob.com/"] title:@"title" type:SSDKContentTypeAuto];
    
    [ShareSDK share:SSDKPlatformTypeWechat parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateUpload:
                // 分享视频的时候上传回调，进度信息在 userData
                break;
            case SSDKResponseStateSuccess:
                //成功
                break;
            case SSDKResponseStateFail:
            {
                NSLog(@"--%@",error.description);
                //失败
                break;
            }
            case SSDKResponseStateCancel:
                //取消
                break;
                
            default:
                break;
        }
    }];
}


// 授权
- (void)auth
{
    [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
                NSLog(@"授权成功的数据  %@",user.dictionaryValue);
                break;
            case SSDKResponseStateFail:
            {
                NSLog(@"--%@",error.description);
                //失败
                break;
            }
            case SSDKResponseStateCancel:
                //用户取消授权
                break;
                
            default:
                break;
        }
    }];
}

- (void)getUserInfo
{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
                NSLog(@"%@",user.dictionaryValue);
                break;
            case SSDKResponseStateFail:
                NSLog(@"--%@",error.description);
                break;
            case SSDKResponseStateCancel:
                NSLog(@"%@",user.dictionaryValue);
                break;
            default:
                break;
        }
    }];
}

// 分享菜单
- (void)shareMune
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    NSArray* imageArray = @[[[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"https://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    // 设置字体颜色
    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
    config.cancelButtonTitleColor = [UIColor redColor];
    config.cancelButtonHidden = NO;

    
    NSArray *items = nil;
        items = @[
                  @(SSDKPlatformTypeQQ),
                  @(SSDKPlatformTypeWechat),
                  @(SSDKPlatformTypeCopy)
                  ];
 
    [ShareSDK showShareActionSheet:nil
                       customItems:items
                       shareParams:shareParams
                sheetConfiguration:config
                    onStateChanged:^(SSDKResponseState state,
                                     SSDKPlatformType platformType,
                                     NSDictionary *userData,
                                     SSDKContentEntity *contentEntity,
                                     NSError *error,
                                     BOOL end)
     {
         
         switch (state) {
                 
             case SSDKResponseStateSuccess:
                 break;
             case SSDKResponseStateFail:
             {
                 NSLog(@"--%@",error.description);
                 //失败
                 break;
             }
             case SSDKResponseStateCancel:
                 break;
             default:
                 break;
         }
     }];
}


- (void)shareAfter
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    NSArray* imageArray = @[[[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"https://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeWebPage];
    
    [ShareSDK showShareEditor:SSDKPlatformTypeWechat
               otherPlatforms:nil
                  shareParams:shareParams
          editorConfiguration:nil
               onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateUpload:
                           // 分享视频的时候上传回调，进度信息在 userData
                           break;
                       case SSDKResponseStateSuccess:
                           //成功
                           break;
                       case SSDKResponseStateFail:
                       {
                           NSLog(@"--%@",error.description);
                           //失败
                           break;
                       }
                       case SSDKResponseStateCancel:
                           //取消
                           break;
                           
                       default:
                           break;
                   }
                   
               }];
}
@end
