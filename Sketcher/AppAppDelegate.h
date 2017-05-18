//
//  AppAppDelegate.h
//  Sketcher
//
//  Created by CS on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@class LoginViewController;
@class CustomUITabBarController;
//@class AppFirstViewController;

@interface AppAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,NSXMLParserDelegate,NSURLConnectionDelegate,SWRevealViewControllerDelegate>
{
    NSString *Email,*Pass;
    NSURLConnection *_connection;
    NSXMLParser *xmlParser;
    NSMutableData *webData;
    BOOL success;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property(strong,nonatomic) AppFirstViewController *appFirstView;

//@property (strong, nonatomic) UITabBarController *tabBarController;
@property(strong,nonatomic)NSString *Email,*Pass;
@property(strong,nonatomic) UINavigationController *navController;

//@property(strong,nonatomic) CustomUITabBarController *tabBarController;


//- (void) addTabBar;
//- (void) removeTabBar;

//-(void)CallWebService;
@end
