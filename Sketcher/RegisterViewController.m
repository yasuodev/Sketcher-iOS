//
//  RegisterViewController.m
//  Sketcher
//
//  Created by Sanjay on 19/08/16.
//
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    NSMutableArray *sortedCountryArray;
    NSMutableArray *searchedArray;
    NSURLConnection *_connection;
    NSMutableData *webData;
    
    BOOL isCheckUserName;
    BOOL isRegister;

    BOOL isUserNameDone;
    
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [activity setHidden:TRUE];
    [lbl_error_username setHidden:TRUE];
    [lbl_error_email setHidden:TRUE];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = false;
    view_having_back_bttn.hidden = true;
    [tbl_view_country_list setHidden:TRUE];
    
    
    isUserNameDone =TRUE;
    
    bg_scrollView.contentSize = CGSizeMake(bg_scrollView.frame.size.width,bttn_create_account.frame.origin.y+bttn_create_account.frame.size.height+50 );
    parent_Scrollview.contentSize = CGSizeMake(parent_Scrollview.frame.size.width,parent_Scrollview.frame.size.height+10 );
    
    
    
    tbl_view_country_list.layer.cornerRadius = 1.5;
    tbl_view_country_list.layer.borderWidth = 0.5;
    tbl_view_country_list.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    txt_fld_full_name.layer.cornerRadius = 15.0;
    txt_fld_full_name.layer.borderWidth = 0.5;
    txt_fld_full_name.layer.borderColor = [UIColor grayColor].CGColor;
    
    txt_fld_country.layer.cornerRadius = 15.0;
    txt_fld_country.layer.borderWidth = 0.5;
    txt_fld_country.layer.borderColor = [UIColor grayColor].CGColor;
    
    txt_fld_username.layer.cornerRadius = 15.0;
    txt_fld_username.layer.borderWidth = 0.5;
    txt_fld_username.layer.borderColor = [UIColor grayColor].CGColor;
    
    txt_fld_password.layer.cornerRadius = 15.0;
    txt_fld_password.layer.borderWidth = 0.5;
    txt_fld_password.layer.borderColor = [UIColor grayColor].CGColor;
    
    txt_fld_retype_password.layer.cornerRadius = 15.0;
    txt_fld_retype_password.layer.borderWidth = 0.5;
    txt_fld_retype_password.layer.borderColor = [UIColor grayColor].CGColor;
    
    txt_fld_email.layer.cornerRadius = 15.0;
    txt_fld_email.layer.borderWidth = 0.5;
    txt_fld_email.layer.borderColor = [UIColor grayColor].CGColor;
    
    txt_fld_full_name.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_fld_country.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_fld_username.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_fld_password.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_fld_retype_password.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_fld_email.autocorrectionType = UITextAutocorrectionTypeNo;
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    sortedCountryArray= [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
        
    }
    
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    searchedArray = [[NSMutableArray alloc] initWithArray:sortedCountryArray];
    [tbl_view_country_list reloadData];
  //  NSLog(@"sortedCountryArray----- country list ---%@",[sortedCountryArray description]);

}
#pragma mark - Webservice Methods
-(void)callWebserviceForCheckUserName
{
    
    
    isCheckUserName = TRUE;
    isRegister = FALSE;
    
    
  
    NSString *strurl= WEBSERVICEURL;
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">"
                           "<soapenv:Header/>"
                           "<soapenv:Body>"
                           "<urn:checkuser soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">"
                           "<username xsi:type=\"xsd:string\">%@</username>"
                           "</urn:checkuser>"
                           "</soapenv:Body>"
                           "</soapenv:Envelope>",[txt_fld_username.text urlEncode]
                           ];
    
    NSLog(@"callWebserviceForCheckUserName  %@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#checkuser" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
}
-(void)callWebServiceForRegisterUser
{
    [activity startAnimating];
    [activity setHidden:FALSE];
    isCheckUserName = FALSE;
    isRegister = TRUE;
  
     NSString *strurl= WEBSERVICEURL;
    
    NSString *fullName= [txt_fld_full_name.text urlEncode];
    NSString *country = [txt_fld_country.text urlEncode];
    NSString *userNAme= [txt_fld_username.text urlEncode];
    NSString *email =[txt_fld_email.text urlEncode];
    NSString *password= [txt_fld_password.text urlEncode];
    NSString *retype_password = [txt_fld_retype_password.text urlEncode];
    
    
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">"
                           "<soapenv:Header/>"
                           "<soapenv:Body>"
                           "<urn:register soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">"
                           "<fullname xsi:type=\"xsd:string\">%@</fullname>"
                           "<country xsi:type=\"xsd:string\">%@</country>"
                           "<username xsi:type=\"xsd:string\">%@</username>"
                           "<password xsi:type=\"xsd:string\">%@</password>"
                           "<retypepassword xsi:type=\"xsd:string\">%@</retypepassword>"
                           "<useremail xsi:type=\"xsd:string\">%@</useremail>"
                           "</urn:register>"
                           "</soapenv:Body>"
                           "</soapenv:Envelope>",fullName,country,userNAme,password,retype_password,txt_fld_email.text
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#register" forHTTPHeaderField:@"SOAPAction"];
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
    [activity setHidden:TRUE];
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString-------%@",responseString);
    
   
    if(isCheckUserName)
    {
         NSDictionary *dict =[responseString JSONValue];
        BOOL status =[[dict valueForKey:@"Status"] boolValue];
        if(status)
        {
            lbl_error_username.hidden = true;
        }
        else
        {
            txt_fld_username.layer.borderColor = [UIColor redColor].CGColor;
            lbl_error_username.hidden = false;
            lbl_error_username.text =@"ERROR - The username already exists. Please try again with different username.";
        }
        
    }
    if(isRegister)
    {
        
        
        if([[responseString JSONValue] isKindOfClass:[NSArray class]])
        {
            NSArray *status_arry =[responseString JSONValue];
            if(status_arry.count>0)
            {
                for(int i=0;i<status_arry.count;i++)
                {
                    NSDictionary *dictInide =[status_arry objectAtIndex:i];
                    NSString *fieldName =[dictInide valueForKey:@"fieldname"];
                    if([fieldName isEqualToString:@"email"])
                    {
                        lbl_error_email.hidden = FALSE;
                        lbl_error_email.text =[dictInide valueForKey:@"Message"];
                    }
                    if([fieldName isEqualToString:@"username"])
                    {
                        lbl_error_username.hidden = FALSE;
                        lbl_error_username.text =[dictInide valueForKey:@"Message"];
                    }
                    
                }
                
                
            }
        }
        else if([[responseString JSONValue] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict =[responseString JSONValue];
            BOOL status = [[dict valueForKey:@"Status"] boolValue];
            if(status)
            {
                self.navigationController.navigationBarHidden = TRUE;
                NSString *message = [dict valueForKey:@"Message"];
                lbl_success.text =[NSString stringWithFormat:@"%@",message];
                [self performSelector:@selector(showNextSuccessViewWtih_Delay) withObject:nil afterDelay:0.5];
            }
            else
            {
                NSString *errorMessage =[dict valueForKey:@"Message"];
                NSString *fieldname = [dict valueForKey:@"fieldname"];
                if([fieldname isEqualToString:@"username"])
                {
                    lbl_error_username.text =errorMessage;
                    [lbl_error_username setHidden:FALSE];
                }
                else if([fieldname isEqualToString:@"email"])
                {
                    lbl_error_email.text = errorMessage;
                    [lbl_error_email setHidden:FALSE];
                }
                else if([errorMessage isEqualToString:@"ERROR - Invalid name. Please enter atleast 3 or more characters for your name."])
                {
                    lbl_error_email.text = errorMessage;
                    [lbl_error_email setHidden:FALSE];
                }
                else
                {
                    lbl_error_email.text = errorMessage;
                    [lbl_error_email setHidden:FALSE];
                }
                
                
                
            }
            
        }
       
        
        
        
    }
}
#pragma mark -TextField Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
      isUserNameDone =TRUE;
    [lbl_error_username setHidden:TRUE];
    [lbl_error_email setHidden:TRUE];
    
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    
    if(textField == txt_fld_country)
    {
        textField.text=@"";
        
        [tbl_view_country_list setHidden:FALSE];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        bg_scrollView.frame=CGRectMake(0,0, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
        [UIView commitAnimations];

    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        bg_scrollView.frame=CGRectMake(0,-220, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
        [UIView commitAnimations];
        textField.text=@"";
        [tbl_view_country_list setHidden:TRUE];
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField ==txt_fld_username)
    {
        if([self connected])
        {
            NSLog(@"Done editing----check user nae exist or not---");
            if(isUserNameDone)
            {
                [self callWebserviceForCheckUserName];
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }
        isRegister = FALSE;
    }
    if(textField == txt_fld_country)
    {
        [tbl_view_country_list setHidden:TRUE];
        [searchedArray removeAllObjects];
        searchedArray = [[NSMutableArray alloc] initWithArray:sortedCountryArray];

    }
    [tbl_view_country_list setHidden:TRUE];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if(textField == txt_fld_country)
    {
        NSLog(@"%@",searchStr);
        if(searchStr.length>=2)
        {
            [searchedArray removeAllObjects];
            [self searchByInput:searchStr];
            [tbl_view_country_list setHidden:FALSE];
        }
        else
        {
            [tbl_view_country_list setHidden:TRUE];
            
        }
        return YES;
        
    }
    else
    {
        return YES;
    }
    return YES;
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    
    UITextField *textField = (UITextField*)sender;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    bg_scrollView.frame=CGRectMake(0,0, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
    [UIView commitAnimations];
    
    //[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];
    [tbl_view_country_list setHidden:TRUE];
    [sender resignFirstResponder];
    if(textField ==txt_fld_username)
    {
        if([self connected])
        {
            NSLog(@"Done editing----check user nae exist or not---");
            if(isUserNameDone)
            {
            [self callWebserviceForCheckUserName];
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }
    }
    if(textField == txt_fld_country)
    {
        [tbl_view_country_list setHidden:TRUE];
        [searchedArray removeAllObjects];
        searchedArray = [[NSMutableArray alloc] initWithArray:sortedCountryArray];
    }
    [tbl_view_country_list setHidden:TRUE];
    [textField resignFirstResponder];
}
#pragma mark - 

-(void)searchByInput :(NSString *)str_input
{

    [searchedArray removeAllObjects];
    for(int i=0;i<sortedCountryArray.count;i++)
    {
        NSString *str_country = [sortedCountryArray objectAtIndex:i];
        if([str_country.lowercaseString hasPrefix:str_input.lowercaseString])
        {
            [searchedArray addObject:str_country];
        }
    }
    if(searchedArray.count>0)
    {
        [tbl_view_country_list reloadData];
        [tbl_view_country_list setHidden:FALSE];
    }
}
-(void)showNextSuccessViewWtih_Delay
{
    self.navigationController.navigationBarHidden = TRUE;
    view_Having_registr_filds.hidden = TRUE;
    view_having_back_bttn.hidden  = FALSE;
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
-(IBAction)bttn_back_on_Login_Screen_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)bttn_create_account_pressed:(id)sender
{
    isUserNameDone = FALSE;
    
    BOOL isValid = TRUE;
    
    if(txt_fld_full_name.text.length == 0)
    {
        txt_fld_full_name.layer.borderColor = [UIColor redColor].CGColor;
        [parent_Scrollview scrollRectToVisible:[txt_fld_full_name bounds] animated:YES];
        isValid = FALSE;
    }
    if(txt_fld_country.text.length == 0)
    {
        txt_fld_country.layer.borderColor = [UIColor redColor].CGColor;
        [parent_Scrollview scrollRectToVisible:[txt_fld_country bounds] animated:YES];
        isValid = FALSE;
    }
    if(txt_fld_username.text.length == 0)
    {
        txt_fld_username.layer.borderColor = [UIColor redColor].CGColor;
        [parent_Scrollview scrollRectToVisible:[txt_fld_username bounds] animated:YES];
        isValid = FALSE;
    }
    if(txt_fld_password.text.length == 0)
    {
        txt_fld_password.layer.borderColor = [UIColor redColor].CGColor;
        [parent_Scrollview scrollRectToVisible:[txt_fld_password bounds] animated:YES];
        isValid = FALSE;
    }
    if(txt_fld_retype_password.text.length == 0)
    {
        txt_fld_retype_password.layer.borderColor = [UIColor redColor].CGColor;
        [parent_Scrollview scrollRectToVisible:[txt_fld_retype_password bounds] animated:YES];
        isValid = FALSE;
    }
    if(txt_fld_email.text.length == 0)
    {
        txt_fld_email.layer.borderColor = [UIColor redColor].CGColor;
        [parent_Scrollview scrollRectToVisible:[txt_fld_email bounds] animated:YES];
        isValid = FALSE;
    }
    if(txt_fld_password.text.length>1)
    {
        if(![txt_fld_password.text isEqualToString: txt_fld_retype_password.text])
        {
            txt_fld_retype_password.layer.borderColor = [UIColor redColor].CGColor;
            [parent_Scrollview scrollRectToVisible:[txt_fld_retype_password bounds] animated:YES];
            isValid = FALSE;
        }
    }
    if(isValid)
    {
        
        [txt_fld_full_name resignFirstResponder];
        [txt_fld_country resignFirstResponder];
        [txt_fld_username resignFirstResponder];
        [txt_fld_password resignFirstResponder];
        [txt_fld_retype_password resignFirstResponder];
        [txt_fld_email resignFirstResponder];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        bg_scrollView.frame=CGRectMake(0,0, bg_scrollView.frame.size.width, bg_scrollView.frame.size.height);
        [UIView commitAnimations];
        [tbl_view_country_list setHidden:TRUE];
        
        
        
        if([self connected])
        {
           
            [self callWebServiceForRegisterUser];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (tableView == tbl_view_country_list)
    {
        return searchedArray.count;
    }
    else
        return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[searchBar resignFirstResponder];
    NSString *cell_id = @"cell_country";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {  // Safety check for below iOS 7
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    

     if (tableView == tbl_view_country_list)
    {
       
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_id];
        }
        
        cell.textLabel.text = [searchedArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        return cell;
    }
    
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = false;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView ==tbl_view_country_list )
    {
        return 30;
    }
   
    else
        return 30;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selectedRow:%d",indexPath.row);
   
    txt_fld_country.text = [searchedArray objectAtIndex:indexPath.row];
    [txt_fld_country resignFirstResponder];
    [tbl_view_country_list setHidden:TRUE];
    
    
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willSelectRowAtIndexPath");
           return indexPath;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([scrollView isEqual:bg_scrollView]) {
        
        NSLog(@"[scrollView isEqual:bg_scrollView]---");
        CGPoint offset = parent_Scrollview.contentOffset;
        offset.y = bg_scrollView.contentOffset.y;
        [parent_Scrollview setContentOffset:offset];
    } else {
        NSLog(@"[scrollView parent_Scrollview]---");
       // CGPoint offset = bg_scrollView.contentOffset;
        ////offset.y = parent_Scrollview.contentOffset.y;
        //[bg_scrollView setContentOffset:offset];
    }
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove the row from data model
//    //[listArray removeObjectAtIndex:indexPath.row];
//}
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
