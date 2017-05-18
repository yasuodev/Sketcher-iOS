//
//  AppSecondViewController.h
//  Sketcher
//
//  Created by CS on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SWRevealViewController.h"
@interface AppSecondViewController : UIViewController<MFMailComposeViewControllerDelegate> 


@property (strong, nonatomic) IBOutlet UITextView *txtView;

//-(IBAction)showPicker:(id)sender;
//-(void)displayComposerSheet;
-(void)btnClick;
//-(void)launchMailAppOnDevice;

@end
