//
//  ForgotPasswordController.m
//  Sketcher
//
//  Created by Sanjay on 19/08/16.
//
//

#import "ForgotPasswordController.h"

@interface ForgotPasswordController ()
{
    NSURLConnection *_connection;
    NSMutableData *webData;
      NSXMLParser *xmlParser;
}
@end

@implementation ForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    lbl_error.hidden = true;
    activity.hidden = true;
    self.navigationController.navigationBarHidden = false;
    view_Having_bttn.hidden = true;
    txt_fld_email.delegate =self;
    txt_fld_email.layer.cornerRadius = 15.0;
    txt_fld_email.layer.borderWidth = 0.5;
    txt_fld_email.layer.borderColor = [UIColor grayColor].CGColor;
    txt_fld_email.autocorrectionType = UITextAutocorrectionTypeNo;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)bttn_reset_password_pressed:(id)sender
{
    NSLog(@"txt_fld_email---- reset calling");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    bg_scrollView.frame=CGRectMake(0,0, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
    [UIView commitAnimations];
    [txt_fld_email resignFirstResponder];
    
   if(txt_fld_email.text.length ==0)
   {
       txt_fld_email.layer.borderColor = [UIColor redColor].CGColor;
       lbl_error.hidden = false;
       lbl_error.text =@"E-mail field cannot be empty.Please enter an e-mail address!";
   }
   else
    {
         lbl_error.hidden = true;
        if([self connected])
        {
            [self callWebServiceForForgotPassword];
        }
        else
        {
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }
        
        
    }
}
-(IBAction)bttn_back_to_login_screen_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    lbl_error.hidden = true;
    lbl_error.text=@"";
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    bg_scrollView.frame=CGRectMake(0,-220, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
    [UIView commitAnimations];
    textField.text=@"";
    
    
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    bg_scrollView.frame=CGRectMake(0,0, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
    [UIView commitAnimations];
    
    //[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];
    
    [sender resignFirstResponder];
    
}
-(void)show_bttn_View_with_Delay
{
    self.navigationController.navigationBarHidden = true;
    view_Having_email.hidden = true;
     view_Having_bttn.hidden = false;
//    [UIView animateWithDuration:1.5 animations:UIViewAnimationCurveEaseIn completion:^(BOOL finished) {
//   
//        
//        view_Having_bttn.hidden = false;
//    }];
    
    
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
#pragma mark - Webservice Methods
-(void)callWebServiceForForgotPassword
{
    
    [txt_fld_email resignFirstResponder];
    [activity startAnimating];
    [activity setHidden:NO];
    
    
    NSString *strurl= WEBSERVICEURL;
    
    
   
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">"
                           "<soapenv:Header/>"
                           "<soapenv:Body>"
                           "<urn:forgotPassword soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">"
                           "<email xsi:type=\"xsd:string\">%@</email>"
                           "</urn:forgotPassword>"
                           "</soapenv:Body>"
                           "</soapenv:Envelope>",txt_fld_email.text
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#forgotPassword" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
}
#pragma mark - NSURLConnection Delegate
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
    [activity stopAnimating];
    [activity setHidden:YES];
    
    UIAlertView *alertFParser = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connectivity!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertFParser show];
    // [alertFParser release];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [activity stopAnimating];
    [activity setHidden:YES];
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *dict=[responseString JSONValue];
    BOOL status = [[dict valueForKey:@"Status"] boolValue];
    if(status)
    {
         lbl_error.hidden = true;
        NSString *message = [dict valueForKey:@"Message"];
        lbl_success.text =[NSString stringWithFormat:@"%@",message];
        [self performSelector:@selector(show_bttn_View_with_Delay) withObject:nil afterDelay:0.8];
    }
    else
    {
        NSString *Message = [dict valueForKey:@"Message"];
        
//        UIAlertView *alertt = [[UIAlertView alloc] initWithTitle:Message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertt show];
        lbl_error.hidden = false;  
        txt_fld_email.layer.borderColor = [UIColor redColor].CGColor;
        lbl_error.text =Message;
        
    }
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
