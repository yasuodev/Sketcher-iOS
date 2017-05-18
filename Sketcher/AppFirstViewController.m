//
//  AppFirstViewController.m
//  Sketcher
//
//  Created by CS on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppFirstViewController.h"
#import "SketchDetail.h"
#import "JSON.h"
#import "Classes.h"
#import "AddSketch.h"
#import "AppAppDelegate.h"
#import "SketchListTableViewCell.h"

@interface AppFirstViewController ()
{
    BOOL isStarred;
    BOOL isSketchListing;
    BOOL isDeleteSketch;
    UILabel *lbl_title;
    UITableView *tbl_sort_sketch_list;
    NSArray *sort_option_array;
    
    UIView *middleView;
}
@end

@implementation AppFirstViewController

@synthesize listArray,tbleView,searchBar,userId,activity;


#pragma mark - View load
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Startup Sketcher";
      //  self.tabBarItem.image = [UIImage imageNamed:@"first1"];
       
    }
    return self;
}
							
- (void)viewDidLoad
{
    
    searchTextfield.frame = CGRectMake(searchTextfield.frame.origin.x, searchTextfield.frame.origin.y, searchTextfield.frame.size.width, 40);
    
    UIButton *bttn_Search =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [bttn_Search setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [bttn_Search addTarget:self action:@selector(searchBarSearchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    searchTextfield.layer.borderColor = [UIColor clearColor].CGColor;
    searchTextfield.leftViewMode = UITextFieldViewModeAlways;
    searchTextfield.leftView = bttn_Search;
    searchTextfield.placeholder = @"Search";
   // [searchTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    }
    
    [activity startAnimating];
    

    
    copyListOfItems = [[NSMutableArray alloc] init];
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:nil action:nil];
    
  // [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:230.0/255.0 green:229.0/255.0 blue:231.0/255.0 alpha:1.0]];
 //   self.navigationController.navigationBar.translucent = NO;
    
   // [searchBar setTintColor:[UIColor colorWithRed:0.58 green:0.72 blue:0.80 alpha:1.0]];

   // btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnClicked)];
    btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 38, 38)];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btnAdd]];

  // UIBarButtonItem *barbuttonL=[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(btnLogoutpressed)];
    //self.navigationItem.leftBarButtonItem=barbuttonL;
    
 
    UIButton *barbuttonL = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 22, 18)];
    [barbuttonL setBackgroundImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
    
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
   // [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    [barbuttonL addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
//    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon.png"]
//                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barbuttonL];
    
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    
    listArray=[[NSMutableArray alloc] init];
    
    
    //self.tbleView.tableHeaderView = searchBar;
//    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    
    searching = NO;
    letUserSelectRow = YES;
   // timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(refreshList) userInfo:nil repeats:YES ];

    if([self connected])
    {
        [self CallWebService : @""];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity stopAnimating];
        [activity setHidden:YES];
    }

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tbleView addSubview:refreshControl];
    
    [super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    if(IS_IPHONE_6 || IS_IPHONE_6P)
    {
        middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
        
        lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 145, 30)];
        lbl_title.textAlignment = NSTextAlignmentRight;
        
        tbl_sort_sketch_list = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x/1.8, self.navigationController.navigationBar.frame.size.height+20, 150, 120)];
    }
    else
    {
        middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
        
        lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
        lbl_title.textAlignment = NSTextAlignmentRight;
        
        tbl_sort_sketch_list = [[UITableView alloc] initWithFrame:CGRectMake(self.view.center.x/2, self.navigationController.navigationBar.frame.size.height+10, 150, 120)];
    }
    
    NSIndexPath*    selection = [tbleView indexPathForSelectedRow];
    if (selection) {
        [tbleView deselectRowAtIndexPath:selection animated:YES];
    }
 
    

  
    UIImageView *downarrow_img = [[UIImageView alloc] initWithFrame:CGRectMake(lbl_title.frame.origin.x+lbl_title.frame.size.width+10, 5, 20, 20)];
    downarrow_img.image = [UIImage imageNamed:@"icon_arrow_down.png"];
    
    
    UIButton *bttn_sort = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, downarrow_img.frame.origin.x+downarrow_img.frame.size.width, 30)];
    
    
    [bttn_sort addTarget:self action:@selector(bttn_show_sortView) forControlEvents:UIControlEventTouchUpInside];
    
    lbl_title.text = @"Most Recent" ;
    [middleView addSubview:lbl_title];
    [middleView addSubview:bttn_sort];
    [middleView addSubview:downarrow_img];
   

    [[[UIApplication sharedApplication] keyWindow] addSubview:tbl_sort_sketch_list];
    [tbl_sort_sketch_list setHidden:TRUE];
    
    
    
    tbl_sort_sketch_list.layer.cornerRadius = 0.5;
    tbl_sort_sketch_list.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tbl_sort_sketch_list.layer.borderWidth = 0.5;
    
    
    sort_option_array = [NSArray arrayWithObjects:@"Most Recent",@"A-Z",@"Z-A",@"Starred", nil];
    self.navigationItem.titleView = middleView;
    
    
    
    tbl_sort_sketch_list.delegate = self;
    tbl_sort_sketch_list.dataSource = self;
    [tbl_sort_sketch_list reloadData];
    
   
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [middleView removeFromSuperview];
    [tbl_sort_sketch_list removeFromSuperview];
    
    // Release any retained subviews of the main view.
}
#pragma mark - Custom Methods
- (void)refresh:(UIRefreshControl *)refreshControl {
    // Do your job, when done:
   NSString * sort_option = lbl_title.text ;
    if([self connected])
    {
        if([sort_option isEqualToString:@"Most Recent"])
        {
            [self CallWebService:@""];
        }
        else if ([sort_option isEqualToString:@"A-Z"])
        {
            [self CallWebService:@"DESC"];
        }
        else if ([sort_option isEqualToString:@"Z-A"])
        {
            [self CallWebService:@"ASC"];
        }
        else if ([sort_option isEqualToString:@"Starred"])
        {
            [self CallWebService:@"STARRED"];
            
        }
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity stopAnimating];
        [activity setHidden:YES];
    }
    [refreshControl endRefreshing];
}
-(void)bttn_show_sortView
{
    if(tbl_sort_sketch_list.hidden)
    {
        [self.view bringSubviewToFront:tbl_sort_sketch_list];
        [tbl_sort_sketch_list setHidden:FALSE];
    }
    else
    {
        [tbl_sort_sketch_list setHidden:TRUE];
    }
}
-(IBAction)bttnStarSketch_Pressed:(id)sender
{
    
    int tag =[sender tag]-1;
    
    NSLog(@"selectedRow--- star--tag:%d",tag);
    NSLog(@"searching----%d",searching);
    
    UIButton *bttn = (UIButton*)sender;
    UIImage *image = bttn.currentBackgroundImage;
   
    
    SketchItem *si;
    if(searching)
    {
        if(copyListOfItems.count>0)
        {
            si = [copyListOfItems objectAtIndex:tag];
            if([image isEqual:[UIImage imageNamed:@"selected_star.png"]])
            {
                si.is_starred = @"0";
            }
            else
            {
                si.is_starred = @"1";
            }
            NSLog(@"si.is_starred----%@",si.is_starred);
            [copyListOfItems replaceObjectAtIndex:tag withObject:si];

        }
    }
    else
    {
        if(listArray.count>0)
        {
            si=[listArray objectAtIndex:tag];
            if([image isEqual:[UIImage imageNamed:@"selected_star.png"]])
            {
                si.is_starred = @"0";
            }
            else
            {
                si.is_starred = @"1";
            }
            [listArray replaceObjectAtIndex:tag withObject:si];
            NSLog(@"si.is_starred----%@",si.is_starred);
        }
       
    }
    NSString *tmpStr = si.sketchId;
    NSLog(@"sketchId...%@",tmpStr);
    [tbleView reloadData];
    if([self connected])
    {
        [self Call_Starred_WebService:tmpStr];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity stopAnimating];
        [activity setHidden:YES];
    }

    
}
-(void)refreshList
{
    NSLog(@"refreshList");
    //[tbleView reloadData];
    
}


- (void) addBtnClicked
{
    AddSketch *as=[[AddSketch alloc]initWithNibName:@"AddSketch" bundle:nil ];    
    [self.navigationController pushViewController:as animated:YES];
    [tbl_sort_sketch_list removeFromSuperview];

}


#pragma mark -


 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tbleView)
    {
        if (searching)
            return [copyListOfItems count];
        else
            return [listArray count];

    }
    else if (tableView == tbl_sort_sketch_list)
    {
        return sort_option_array.count;
    }
    else
        return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[searchBar resignFirstResponder];
    static NSString *CellIdentifier = @"SketchCell";
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {  // Safety check for below iOS 7
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    SketchListTableViewCell *cell = (SketchListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tableView == tbleView)
    {
       
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SketchListTableViewCell" owner:self options:nil];
            cell = (SketchListTableViewCell *) [nib objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
        if(searching)
        {
            if(copyListOfItems.count>indexPath.row )
            {
                SketchItem *sTemp=[copyListOfItems objectAtIndex:indexPath.row];
                
                cell.lbl_sketch_idea.text = sTemp.sketchTitle;
                cell.lbl_date.text = sTemp.sketchDate;
                cell.lbl_sketch_desc.text = sTemp.sketchDescrition;
                [cell.lbl_sketch_desc sizeToFit];
                [cell.bttn_star setTag:indexPath.row+1];
                [cell.bttn_star addTarget:self action:@selector(bttnStarSketch_Pressed:) forControlEvents:UIControlEventTouchUpInside];
                if([sTemp.is_starred isEqualToString:@"1"])
                {
                    [cell.bttn_star setBackgroundImage:[UIImage imageNamed:@"selected_star.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [cell.bttn_star setBackgroundImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
                }
            }
           
            
        }
        
        else
        {
            
            if(listArray.count>indexPath.row)
            {
                SketchItem *si=[listArray objectAtIndex:indexPath.row];
                
                
                cell.lbl_sketch_idea.text = si.sketchTitle;
                cell.lbl_date.text = si.sketchDate;
                cell.lbl_sketch_desc.text = si.sketchDescrition;
                [cell.lbl_sketch_desc sizeToFit];
                [cell.bttn_star setTag:indexPath.row+1];
                [cell.bttn_star addTarget:self action:@selector(bttnStarSketch_Pressed:) forControlEvents:UIControlEventTouchUpInside];
                if([si.is_starred isEqualToString:@"1"])
                {
                    [cell.bttn_star setBackgroundImage:[UIImage imageNamed:@"selected_star.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [cell.bttn_star setBackgroundImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
                }
            }
           
            
            
        }
        return cell;
    }
    else if (tableView == tbl_sort_sketch_list)
    {
        NSString *cell_id = @"cell_sort";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_id];
        }
     
        cell.textLabel.text = [sort_option_array objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        return cell;
    }
   
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = false;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView ==tbl_sort_sketch_list )
    {
         return 30;
    }
    else if (tableView == tbleView)
    {
         return 90;
    }
    else
        return 30;
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSLog(@"selectedRow:%d",indexPath.row);
    if(tableView == tbleView)
    {
        SketchItem *si;
        if(searching)
        {
            if(copyListOfItems.count>0)
            {
                si = [copyListOfItems objectAtIndex:indexPath.row];
            }
            
        }
        else
        {
            if (listArray.count>0)
            {
                si=[listArray objectAtIndex:indexPath.row];
            }
            
        }
        NSString *tmpStr = si.sketchId;
        NSLog(@"sketchId...%@",tmpStr);
        
        SketchDetail *skD = [[SketchDetail alloc] initWithNibName:@"SketchDetail" bundle:nil withSketchId:tmpStr];
        skD.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:skD animated:YES];
        [tbl_sort_sketch_list removeFromSuperview];
    }
    else if (tableView == tbl_sort_sketch_list)
    {
        NSString *sort_option = [sort_option_array objectAtIndex:indexPath.row];
        lbl_title.text = sort_option;
        if([self connected])
        {
            if([sort_option isEqualToString:@"Most Recent"])
            {
                [self CallWebService:@""];
            }
            else if ([sort_option isEqualToString:@"A-Z"])
            {
                [self CallWebService:@"DESC"];
            }
            else if ([sort_option isEqualToString:@"Z-A"])
            {
                [self CallWebService:@"ASC"];
            }
            else if ([sort_option isEqualToString:@"Starred"])
            {
                [self CallWebService:@"STARRED"];
                
            }
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }

        
        //[NSArray arrayWithObjects:@"Most Recent",@"A-Z",@"Z-A",@"Starred", nil]
        [tbl_sort_sketch_list setHidden:TRUE];
    }
  
    
    
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSLog(@"willSelectRowAtIndexPath");
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    NSLog(@"Delte row from tblview list");
    if(searching)
    {
      
        if([self connected])
        {
           
            SketchItem *sketch_obj  =[copyListOfItems objectAtIndex:indexPath.row];
            NSLog(@"sketch_obj---sketch_obj.sketchId---searching-%@",sketch_obj.sketchId);
            [self callWebServiceForDeleteSketch:sketch_obj];
              [copyListOfItems removeObjectAtIndex:indexPath.row];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }
    }
    else
    {
       
        if([self connected])
        {
           
            SketchItem *sketch_obj  =[listArray objectAtIndex:indexPath.row];
            NSLog(@"sketch_obj---sketch_obj.sketchId---====-%@",sketch_obj.sketchId);
            [self callWebServiceForDeleteSketch:sketch_obj];
           [listArray removeObjectAtIndex:indexPath.row];
        
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity stopAnimating];
            [activity setHidden:YES];
        }

    }
    
    [tbleView reloadData];
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}




#pragma mark - WebService Methods


-(void)CallWebService:(NSString*)sort_option
{
    
    
    [activity startAnimating];
    [activity setHidden:NO];
    
    isStarred = FALSE;
    isSketchListing=TRUE;
    isDeleteSketch = FALSE;
    userId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];


 //   http://startupsketcher.org/sus_iphone/sketcherWS.php
 NSString *strurl=WEBSERVICEURL;


NSString *soapMessage=[NSString stringWithFormat:
                       @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                       "<soapenv:Header/>\n"
                       "<soapenv:Body>\n"
                       "<urn:SketchListing soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                       "<owner_id xsi:type=\"xsd:string\">%@</owner_id>\n"
                       "<sort_by xsi:type=\"xsd:string\">%@</sort_by>"
                       "</urn:SketchListing>\n"
                       "</soapenv:Body>\n"
                       "</soapenv:Envelope>",userId,sort_option
                       ];

NSLog(@"123%@",soapMessage);
NSURL *url=[NSURL URLWithString:strurl];
NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];

[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
[theRequest addValue: @"urn:quote5#SketchListing" forHTTPHeaderField:@"SOAPAction"];
[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
[theRequest setHTTPMethod:@"POST"];
[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];

_connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];


}
-(void)Call_Starred_WebService : (NSString *)sketch_id
{
    [activity startAnimating];
    [activity setHidden:NO];
    isStarred = TRUE;
    isSketchListing=FALSE;
    isDeleteSketch = FALSE;
    
    
    userId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    
    //   http://startupsketcher.org/sus_iphone/sketcherWS.php
    NSString *strurl=WEBSERVICEURL;
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">"
                           "<soapenv:Header/>"
                           "<soapenv:Body>"
                           "<urn:starSketch soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>"
                           "</urn:starSketch>"
                           "</soapenv:Body>"
                           "</soapenv:Envelope>",sketch_id
                           ];
    
    NSLog(@"Call_Starred_WebService -- 123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#starSketch" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
}
-(void)callWebServiceForDeleteSketch:(SketchItem*)sketch_obj
{
    
    [activity setHidden:NO];
    [activity startAnimating];
    
    
    isStarred = FALSE;
    isSketchListing=FALSE;
    isDeleteSketch = TRUE;
    
    
    
    
   // NSString *owenerId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    
    
   NSString * strurl= WEBSERVICEURL;
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">"
                           "<soapenv:Header/>"
                           "<soapenv:Body>"
                           "<urn:deleteSketch soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>"
                           "</urn:deleteSketch>"
                           "</soapenv:Body>"
                           "</soapenv:Envelope>",sketch_obj.sketchId
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#deleteSketch" forHTTPHeaderField:@"SOAPAction"];
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
    
    UIAlertView *alertFParser = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Internet Connection Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertFParser show];
   // [alertFParser release];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    [activity stopAnimating];
    [activity setHidden:YES];
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    NSLog(@"showing webservice data on console");
    NSLog(@"Response:%@",responseString);
     //[responseString release];
    
    if (xmlParser != nil) 
    {
           // [xmlParser release];
        xmlParser = nil;
    }
    
    xmlParser = [[NSXMLParser alloc] initWithData:webData];
	[xmlParser setDelegate:self];
	//[xmlParser parse];
    
 	
    //	[xmlParser release];
    xmlParser = nil;
     // [webData release];
    webData = nil;
    
    NSLog(@"result:");
    if(isSketchListing)
    {
    [self parseJsonResult:responseString];
    }
    if(isStarred)
    {
        
    }
    if(isDeleteSketch)
    {
        
    }
    
    //{"Status": true, "Message":"Sketch Starred."}
    
}
-(void)parseJsonStarredResult:(NSString *)responseString
{
    NSDictionary *maindict=[responseString JSONValue];
    
    NSString *Message = [NSString stringWithFormat:@"%@",[maindict valueForKey:@"Message"]];
    
    if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
        Message=@"";
    }
    
   
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
    NSLog(@"success : %d",success);
}
- (void) parseJsonResult:(NSString *) _respponseString
{
    [listArray removeAllObjects];
    /*
     {"Status":true,"Sketch":[{"sketchID":"1","sketchTitle":"My Sketch"}]}
     

     */
    
    NSDictionary *maindict=[_respponseString JSONValue];
    success=[[maindict valueForKey:@"Status"] boolValue];
    NSLog(@"success : %d",success);
    
    NSArray *itemArr=[(NSArray *) maindict valueForKey:@"Sketch"];
    NSLog(@"Array Count...%d",[itemArr count]);
    
    
    if(success)
    {
        
        if([itemArr count]!=0)
        {
            
          //  for(int i=0;i<[itemArr count];i++)
            /*{"Status":true,"Sketch":[{"sketchID":"50","sketchTitle":"Test","sketchDate":"1470481693","sketchIdea":"123","starred":"0"}*/
            for(int i=[itemArr count]-1;i>=0;i--)
            {
                
                SketchItem *SI=[[SketchItem alloc]init];
                
                NSDictionary *dict=[itemArr objectAtIndex:i];
                
                if((NSNull *)dict !=[NSNull null])
                {
                    NSString *sketchID=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sketchID"]];
                    NSString *sketchTitle=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sketchTitle"]];
                    
                    SI.sketchId=sketchID;
                   // SI.sketchTitle=[sketchTitle URLDecodedString];
                    SI.sketchDate = [dict valueForKey:@"sketchDate"];
                    NSString *sketch_idea= [dict valueForKey:@"sketchIdea"];
                   // SI.sketchDescrition = [ URLDecodedString];
                    SI.is_starred = [dict valueForKey:@"starred"];
                    if( sketch_idea == (id)[NSNull null] || sketch_idea.length == 0 || [sketch_idea isEqualToString:@"null"])
                    {
                        SI.sketchDescrition =@"";
                    }
                    else
                    {
                        sketch_idea =[sketch_idea URLDecodedString];
                        SI.sketchDescrition =sketch_idea ;
                    }
                    
                    if(sketchTitle == (id)[NSNull null] ||sketchTitle.length == 0 ||  [sketchTitle isEqualToString:@"null"])
                    {
                        SI.sketchTitle =@"";
                    }
                    else
                    {
                        sketchTitle =[sketchTitle URLDecodedString];
                        SI.sketchTitle=sketchTitle;
                    }
                    if((NSNull *) sketchID!=[NSNull null])
                    {
                        
                        
                        sketchID=@"";
                    }
                    if((NSNull *) sketchTitle!=[NSNull null])
                    {
                        
                        
                        sketchTitle=@"";
                    }
                   
                }
                [listArray addObject:SI];
                
            }
        }
    }
    else
    {
        
        NSString *Message = [NSString stringWithFormat:@"%@",[maindict valueForKey:@"Message"]];
        NSString *Error = [NSString stringWithFormat:@"%@",[maindict valueForKey:@"Error"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
            Error = @"";
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    if(listArray.count>0)
    {
        [tbleView reloadData];
    }
  
    

}

#pragma mark- UITextfield Method
//-(void)textFieldDidChange:(UITextField *)textfield
//{
//    NSLog(@"textDidChange");
//    //Remove all objects first.
//    [copyListOfItems removeAllObjects];
//    
//    if([textfield.text length] > 0)
//    {
//        
//        searching = YES;
//        letUserSelectRow = YES;
//        self.tbleView.scrollEnabled = YES;
//        [self searchTableView];
//    }
//    else {
//        
//        searching = NO;
//        letUserSelectRow = NO;
//        self.tbleView.scrollEnabled = NO;
//    }
//    
//    [self.tbleView reloadData];
//}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     NSString * newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"newString----%@",newString);
    [copyListOfItems removeAllObjects];
    
    if([newString length] > 0)
    {
        
        searching = YES;
        letUserSelectRow = YES;
        self.tbleView.scrollEnabled = YES;
        [self searchTableView];
    }
    else {
        
        searching = NO;
        letUserSelectRow = NO;
        self.tbleView.scrollEnabled = NO;
    }
    
    [self.tbleView reloadData];
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"searchBarTextDidBeginEditing");
    
    searching = YES;
    letUserSelectRow = NO;
    self.tbleView.scrollEnabled = NO;
    
    NSLog(@"searchBarTextDidBeginEditing");
    
    //Add the done button.
    if(searching)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(doneSearching_Clicked:)];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchTextfield resignFirstResponder];
    
    letUserSelectRow = YES;
    //searching = NO;a
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    self.tbleView.scrollEnabled = YES;
    
    return YES;
}
#pragma mark -Search bar methods
//- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
//    
//    NSLog(@"textDidChange");
//    //Remove all objects first.
//    [copyListOfItems removeAllObjects];
//    
//    if([searchText length] > 0)
//    {
//        
//        searching = YES;
//        letUserSelectRow = YES;
//        self.tbleView.scrollEnabled = YES;
//        [self searchTableView];
//    }
//    else {
//        
//        searching = NO;
//        letUserSelectRow = NO;
//        self.tbleView.scrollEnabled = NO;
//    }
//    
//    [self.tbleView reloadData];
//}
//
//- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar 
//{
//    NSLog(@"searchBarTextDidBeginEditing");
//    
//    searching = YES;
//    letUserSelectRow = NO;
//    self.tbleView.scrollEnabled = NO;
//    
//    NSLog(@"searchBarTextDidBeginEditing");
//    
//    //Add the done button.
//    if(searching)
//    {
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                               target:self action:@selector(doneSearching_Clicked:)];
//   }
//}
//
//
////- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar 
////{
////    
////    [self searchTableView];
////}
//- (void) searchBarSearchButtonClicked:(UIButton *)theSearchButton
//{
//    
//    [self searchTableView];
//}


- (void) searchTableView 
{
    
    NSString *searchText = searchTextfield.text;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    
       
    /*for (int i=[listArray count]-1;i>=0;i--)
    {
        SketchItem *soo= [listArray objectAtIndex:i];
        NSString *item=soo.sketchTitle;
        [searchArray addObject:item];
    }*/
    [searchArray addObjectsFromArray:listArray];
     
    [copyListOfItems removeAllObjects];
    for (SketchItem *sTemp in searchArray)
    {
       // NSLog(@"searchTableView....%d",[searchArray count]);
       //  NSLog(@"sTemp  : %@",sTemp);
        
       //  NSLog(@"searchText:  %@",searchText);
        
        
        NSRange titleResultsRange = [sTemp.sketchTitle rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        NSLog(@"sasa");
        
        
        if (titleResultsRange.length > 0)
            [copyListOfItems addObject:sTemp];
        
         else 
        {
            //[copyListOfItems removeAllObjects];
           // [copyListOfItems addObjectsFromArray:searchArray];
        }
    }
    
    
    searchArray = nil;
}

- (void) doneSearching_Clicked:(id)sender {
    
    //searchBar.text = @"";
//    [searchBar resignFirstResponder];
    [searchTextfield resignFirstResponder];
    
    letUserSelectRow = YES;
    //searching = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    self.tbleView.scrollEnabled = YES;
    //[self searchTableView];

    //[self.tbleView reloadData];
}


-(void)btnLogoutpressed
{
    NSLog(@"logout.....");
   // AppAppDelegate *appDelegate = (AppAppDelegate *)[[UIApplication sharedApplication] delegate];
    
   // [appDelegate removeTabBar];
}



@end
