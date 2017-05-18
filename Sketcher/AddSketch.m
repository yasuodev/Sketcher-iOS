//
//  AddSketch.m
//  Sketcher
//
//  Created by Sanjay Shekhawat on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddSketch.h"
#import "JSON.h"
#import "AppAppDelegate.h"
#import "AppFirstViewController.h"
@interface AddSketch ()
{
    //UIView *viewKeyButton;
}
@end

#define TitleMaxLength 30
#define IdeaMaxLength  140

@implementation AddSketch
//@synthesize txtTitle;
@synthesize txtAreaIdea,txtviewTitle;
@synthesize btnsubmit,owenerId,activity,barbuttonR,scrollView,barbuttonL;

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
    [super viewDidLoad];
    
    [activity setHidden:YES];
    self.title = @"New Idea";
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    }
    btnsubmit.layer.cornerRadius=5.00;
  
    barbuttonR=[[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submit_idea)];
    barbuttonR.tintColor = [UIColor colorWithRed:3.0/255.0 green:101.0/255.0 blue:192.0/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem=barbuttonR;
    
    
    barbuttonL=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel_idea)];
    barbuttonL.tintColor = [UIColor colorWithRed:3.0/255.0 green:101.0/255.0 blue:192.0/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem=barbuttonL;
     
    
    
    
    
    //scrollView.frame = CGRectMake(0, 0, 320 , 416);
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width,self.scrollView.frame.size.height)];
  //  [self.view addSubview:scrollView];
    
    
   /* viewKeyButton = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 170, 58, 30)];
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 58, 30)];
    btnDone.layer.cornerRadius=5.00;
    [btnDone setTitle:@"Hide" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(HideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone setBackgroundColor:[UIColor grayColor]];
    [viewKeyButton addSubview:btnDone];
    
    [self.view addSubview:viewKeyButton];
    [viewKeyButton setHidden:YES];*/

     NSLog(@"txtviewTitle----%f",txtviewTitle.frame.origin.y);
}

- (void)viewDidUnload
{
    [self setTxtviewTitle:nil];
    [self setTxtAreaIdea:nil];
    [self setBtnsubmit:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(BOOL)trimmedStringContainSpace:(NSString *)inputStr
{
    
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [inputStr stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}

-(void)cancel_idea
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)submit_idea
{
    NSString *message;
    int i=1;
    NSString *str = @"         ";
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[str stringByTrimmingCharactersInSet: set] length] == 0)
    {
        // String contains only whitespace.
    }
    if([txtviewTitle.text length]<=0 || [txtviewTitle.text isEqualToString:@"Write down a working title for your idea in maximum 30 characters"] || [self trimmedStringContainSpace:txtviewTitle.text])
    {
        message=@"Title Can't Empty";
        UIAlertView *ai=[[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [ai show];
        i=0;
    }
    else if([txtAreaIdea.text length]<=0 || [txtAreaIdea.text isEqualToString:@"Write down a essence of the idea in maximum 140 characters"]||[self trimmedStringContainSpace:txtAreaIdea.text])
    {
        message=@"Idea can't Empty";
        UIAlertView *ai=[[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [ai show];
        i=0;
    }
    
    if(i==1)
    {
        if([self connected])
        {
            [self callWebService];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
           [activity stopAnimating];
            [activity setHidden:YES];
        }
    }
        
    
    
    
    
}
- (IBAction)btnSubmitClick:(id)sender
{
    NSString *message;
    int i=1;
    if([txtviewTitle.text length]<=0)
    {
        message=@"Title Can't Empty";
        UIAlertView *ai=[[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [ai show];
        i=0;
    }
    else if([txtAreaIdea.text length]<=0)
    {
        message=@"Idea can't Empty";
        UIAlertView *ai=[[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [ai show];
        i=0;
    }
    
    if(i==1)
        [self callWebService];
    
    
    
       
}

-(void)callWebService
{
    
    [activity setHidden:NO];
    [activity startAnimating];

    self.owenerId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    
    NSString *sketch_title =[txtviewTitle.text urlEncode];
    NSString *sketch_idea = [txtAreaIdea.text urlEncode];
    
  
    
    
  
     NSString *strurl= WEBSERVICEURL;


    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<urn:AddNewSketch soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                           "<owner_id xsi:type=\"xsd:string\">%@</owner_id>\n"
                           "<sketch_title xsi:type=\"xsd:string\">%@</sketch_title>\n"
                           "<original_idea xsi:type=\"xsd:string\">%@</original_idea>\n"
                           "<isPublic xsi:type=\"xsd:string\">%@</isPublic>\n"
                           "</urn:AddNewSketch>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>",self.owenerId,sketch_title,sketch_idea,@"1"
                           ];

    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];

    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#AddNewSketch" forHTTPHeaderField:@"SOAPAction"];
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
    if (!webData) 
    {
        webData = [[NSMutableData alloc] init];
    }
    [webData appendData:data];
    NSLog(@"did receive data");
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    
    NSLog(@"connection Error:%@",[error description]);
   [activity stopAnimating];
    [activity setHidden:YES];
    
    UIAlertView *alertFParser = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Internet Connection Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertFParser show];
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    [activity stopAnimating];
    [activity setHidden:YES];
        
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    NSLog(@"showing webservice data on console");
    NSLog(@"Response:%@",responseString);
    // [responseString release];
    
    if (xmlParser != nil) 
    {
        xmlParser = nil;
    }
    
    xmlParser = [[NSXMLParser alloc] initWithData:webData];
	[xmlParser setDelegate:self];
	[xmlParser parse];
    
 	
    xmlParser = nil;
    webData = nil;
    NSLog(@"result:");
    [self parseJsonResult:responseString];
    
}



-(void) parseJsonResult:(NSString *)_respponseString
{
    /*
     {
     "Status":true,
     "Message":"Sketch successfully added.",
     "sketchID":2}
     */
    NSDictionary *dict=[_respponseString JSONValue];
    success=[[dict valueForKey:@"Status"]boolValue];
    if(success)
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        NSString *sketchID=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sketchID"]];
        NSString *abc=@"sketchID :";
        [abc stringByAppendingFormat:sketchID];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:Message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
        //[self.navigationController popViewControllerAnimated:YES];
         AppFirstViewController*skD = [[AppFirstViewController alloc] initWithNibName:@"AppFirstViewController" bundle:nil ];
        skD.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:skD animated:YES];


    }
    else 
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
        NSString *Error = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Error"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
            Error = @"";
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:Message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

//- (IBAction)textFieldDoneEditing:(id)sender
//{
//    [txtTitle becomeFirstResponder];
//}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if([text isEqualToString:@"\n"])
//        [textView resignFirstResponder];
   
    
    
    NSString* parameterStr=@"";
    parameterStr=[[textView text] stringByAppendingString:text];
    if (textView == txtviewTitle)
    {
         txtviewTitle.textColor = [UIColor blackColor];
        if(parameterStr.length<=TitleMaxLength)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else if ( textView == txtAreaIdea)
    {
        txtAreaIdea.textColor = [UIColor blackColor];
        if(parameterStr.length<=IdeaMaxLength)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else{
        return YES;
    }
    
    
}

-(void)btnLogoutpressed
{
    //AppAppDelegate *appDelegate = (AppAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //[appDelegate removeTabBar];
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView == txtviewTitle)
    {
//        [viewKeyButton setHidden:NO];
//        
//       
//        
//        viewKeyButton.frame = CGRectMake(self.view.frame.size.width-60, txtviewTitle.frame.origin.y+20, viewKeyButton.frame.size.width, viewKeyButton.frame.size.height);
//         NSLog(@"viewKeyButton----%f",viewKeyButton.frame.origin.y);
        txtviewTitle.textColor =[UIColor blackColor];
        if([textView.text isEqualToString:@"Write down a working title for your idea in maximum 30 characters"])
        {
            textView.text =@"";
            
        }
        if(txtAreaIdea.text.length == 0 || [txtAreaIdea.text isEqualToString:@"Write down a essence of the idea in maximum 140 characters"])
        {
            txtAreaIdea.textColor = [UIColor lightGrayColor];
            txtAreaIdea.text =@"Write down a essence of the idea in maximum 140 characters";
        }
        
    }
    else if (textView == txtAreaIdea)
    {
//        viewKeyButton.frame = CGRectMake(self.view.frame.size.width-60, txtAreaIdea.frame.origin.y, viewKeyButton.frame.size.width, viewKeyButton.frame.size.height);
//        [viewKeyButton setHidden:NO];
        txtAreaIdea.textColor =[UIColor blackColor];
        if([textView.text isEqualToString:@"Write down a essence of the idea in maximum 140 characters"])
        {
            textView.text =@"";
            
        }
        if(txtviewTitle.text.length == 0 || [txtviewTitle.text isEqualToString:@"Write down a working title for your idea in maximum 30 characters"])
        {
            txtviewTitle.textColor = [UIColor lightGrayColor];
             txtviewTitle.text =@"Write down a working title for your idea in maximum 30 characters";
        }
        
    }
   return YES;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(void)HideKeyboard
{
    if(txtAreaIdea.text.length == 0 || [txtAreaIdea.text isEqualToString:@"Write down a essence of the idea in maximum 140 characters"])
    {
        txtAreaIdea.textColor = [UIColor lightGrayColor];
        txtAreaIdea.text =@"Write down a essence of the idea in maximum 140 characters";
    }
    if(txtviewTitle.text.length == 0 || [txtviewTitle.text isEqualToString:@"Write down a working title for your idea in maximum 30 characters"])
    {
        txtviewTitle.textColor = [UIColor lightGrayColor];
        txtviewTitle.text = @"Write down a working title for your idea in maximum 30 characters";
    }

    [txtAreaIdea resignFirstResponder];
    [txtviewTitle resignFirstResponder];
    //    [viewKeyButton setHidden:YES];
}



@end
