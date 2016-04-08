//
//  ToolView.h
//  WeMeetig
//
//  Created by Mac Pro on 14-11-26.
//  Copyright (c) 2014年 jianan.hou. All rights reserved.
//


#define WeMeetig_ToolView_h

#ifndef __OPTIMIZE__
#define GA_Log(...) NSLog(__VA_ARGS__)
#else
#define GA_Log(...) {}
#endif

#pragma mark － 域名url
#define urlRealmName @"http://111.13.56.19/iphone.php/"

//宏定义
//全大写加下划线
//k开头驼峰

#define SEEKPLISTTHING(KEY)     [[NSUserDefaults standardUserDefaults]objectForKey:KEY]
#define DEPOSITLISTTHING(VALUE,KEY)  [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]

#define GA_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define GA_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#pragma mark - 方正黑体简体字体定义
#define FONT(F)                [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
#define FONT_SDGothicNeo(F)    [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:F]
#define FONTMic(F)                 [UIFont fontWithName:@"MicrosoftYaHei" size:F]
#pragma mark - 字体加粗
#define FontBig(F) [UIFont fontWithName:@"Helvetica-Bold" size:F]
#pragma mark - 导航栏高度
#define NavigationBar_HEIGHT   44

#pragma mark - 屏幕尺寸相关
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define UIScreenHeight  [[UIScreen mainScreen]bounds].size.height

#pragma mark alertView
#define GA_ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#pragma mark - 安全释放资源
#define SAFE_RELEASE(x) [x release];x=nil

#pragma mark - IOS版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - 当前系统版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

#pragma mark - 当前系统语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - 检测是否是Retina屏幕,是否是iPhone5,是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - 本地持久化宏
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - 颜色相关宏函数
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#pragma mark - 设备型号识别
#define is_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#pragma mark - 打印当前方法的名字
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

#pragma mark - rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - 判断系统版本高于或者低于某一个版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#pragma mark - iPhone设备使用的编译
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#pragma mark - 模拟器使用的编译
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#pragma mark - 检测是否是ARC
//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC

#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif
#define ALog(...) NSLog(__VA_ARGS__)




#endif


