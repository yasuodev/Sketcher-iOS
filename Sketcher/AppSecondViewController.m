//
//  AppSecondViewController.m
//  Sketcher
//
//  Created by CS on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppSecondViewController.h"

@interface AppSecondViewController ()

@end

@implementation AppSecondViewController
@synthesize txtView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"About StartupSketcher.org";
        
    }
    return self;
}
							
- (void)viewDidLoad
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    }
    self.title=@"About StartupSketcher.org";
    //[self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:230.0/255.0 green:229.0/255.0 blue:231.0/255.0 alpha:1.0]];
    SWRevealViewController *revealController = [self revealViewController];
    
    
    UIButton *barbuttonL = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 22, 18)];
    [barbuttonL setBackgroundImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
    
    [barbuttonL addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barbuttonL];
    self.navigationItem.leftBarButtonItem =revealButtonItem;
    
   /* CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, 50);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor whiteColor]];
    [v setAlpha:0.5];
    [[self.tabBarController tabBar] insertSubview:v atIndex:1];
    //[v release];
    
    
    
    UIView *btnView=[[UIView alloc]initWithFrame:CGRectMake(33, 249, 273, 32)];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 273, 32)];
    [btn setTitle:@"info@startupsketcher.org" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [btnView addSubview:btn];
    [self.view addSubview:btnView];*/
 /* 
  
  btnDone.layer.cornerRadius=5.00;
  [btnDone setTitle:@"Done" forState:UIControlStateNormal];
  [btnDone addTarget:self action:@selector(HideKeyboard) forControlEvents:UIControlEventTouchUpInside];

  
  
  
  txtView.text = @"info@startupsketcher.org";
    txtView.editable = NO;
    txtView.dataDetectorTypes = UIDataDetectorTypeLink;
   */ 
    //cell is the TableView's cell    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)aas
{
    NSLog(@"btnclick...");
}
- (void)viewDidUnload
{
    
    [self setTxtView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(IBAction)btnClick:(id)sender
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Contact from Startup Sketcher iPhone app"];
    
    // Set up recipients
    //NSArray *toRecipients = [NSArray arrayWithObject:@"abc@gmail.com"];
 //   NSArray *toRecipients = [NSArray arrayWithObject:@"info@startupsketcher.org"];
    //NSLog(@"toRecipients...%@",toRecipients);
    
    NSString *emailBody = @"Nice  to See you!";
    
    [picker setMessageBody:emailBody isHTML:NO];
    [picker setToRecipients:[NSArray arrayWithObject:@"info@startupsketcher.org"]];
    
    
    [self presentModalViewController:picker animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
   /* message.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message.text = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            message.text = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            message.text = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            message.text = @"Result: failed";
            break;
        default:
            message.text = @"Result: not sent";
            break;
    }*/
    [self dismissModalViewControllerAnimated:YES];

}

@end
