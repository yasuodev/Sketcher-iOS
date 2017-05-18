//
//  LoginViewController.m
//  Sketcher
//
//  Created by Sanjay Shekhawat on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppAppDelegate.h"
#import "JSON.h"
#import "AppFirstViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"

@interface LoginViewController ()

{
    Reachability* internetReachable;
    Reachability* hostReachable;
}
@end

@implementation LoginViewController

@synthesize txtUserName;
@synthesize txtPass;
@synthesize btnLogin,btnRegister;
@synthesize user,pass,activity,checkboxButton,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    txtUserName.delegate=self;
    txtPass.delegate=self;
    txtPass.secureTextEntry=YES;
    txtPass.delegate=self;
     NSLog(@"viewDidLoad");
    
    checkboxSelected=NO;
    isCheck=NO;
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width,self.scrollView.frame.size.height)];
   // [self.view addSubview:scrollView];
    
    [activity setHidden:YES];
    btnLogin.layer.cornerRadius = 5.00;
    btnRegister.layer.cornerRadius=5.00;
    [super viewDidLoad];
    
    txtUserName.layer.cornerRadius = 15.0;
    txtPass.layer.cornerRadius = 15.0;
    txtUserName.layer.borderWidth = 0.5;
    txtUserName.layer.borderColor = [UIColor grayColor].CGColor;
    
    txtPass.layer.borderWidth = 0.5;
    txtPass.layer.borderColor =[UIColor grayColor].CGColor;
    // Do any additional setup after loading the view from its nib.
    
    
   
}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    NSString *is_remember_user = [[NSUserDefaults standardUserDefaults] valueForKey:@"is_remember_user"];
    if([is_remember_user isEqualToString:@"TRUE"])
    {
        [bttn_remember_me setBackgroundImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
        txtUserName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Username"];
        txtPass.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Password"];
    }
    else
    {
        [bttn_remember_me setBackgroundImage:[UIImage imageNamed:@"checkbox-unchecked-md.png"] forState:UIControlStateNormal];
         txtUserName.text =@"";
         txtPass.text =@"";
    }
    
    [txtPass resignFirstResponder];
    [txtUserName resignFirstResponder];
    self.navigationController.navigationBarHidden = true;
    //[self.scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];

}

- (void)viewDidUnload
{ NSLog(@"viewDidUnload");
        
    [self setTxtUserName:nil];
    [self setTxtPass:nil];
    //[self.scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillUnload
{
    NSLog(@"viewWillUnload");
   // [txtPass resignFirstResponder];
  //  [txtUserName resignFirstResponder];
 //   [self.scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];

}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    [self textFieldDoneEditing:txtUserName];
    [self textFieldDoneEditing:txtPass];
    // [txtPass resignFirstResponder];
    //[txtUserName resignFirstResponder];
  //  [self.scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];
    

}

-(void)viewDidDisappear:(BOOL)animated
{
    [txtPass resignFirstResponder];
    [txtUserName resignFirstResponder];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}



- (IBAction)btnloginclick:(id)sender 
{
    NSLog(@"aaaaaaaa");
    
    [activity setHidden:NO];
    [activity startAnimating];
    
    // AppAppDelegate *appDelegate=(AppAppDelegate *)[[UIApplication sharedApplication] delegate];
    // [appDelegate addTabBar];
    //[txtPass resignFirstResponder];
    //[txtUserName resignFirstResponder];
    //[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];

    if([bttn_remember_me.currentBackgroundImage isEqual:[UIImage imageNamed:@"checked_checkbox.png"]])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"TRUE" forKey:@"is_remember_user"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"FALSE" forKey:@"is_remember_user"];
    }
    
    if([self connected])
    {
        [self CallwebService];
    }
    else
    {
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:nil message:@"Please check your internet connectivity!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity setHidden:YES];
        [activity stopAnimating];
    }
    
    
    
    //[self viewDidDisappear:YES];
    [self viewWillDisappear:YES];
    
    
}

-(void)CallwebService
{
    user=txtUserName.text;
    pass=txtPass.text;
    
  
    NSString * strurl= WEBSERVICEURL;
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<urn:UserLogin soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                           "<user_email xsi:type=\"xsd:string\">%@</user_email>\n"
                           "<password xsi:type=\"xsd:string\">%@</password>\n"
                           "</urn:UserLogin>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>",user,pass
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#UserLogin" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"did receive response");
    
    [webData setLength:0];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //[webServiceData appendData:webData];
    if (!webData) 
    {
        webData = [[NSMutableData alloc] init];
    }
    [webData appendData:data];
    NSLog(@"did receive data");
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"connection Error:%@",[error description]);
    
    [activity setHidden:YES];
    [activity stopAnimating];
    
    UIAlertView *alertFParser = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connectivity!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertFParser show];
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    [activity setHidden:YES];
    [activity stopAnimating];
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    NSLog(@"showing webservice data on console");
    NSLog(@"Response:%@",responseString);
    // [responseString release];
    
    if (xmlParser != nil) 
    {
        //    [xmlParser release];
        xmlParser = nil;
    }
    
    xmlParser = [[NSXMLParser alloc] initWithData:webData];
	[xmlParser setDelegate:self];
	[xmlParser parse];
    
 	
    //	[xmlParser release];
    xmlParser = nil;
    //  [webData release];
    webData = nil;
    
    NSLog(@"result:");
    [self parseJsonResult:responseString];
    
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"parserStart");
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
   
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
       
}


- (void) parseJsonResult:(NSString *) _respponseString
{
    
    [activity setHidden:YES];
    [activity stopAnimating];
    
    /*
     {"Status": true, "Message":"Logged in successfully.","UserID":"556358169"}
     */
    
    NSDictionary *dict = [_respponseString JSONValue];
    success= [[dict valueForKey:@"Status"]boolValue];
    NSLog(@"success : %d",success);
    
    
    if (success)
    {
        [btnLogin setUserInteractionEnabled:YES];
        [txtPass resignFirstResponder];
        NSLog(@"hello.....");
        
        NSString *UserID=[NSString stringWithFormat:@"%@",[dict valueForKey:@"UserID"]];
        NSString *Message = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dict valueForKey:@"UserName"] forKey:@"username_val"];
        
        
        if ((NSNull *) UserID == [NSNull null] || [UserID length] == 0) {
            UserID=@"";
        }
        
        NSLog(@"test3");
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        NSLog(@"UserID:%@",UserID);
        NSLog(@"Message:%@",Message);
        
        NSLog(@"zzzz......%d",isCheck);
        
//        if(isCheck)
//        {
//        NSString *ab=txtUserName.text;
//        NSLog(@"abcvd.....%@",ab);
//        [[NSUserDefaults standardUserDefaults] setValue:txtUserName.text forKey:@"Username"];
//        [[NSUserDefaults standardUserDefaults] setValue:txtPass.text forKey:@"Password"];
//        
//        }
//        else
//        {
//            txtUserName.text=@"";
//            txtPass.text=@"";
//        }
        
        NSString *is_remember_user = [[NSUserDefaults standardUserDefaults] valueForKey:@"is_remember_user"];
        if([is_remember_user isEqualToString:@"TRUE"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:txtUserName.text forKey:@"Username"];
            [[NSUserDefaults standardUserDefaults] setValue:txtPass.text forKey:@"Password"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Username"];
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Password"];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:UserID forKey:@"UserID"];
        
        NSString *E = [[NSUserDefaults standardUserDefaults] valueForKey:@"Username"];
        NSLog(@"aaaaaaaa.....%@",E);
        
       // AppAppDelegate *appDelegate = (AppAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //[appDelegate addTabBar];

        
        
       //AppFirstViewController *as = [[AppFirstViewController alloc]initWithNibName:@"AppFirstViewController" bundle:nil ];
        //[self.navigationController pushViewController:as animated:YES];
        AppFirstViewController *frontViewController = [[AppFirstViewController alloc] init];
        RearViewController *rearViewController = [[RearViewController alloc] init];
      
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
      
        UINavigationController *rarNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                        initWithRearViewController:rarNavigationController frontViewController:frontNavigationController];
        
        mainRevealController.delegate = self;
        
        self.viewController = mainRevealController;
        
        [UIApplication sharedApplication].keyWindow.rootViewController = self.viewController;
        [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
        
    }
    else
    {
        
        [btnLogin setUserInteractionEnabled:YES];
        NSString *Message = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
        NSString *msg;
        if([Message isEqualToString:@"Invalid email-address or password."])
        {
            msg=@"Invalid username or password.";
        }
       
        
        NSString *Error = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Error"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
            Error = @"";
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:msg message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.scrollView.frame=CGRectMake(0,-220, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [UIView commitAnimations];
    textField.text=@"";

	
}

- (IBAction)textFieldDoneEditing:(id)sender 
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.scrollView.frame=CGRectMake(0,0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [UIView commitAnimations];
   
    //[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];

    [sender resignFirstResponder];
        
}


- (IBAction)checkboxButton:(id)sender
{
    if (checkboxSelected) 
    {
        [self.checkboxButton setSelected:NO];
		checkboxSelected=NO;
        [self.checkboxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        
    }
    
    else 
    {
        
        [self.checkboxButton setSelected:YES];
		isCheck=YES;
        checkboxSelected=YES;
        NSLog(@"Selected......");
        
        
        [self.checkboxButton setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    [self.checkboxButton setSelected:YES];
}


- (IBAction)btnRegisterClick:(id)sender 
{
        RegisterViewController *as = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil ];
        [self.navigationController pushViewController:as animated:YES];
    
    
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://startupsketcher.org/register.php"]];
    
}

-(IBAction)bttnForgotPassword:(id)sender
{
     ForgotPasswordController *as = [[ForgotPasswordController alloc]initWithNibName:@"ForgotPasswordController" bundle:nil ];
    [self.navigationController pushViewController:as animated:YES];
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://startupsketcher.org/forgot.php"]];

}
-(IBAction)bttn_remember_me_pressed:(id)sender
{
    UIButton *bttn = (UIButton*)sender;
    if([bttn.currentBackgroundImage isEqual:[UIImage imageNamed:@"checkbox-unchecked-md.png"]])
    {
        [bttn setBackgroundImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [bttn setBackgroundImage:[UIImage imageNamed:@"checkbox-unchecked-md.png"] forState:UIControlStateNormal];
        
    }
}

@end
