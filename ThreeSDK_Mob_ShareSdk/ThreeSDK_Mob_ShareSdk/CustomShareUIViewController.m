
#import "CustomShareUIViewController.h"


// 弹出分享菜单需要导入的头文件
//#import <ShareSDK/ShareSDK.h> // pch 已经导入
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
// #自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>
// 分享按钮的配置类
#import <ShareSDKUI/SSUIShareSheetConfiguration.h>
// 分享按钮的自定义按钮类
#import <ShareSDKUI/SSUIPlatformItem.h>


@interface CustomShareUIViewController ()
@property (nonatomic,strong) NSString *shareUrl;
@end

@implementation CustomShareUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)go2ShowCustomShareUI:(UIButton *)sender {
    [self customShareUI];
}

- (void)customShareUI

{
    
    NSString *shareUrl = self.shareUrl = @"https://www.baidu.com";
    //1.构造分享参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic SSDKSetupShareParamsByText:@"娜娜~ 娜娜啊~~~"
                             images:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523515635458&di=58aff559df8c0dc61347423610a9aa02&imgtype=0&src=http%3A%2F%2Fwww.yx-w.com%2Ftutu%2F20171103%2Fa21181.jpg"
                                url:[NSURL URLWithString:shareUrl]
                              title:@"娜娜"
                               type:SSDKContentTypeWebPage];
    
    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
    
    //设置分享菜单为简洁样式
    config.style = SSUIActionSheetStyleSimple;
    
    //设置竖屏有多少个item平台图标显示
    config.columnPortraitCount = 4;
    
    //设置横屏有多少个item平台图标显示
    config.columnLandscapeCount = 2;
    
    //设置取消按钮标签文本颜色
    config.cancelButtonTitleColor = [UIColor redColor];
    
    //设置对齐方式（简约版菜单无居中对齐）
    config.itemAlignment = SSUIItemAlignmentCenter;
    
    //设置标题文本颜色
    config.itemTitleColor = [UIColor greenColor];
    
    //设置分享菜单栏状态栏风格
    config.statusBarStyle = UIStatusBarStyleLightContent;
    
    //设置支持的页面方向（单独控制分享菜单栏）
    config.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscape;
    
    //设置分享菜单栏的背景颜色
    config.menuBackgroundColor = [UIColor whiteColor];
    
    //取消按钮是否隐藏，默认不隐藏
    config.cancelButtonHidden = YES;
    
    //设置直接分享的平台（不弹编辑界面）
    config.directSharePlatforms = @[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeTwitter)];
    
    
#pragma  - 自定义分享按钮
    SSUIPlatformItem *item_1 = [self customCircle];
    
    
    SSUIPlatformItem *item_2 = [self customMyInvitationCard];
    
    SSUIPlatformItem *item_3 = [self customCopyTheLink];
    
    SSUIPlatformItem *item_4 = [self customComplaints];
    
#pragma  - 分享按钮位置调整
    NSArray *items = nil;
    items = @[
              @(SSDKPlatformSubTypeWechatSession),
              @(SSDKPlatformSubTypeWechatTimeline),
//              @(SSDKPlatformTypeWechat),
              @(SSDKPlatformTypeQQ),
              item_1,
              item_2,
              item_3,
//              @(SSDKPlatformTypeCopy),
              item_4
              ];

    
    //2.弹出分享菜单
    [ShareSDK showShareActionSheet:nil
                       customItems:items
                       shareParams:dic
                sheetConfiguration:config
                    onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType,
                                     NSDictionary *userData, SSDKContentEntity *contentEntity,
                                     NSError *error, BOOL end) {
                        
                        switch (state) {
                            case SSDKResponseStateSuccess:
                                {
                                    NSLog(@"userData %@",userData);
                                    
                                    NSLog(@"urls %@",contentEntity.urls);

                                    NSLog(@"urls %@",contentEntity.rawData);
                                }
                                break;
                            case SSDKResponseStateFail:
                            {
                                NSLog(@"--%@",error.description);
                                //失败
                                break;
                            }
                            case SSDKResponseStateCancel:
                                NSLog(@"自定义视图 进行取消分享");
                                break;
                            default:
                                break;
                        }
                        
                    }];
    
}

// 同学圈
- (SSUIPlatformItem *)customCircle
{
    SSUIPlatformItem *item_1 = [[SSUIPlatformItem alloc] init];
    item_1.iconNormal = [UIImage imageNamed:@"1"];//默认版显示的图标
    item_1.iconSimple = [UIImage imageNamed:@"apple.png"];//简洁版显示的图标
    item_1.platformName = @"同学圈";
    item_1.platformId = @"我爱这个娜娜";
    //添加点击事件
    [item_1 addTarget:self action:@selector(costomPlatFormClick_customCircle:)];
    return item_1;
}

// 我的邀请卡
- (SSUIPlatformItem *)customMyInvitationCard
{
    SSUIPlatformItem *item_1 = [[SSUIPlatformItem alloc] init];
    item_1.iconNormal = [UIImage imageNamed:@"1"];//默认版显示的图标
    item_1.iconSimple = [UIImage imageNamed:@"apple.png"];//简洁版显示的图标
    item_1.platformName = @"我的邀请卡";
    item_1.platformId = @"我爱这个娜娜";
    //添加点击事件
    [item_1 addTarget:self action:@selector(costomPlatFormClick_customMyInvitationCard:)];
    return item_1;
}

// 我的邀请卡
- (SSUIPlatformItem *)customCopyTheLink
{
    SSUIPlatformItem *item_1 = [[SSUIPlatformItem alloc] init];
    item_1.iconNormal = [UIImage imageNamed:@"1"];//默认版显示的图标
    item_1.iconSimple = [UIImage imageNamed:@"apple.png"];//简洁版显示的图标
    item_1.platformName = @"复制链接";
    item_1.platformId = @"我爱这个娜娜";
    //添加点击事件
    [item_1 addTarget:self action:@selector(costomPlatFormClick_customCopyTheLink:)];
    return item_1;
}

// 投诉
- (SSUIPlatformItem *)customComplaints
{
    SSUIPlatformItem *item_1 = [[SSUIPlatformItem alloc] init];
    item_1.iconNormal = [UIImage imageNamed:@"1"];//默认版显示的图标
    item_1.iconSimple = [UIImage imageNamed:@"apple.png"];//简洁版显示的图标
    item_1.platformName = @"投诉";
    item_1.platformId = @"我爱这个娜娜";
    //添加点击事件
    [item_1 addTarget:self action:@selector(costomPlatFormClick_customComplaints:)];
    return item_1;
}
- (void)costomPlatFormClick_customComplaints:(SSUIPlatformItem *)item_4
{
    NSLog(@"自定义按钮4 %@",item_4);
}
- (void)costomPlatFormClick_customCopyTheLink:(SSUIPlatformItem *)item_3
{
    NSLog(@"自定义按钮3 %@",item_3);
    UIPasteboard *pasted=[UIPasteboard generalPasteboard];
    pasted.string=self.shareUrl;
    NSLog(@"复制的内容 %@",pasted.string);
}
- (void)costomPlatFormClick_customMyInvitationCard:(SSUIPlatformItem *)item_2
{
    NSLog(@"自定义按钮2 %@",item_2);
}
- (void)costomPlatFormClick_customCircle:(SSUIPlatformItem *)item_1
{
    NSLog(@"自定义按钮1 %@",item_1);
}


@end
