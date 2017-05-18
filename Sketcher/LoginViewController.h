//
//  LoginViewController.h
//  Sketcher
//
//  Created by Sanjay Shekhawat on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate,NSURLConnectionDelegate, UIScrollViewDelegate,SWRevealViewControllerDelegate>
{
   
 UIScrollView *scrollView;

    NSURLConnection *_connection;
    NSXMLParser *xmlParser;
    NSMutableData *webData;
    
    NSString *user,*pass;
    UIActivityIndicatorView *activity;
    BOOL success,checkboxSelected,isCheck;
    
    IBOutlet UIButton *checkboxButton;
    
    IBOutlet UIView *bttn_View;
    IBOutlet UIButton *bttn_remember_me;

}
@property(nonatomic,retain) IBOutlet UIButton *checkboxButton;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPass;
@property(strong, nonatomic) IBOutlet UIButton *btnLogin;
@property(strong, nonatomic) IBOutlet UIButton *btnRegister;
@property(nonatomic,retain)NSString *user,*pass;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activity;
- (IBAction)btnloginclick:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnRegisterClick:(id)sender;
-(void)CallwebService;
//-(void) checkNetworkStatus:(NSNotification *)notice;
@end
