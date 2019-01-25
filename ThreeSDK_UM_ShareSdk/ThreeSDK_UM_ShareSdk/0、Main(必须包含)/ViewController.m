
#import "ViewController.h"
#import <UMShare/UMShare.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_type;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)go2WaChat:(UIButton *)btn {
    [self go2Type:1];
}

- (IBAction)go2QQ:(UIButton *)btn {
    [self go2Type:2];
}

- (IBAction)go2Sina:(UIButton *)btn {
    [self go2Type:3];
}


- (void)go2Type:(int)type
{

    int tag =  [self.tf_type.text intValue];
    tag = 2;
    
    if (tag == 1) {
//        NSLog(@"登录");
//        if (type == 1) {
//            NSLog(@"微信登录");
//        }



        switch (type) {
            case 1:
            {
                NSLog(@"微信登录");
                [self getAuthWithUserInfoFromWechat];
            }
                break;
            case 2:
            {
                NSLog(@"QQ登录");
                [self getAuthWithUserInfoFromQQ];
            }
                break;
            case 3:
            {
                NSLog(@"新浪登录");
                [self getAuthWithUserInfoFromSina];
            }
                break;

            default:
                break;
        }


    }
    else
    {
//        NSLog(@"分享");

        switch (type) {
            case 1:
            {
                NSLog(@"微信分享");
                [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession]; // UMSocialPlatformType_WechatTimeLine
                
            }
                break;
            case 2:
            {
                NSLog(@"QQ分享");
                [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone]; // UMSocialPlatformType_QQ
            }
                break;
            case 3:
            {
                NSLog(@"新浪分享");
                [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            }
                break;

            default:
                break;
        }
    }

}


// 在需要进行获取用户信息的UIViewController中加入如下代码

// 新浪登录
- (void)getAuthWithUserInfoFromSina
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error %@",error.userInfo);

        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)getAuthWithUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error %@",error.userInfo);

        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}




- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error %@",error.userInfo);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


#pragma mark - 分享网页 - 需要传递平台类型
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"lyh165_thumb"]]; // lyh165_thumb 是分享链接的图片
    //设置网页地址
    shareObject.webpageUrl =@"http://www.baidu.com";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
