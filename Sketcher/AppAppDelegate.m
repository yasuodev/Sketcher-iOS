//
//  AppAppDelegate.m
//  Sketcher
//
//  Created by CS on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppAppDelegate.h"

//#import "AppFirstViewController.h"

#import "AppSecondViewController.h"
#import "LoginViewController.h"

#import "CustomTabBarControllerViewController.h"
#import "JSON.h"
@implementation AppAppDelegate

@synthesize window = _window;
//@synthesize tabBarController = _tabBarController;
@synthesize loginView,navController,Email,Pass,appFirstView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSString *is_remember_user = [[NSUserDefaults standardUserDefaults] valueForKey:@"is_remember_user"];
    if(is_remember_user == (id)[NSNull null]||is_remember_user.length == 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"FALSE" forKey:@"is_remember_user"];
    }
    [self loggedInIfRememberMe];
    
    
    
    /*
    
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[AppFirstViewController alloc] initWithNibName:@"AppFirstViewController" bundle:nil];
    UIViewController *viewController2 = [[AppSecondViewController alloc] initWithNibName:@"AppSecondViewController" bundle:nil];
    self.tabBarController = [[CustomUITabBarController alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    
    
    
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nil];
    
    //    UIView *myTabView = [[UIView alloc] initWithFrame:CGRectMake(0.00, 0.00, 160.00, 46.00)];
    //    
    //    [myTabView setBackgroundColor:[UIColor redColor]];
    //    
    //    [self.tabBarController.tabBar insertSubview:myTabView atIndex:0];
    //    
    
    UITabBarItem *tabItem = [[[self.tabBarController tabBar] items] objectAtIndex:0];
    [tabItem setTitle:@""]; 
    
    
    UITabBarItem *tabItem1 = [[[self.tabBarController tabBar] items] objectAtIndex:1];
    [tabItem1 setTitle:@""];
    
*/
    NSLog(@"check here....");
    
    
    
    //[self CallWebService];230 G: 229 B: 231R: 246 G: 246 B: 247
   // [self checkSession];
    
    //    CGRect frame = CGRectMake(0.0, 0.0, 160.00, 46);
    //    
    //    UIView *myTabView = [[UIView alloc] initWithFrame:frame];
    //    
    //    [myTabView  setBackgroundColor:[UIColor colorWithRed:0.2 green:0.4 blue:0.6 alpha:0.65]];
    //    
    //    [myTabView  setAlpha:0.5];
    //    
    //    [[self.tabBarController tabBar] insertSubview:myTabView  atIndex:0];
    
    //[myTabView  release];
    
    /*self.window.rootViewController = self.tabBarController;
     [self.window makeKeyAndVisible];
     return YES;*/
    return YES;
}






/*- (void) addTabBar
{
    
    [self.window addSubview:self.tabBarController.view];
    
}*/

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // handler code here
     NSString *strScheme = [url scheme];
    NSLog(@"strScheme-----%@",strScheme);
    return true;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)loggedInIfRememberMe
{
    UINavigationController *nav;
    NSString *is_remember_user = [[NSUserDefaults standardUserDefaults] valueForKey:@"is_remember_user"];
   
    if([is_remember_user isEqualToString:@"TRUE"])
    {
        self.appFirstView=[[AppFirstViewController alloc]initWithNibName:@"AppFirstViewController" bundle:nil];
        
        NSLog(@"is_remember_user ---- true --");
     self.navController.navigationBarHidden=NO;
        
       
        RearViewController *rearViewController = [[RearViewController alloc] init];
        
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:self.appFirstView];
        
        UINavigationController *rarNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                        initWithRearViewController:rarNavigationController frontViewController:frontNavigationController];
        
        mainRevealController.delegate = self;
        
        self.viewController = mainRevealController;
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
    else
    {
        NSLog(@"is_remember_user ---- it not ---- false --");
        self.loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        nav = [[UINavigationController alloc] initWithRootViewController:self.loginView];
        self.navController.navigationBarHidden=YES;
        
        self.navController = nav;
        self.window.rootViewController = self.navController;
        [self.window makeKeyAndVisible];

        
       // [UIApplication sharedApplication].keyWindow.rootViewController = self.viewController;
        //[[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
    }
    
    
    
    
    [self.navController.navigationBar setBarTintColor:[UIColor colorWithRed:230.0/255.0 green:229.0/255.0 blue:231.0/255.0 alpha:1.0]];
    
    
    // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0];
        [self.window.rootViewController.view addSubview:view];
    }
}
/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

/*-(void)checkSession
 {
     Email = [[NSUserDefaults standardUserDefaults] valueForKey:@"Username"];
     Pass = [[NSUserDefaults standardUserDefaults] valueForKey:@"Password"];
     NSLog(@"Email.....%@",Email);
     NSLog(@"Password......%@",Pass);
     
     NSInteger EmailLength=[Email length];
     NSInteger PassLength=[Pass length];
 
     if(EmailLength<=0 && PassLength<=0)
     {
         self.loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.loginView];
         self.navController = nav;
         self.navController.navigationBarHidden=YES;
         self.window.rootViewController = self.navController;
         [self.window makeKeyAndVisible];
 
     }
     else
     {
         self.appFirstView=[[AppFirstViewController alloc]initWithNibName:@"AppFirstViewController" bundle:nil];    
         UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:self.appFirstView];
         self.navController=nav1;
         self.window.rootViewController = self.navController;
         [self.window makeKeyAndVisible];
         [self addTabBar];
 
     }
 }
*/
/*- (void) removeTabBar
{
    
    //    [self.window addSubview:tabBarController.view];
    
    [_tabBarController.view removeFromSuperview];
    
    
}*/
@end
