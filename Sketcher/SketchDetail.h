//
//  SketchDetail.h
//  Sketcher
//
//  Created by Sanjay Shekhawat on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SketchDetail : UIViewController<NSXMLParserDelegate,NSURLConnectionDelegate,UITextViewDelegate,UIScrollViewDelegate>
{
    NSURLConnection *_connection;
    NSXMLParser *xmlParser;
    NSMutableData *webData;
    BOOL success;
    UIScrollView *scrollView;
    UIActivityIndicatorView *activity1,*activity2,*activity3,*activity4;
    NSString *target;
    NSString *benefit;
    NSString *pain;
    NSInteger *count;
    NSString *temp;
    UIButton *btnDone;
    
    
    
    IBOutlet UIScrollView *bgScrollView_Concept;
    IBOutlet UIScrollView *bg_scrollview_EditSketchIdea;
    IBOutlet UIScrollView *bg_scrollView_EDit3WH;
    IBOutlet UIScrollView *bg_scrollVIew_ScrapBook;
    
    IBOutlet UITextView *txtAreaIdea;
    IBOutlet UITextView *txtviewTitle;
    
    IBOutlet UIView *bgView_WHO;
    IBOutlet UIView *bgView_WHY;
    IBOutlet UIView *bgView_WHAT;
    IBOutlet UIButton *bttn_WHO;
    IBOutlet UIButton *bttn_WHY;
    IBOutlet UIButton *bttn_WHAT;
    
    
    IBOutlet UILabel *lbl_onEdit_WHO_WHY_WHAT;
    IBOutlet UITextView *txtView_edit_WHO_WHY_WHAT;
    IBOutlet UIView *view_having_edit_3WH;
    
    IBOutlet UILabel *lbl_line_separator_one;
    IBOutlet UILabel *lbl_line_seprator_two;
    IBOutlet UILabel *lbl_line_separator_three;
 
    IBOutlet UILabel *lbl_essence_sketch_idea;
    
    IBOutlet UIButton *bttn_arrow;
}

@property (strong, nonatomic) IBOutlet UILabel *lblScrap;

@property (strong, nonatomic) IBOutlet UILabel *lblWho;
@property (strong, nonatomic) IBOutlet UILabel *lblWhy;
@property (strong, nonatomic) IBOutlet UILabel *lblWhat;
@property (strong, nonatomic) IBOutlet UILabel *lblmainWhy;

@property (strong, nonatomic) IBOutlet UILabel *lblmainwho;


@property (strong, nonatomic) IBOutlet UILabel *lblWhyMain;

@property (strong, nonatomic) IBOutlet UILabel *lblwhatMain;
@property (strong, nonatomic) IBOutlet UILabel *lblWhoMain;


//@property (strong, nonatomic) IBOutlet UITextView *txtwho;
//@property (strong, nonatomic) IBOutlet UITextView *txtAreaWhy;
//@property (strong, nonatomic) IBOutlet UITextView *txtAreaWhat;
@property (strong, nonatomic) IBOutlet UITextView *txtAreaScrapbook;

@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UILabel *lbloriginalIdea;


//@property (strong, nonatomic) IBOutlet UITextView *scrapbookTxtView;
//@property (strong, nonatomic) IBOutlet UITextView *whoTxtView;
//@property (strong, nonatomic) IBOutlet UITextView *whyTxtView;
//@property (strong, nonatomic) IBOutlet UITextView *whatTxtView;
@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *activity1,*activity2,*activity3,*activity4;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSString *sketchId;

//@property(nonatomic) BOOL isSketch;
//@property(nonatomic) BOOL isConcept;
//@property(nonatomic) BOOL isScrapbook;
//@property(nonatomic) BOOL isEditing;
//@property(nonatomic) BOOL isConceptEditing;
//@property(nonatomic) BOOL isScrapbookEditing;



@property (strong, nonatomic) IBOutlet UILabel *lblSketch;
@property (strong, nonatomic) UIBarButtonItem *btnEdit;


@property(strong,nonatomic) UIBarButtonItem *barbuttonL;

@property(strong,nonatomic)    UIBarButtonItem *barbuttonR;
//@property (strong, nonatomic) IBOutlet UIButton *btnSketch;
//@property (strong, nonatomic) IBOutlet UIButton *btnConcept;
@property (strong, nonatomic) IBOutlet UIButton *btnScrapbook;

@property (strong, nonatomic) IBOutlet UIView *viewSketch;
@property (strong, nonatomic) IBOutlet UIView *viewConcept;
@property (strong, nonatomic) IBOutlet UIView *viewScrapbook;


@property (strong, nonatomic) UIBarButtonItem *btnHome;
@property (strong, nonatomic) UIBarButtonItem *btnConceptEdit;
@property (strong, nonatomic) UIBarButtonItem *btnCancelEditIdea;
@property (strong, nonatomic) UIBarButtonItem *btnSaveEditIdea;
//@property (strong, nonatomic) UIBarButtonItem *btnEdit;


//- (IBAction)btnSketchPressed:(id)sender;
//- (IBAction)btnConceptPressed:(id)sender;
- (IBAction)btnScrapbookPressed:(id)sender;
//-(void)CallWebService;
- (void) parseJsonResult:(NSString *) _respponseString;



-(void)CallWebServiceForSketchConcept;
-(void) parseJsonResultForSketchConcept:(NSString *)_respponseString;

-(void)CallWebServiceForSketchScrapbook;
-(void) parseJsonResultForSketchScrapbook:(NSString *)_respponseString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSketchId:(NSString *) _sketchID ;
//- (void) editBtnClicked;

-(void) CallWebServiceForForEditConcept;
-(void) parseJsonResultForConceptEditing:(NSString *)_respponseString;


-(void)CallWebServiceForForEditScrapbook;
-(void) parseJsonResultForScrapbookEditing:(NSString *)_respponseString;
//-(void) btncancelPress;

@end
