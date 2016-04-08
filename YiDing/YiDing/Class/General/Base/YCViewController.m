//
//  YCViewController.m
//  RenCheRen
//
//  Created by 王隆帅 on 15/7/30.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "YCViewController.h"
#import "YCNavigationController.h"

@interface YCViewController () <RDVTabBarControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,assign) UIStatusBarStyle statusBarStyle;
@property(nonatomic,assign) BOOL statusBarHidden;
@property(nonatomic,assign) BOOL changeStatusBarAnimated;
@property(nonatomic,assign) UIView *backView;

// 滑动隐藏 导航栏
@property (nonatomic, weak)   UIView                 *scrollableView;
@property (assign, nonatomic) float                  lastContentOffset;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UIView                 *overlay;
@property (assign, nonatomic) BOOL                   isCollapsed;
@property (assign, nonatomic) BOOL                   isExpanded;

@property (strong, nonatomic) UIView *statusBarView;

@end

@implementation YCViewController

#pragma mark - system

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    YCViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController yc_addSubviews];
        [viewController yc_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController yc_layoutNavigation];
        [viewController yc_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<YCViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _request = [CMRequest request];
    
    [self setIsExtendLayout:NO];
    
    [self ls_removeNavgationBarLine];
    
    self.view.backgroundColor = white_color;
    [self layoutNavigationBar:ImageNamed(@"navigationBarBG@2x.png") titleColor:black_color titleFont:YC_YAHEI_FONT(18) leftBarButtonItem:nil rightBarButtonItem:nil];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self rdv_tabBarController].delegate = self;
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)ls_removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

-(void)setIsExtendLayout:(BOOL)isExtendLayout {
   
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

-(void)initializeSelfVCSetting {
   
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.statusBarStyle) {
        
        return self.statusBarStyle;
    } else {
    
      return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden {
   
    return self.statusBarHidden;
}

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated {
   
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated{

    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem {
   
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark - tabBarDelegate

/**
 * Asks the delegate whether the specified view controller should be made active.
 */
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

//    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
//    NSLog(@"****%ld",index);
//    
//        if ((index == 1) | (index == 2)| (index == 3)| (index == 4)) {
//    
//            NSLog(@"%@",(NSString *)SEEKPLISTTHING(USER_ID));
//            if (!IS_LOGIN) {
//                [self ls_presentToLogin];
//                return NO;
//            } else {
//                
//                if (self.navigationController) {
//                    
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                }
//                return YES;
//            }
//        } else {
//        
//            if (self.navigationController) {
//    
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            
//            return YES;
//        }
    
    return YES;
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}

#pragma mark - RAC add

/**
 *  添加控件
 */
- (void)yc_addSubviews {}

/**
 *  绑定
 */
- (void)yc_bindViewModel {}

/**
 *  设置navation
 */
- (void)yc_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)yc_getNewData {}

/**
 *  键盘回收
 */
- (void)recoverKeyboard {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
