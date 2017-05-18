//
//  AppFirstViewController.h
//  Sketcher
//
//  Created by CS on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//http://www.iphonesdkarticles.com/2009/01/uitableview-searching-table-view.html

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
#import "Reachability.h"
@interface AppFirstViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,NSURLConnectionDelegate,UITextFieldDelegate>
{
    NSMutableArray *listArray;
    IBOutlet UITableView *tbleView;
    
    NSURLConnection *_connection;
    NSXMLParser *xmlParser;
    NSMutableData *webData;
    NSString *userId;
    BOOL success;
    UIActivityIndicatorView *activity;
    UISearchBar *searchBar;
    BOOL searching;
    BOOL letUserSelectRow;
    NSMutableArray *copyListOfItems;
    //UIBarButtonItem *btnAdd;
    
    UIButton *btnAdd;
    NSTimer *timer;
    IBOutlet UIView *sideMenuView;
    
    IBOutlet UITextField *searchTextfield;
}

@property(strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong, nonatomic) NSMutableArray *listArray;
@property(strong, nonatomic) IBOutlet UITableView *tbleView;
@property(strong,nonatomic)NSString *userId;
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView *activity;

- (void) addBtnClicked;
//-(void)CallWebService;

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
-(void)btnLogoutpressed;
-(void)refreshList;

@end
