//
//  AddSketch.h
//  Sketcher
//
//  Created by Sanjay Shekhawat on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AddSketch : UIViewController<NSXMLParserDelegate,NSURLConnectionDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    NSURLConnection *_connection;
    NSXMLParser *xmlParser;
    NSMutableData *webData;
    BOOL success;
    UIActivityIndicatorView *activity;
    UIScrollView *scrollView;
    UIButton *btnDone;
}

//@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITextView *txtviewTitle;
@property (strong, nonatomic) IBOutlet UITextView *txtAreaIdea;
@property (strong, nonatomic) IBOutlet UIButton *btnsubmit;
@property (strong, nonatomic) NSString *owenerId;
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView *activity;
@property(strong,nonatomic)    UIBarButtonItem *barbuttonR;
@property(strong,nonatomic)    UIBarButtonItem *barbuttonL;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnSubmitClick:(id)sender;
-(void)callWebService;

-(void) parseJsonResult:(NSString *)_respponseString;

//- (IBAction)textFieldDoneEditing:(id)sender;
-(void)btnLogoutpressed;
@end
