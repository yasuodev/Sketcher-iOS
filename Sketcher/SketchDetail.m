//
//  SketchDetail.m
//  Sketcher
//
//  Created by Sanjay Shekhawat on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SketchDetail.h"
#import "JSON.h"

#define TitleMaxLength 30
#define IdeaMaxLength  140


@interface SketchDetail ()
{
    //NSString *sketchIdeaTitle;
   // UIView *viewKeyButton;
    NSString * str_edit_WHO;
    NSString *str_edit_WHY;
    NSString *str_edit_WHAT;
    
    BOOL isWHO_Edit;
    BOOL isWHY_Edit;
    BOOL isWHAT_Edit;
    BOOL isScrapBook_Edit;
    BOOL isSketchIdeaConceptEdit;
    BOOL isSketchDetail;
    BOOL isScrapBookDetail;
    BOOL isConcept3WhDetail;
    BOOL isSketchDetailOnEdit;
}
@end

@implementation SketchDetail
@synthesize lblScrap;
@synthesize lblWho;
@synthesize lblWhy;
@synthesize lblWhat;
@synthesize lblWhyMain;
@synthesize lblwhatMain;
//@synthesize txtwho;
//@synthesize txtAreaWhy;
//@synthesize txtAreaWhat;
@synthesize txtAreaScrapbook;
@synthesize lbltitle;
@synthesize lbloriginalIdea;
@synthesize lblmainwho,lblmainWhy;
@synthesize btnScrapbook;//btnSketch,btnConcept,
@synthesize viewSketch,viewConcept,viewScrapbook,scrollView;
//@synthesize isSketch,isConcept,isScrapbook,btnEdit,isEditing,,isConceptEditing,isScrapbookEditing;
@synthesize sketchId,lblSketch;//,scrapbookTxtView;
//@synthesize whoTxtView,whyTxtView,whatTxtView,
@synthesize activity1,activity2,activity3,lblWhoMain,barbuttonR,activity4;
@synthesize barbuttonL;
@synthesize btnHome,btnConceptEdit,btnCancelEditIdea,btnSaveEditIdea;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTite:(NSString *) _titleS
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSketchId:(NSString *) _sketchID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
      
        self.sketchId = _sketchID;
        
    }
    return self;
}


-(void)viewDidLoad
{
  //  R: 3 G: 101 B: 192
   
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    }
    
    btnHome  =  [[UIBarButtonItem alloc] initWithTitle:@"< Home" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonHomePressed)];//65,105,225
    btnHome.tintColor = [UIColor colorWithRed:3.0/255.0 green:101.0/255.0 blue:192.0/255.0 alpha:1.0];
    
    btnConceptEdit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(bttnEditConceptPressed)];
    btnConceptEdit.tintColor = [UIColor colorWithRed:3.0/255.0 green:101.0/255.0 blue:192.0/255.0 alpha:1.0];
    
    btnCancelEditIdea = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(bttn_CancelEditIdeaPressed)];
    btnCancelEditIdea.tintColor = [UIColor colorWithRed:3.0/255.0 green:101.0/255.0 blue:192.0/255.0 alpha:1.0];
    btnSaveEditIdea = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(bttn_SaveEditIDeaPressd)];
    btnSaveEditIdea.tintColor = [UIColor colorWithRed:3.0/255.0 green:101.0/255.0 blue:192.0/255.0 alpha:1.0];
    
    str_edit_WHO=[NSString stringWithFormat:@"Edit your WHO target: Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B..."];
    
    str_edit_WHY=[NSString stringWithFormat:@"Edit your WHY target: Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?"];
    
    str_edit_WHAT=[NSString stringWithFormat:@"Edit your WHAT target: What is the SOLUTION or BENEFIT you will be offering with your product/service?"];
    
    
    
    
    self.navigationItem.leftBarButtonItem = btnHome;
    self.navigationItem.rightBarButtonItem = btnConceptEdit;
    
  /*  viewKeyButton = [[UIView alloc] initWithFrame:CGRectMake(261, 170, 58, 30)];
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 58, 30)];
    //[btnBack setImage:[UIImage imageNamed:@"arrow_up.gif"] forState:UIControlStateNormal];
    btnDone.layer.cornerRadius=5.00;
    [btnDone setTitle:@"Hide" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(HideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setBackgroundColor:[UIColor grayColor]];
   
    [viewKeyButton addSubview:btnDone];
    
    [self.view addSubview:viewKeyButton];
    [viewKeyButton setHidden:YES];*/
    
    [viewSketch setHidden:YES];
    [viewConcept setHidden:NO];
    [viewScrapbook setHidden:YES];
    [view_having_edit_3WH setHidden:YES];
    
    
    //isSketch = YES;
    //isConcept = NO;
   // isScrapbook = NO;
   // isConceptEditing=NO;
   // isScrapbookEditing=NO;
    
    [bgScrollView_Concept setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, btnScrapbook.frame.origin.y+btnScrapbook.frame.size.height+30)];
    
    [bg_scrollView_EDit3WH setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, txtView_edit_WHO_WHY_WHAT.frame.origin.y+txtView_edit_WHO_WHY_WHAT.frame.size.height+30)];
    
    [bg_scrollVIew_ScrapBook setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, txtAreaScrapbook.frame.origin.y+txtAreaScrapbook.frame.size.height+30)];
    
    [bg_scrollview_EditSketchIdea setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, self.view.frame.size.height+30)];
    
    //  [self CallWebService];
   //    [self performSelector:@selector(setSketchIDEa_N_Title) withObject:nil afterDelay:2.5];
    [self setSketchIDEa_N_Title];
    [super viewDidLoad];
}

/*- (void)viewDidLoad
{
    isEditing = NO;
 
 
 
    //[scrapbookTxtView setEditable:FALSE];
 
   // [lblSketch setText:self.sketchTitle];
//self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
   // self.scrollView = [[UIScrollView alloc]   init];
 //   self.scrollView.contentSize = self.scrollView.frame.size;
        
   // [whatTxtView setHidden:YES];
  //  [whoTxtView setHidden:YES];
  //  [whyTxtView setHidden:YES];
  //  [txtAreaScrapbook setHidden:YES];
    
    
    
  //  [self.scrollView setContentSize:CGSizeMake(320.00,480.00)];
   // [self.view addSubview:scrollView];
    
   // [activity1 startAnimating];
   // [activity2 setHidden:YES];
   // [activity3 setHidden:YES];
    
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.58 green:0.72 blue:0.80 alpha:1.0]];
    
   // self.title = @"Startup Sketcher";
    
  //  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismissView)];
    
  //  self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];                                           
 
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
 
    
    
    
    UIBarButtonItem *barbuttonL=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemDone target:self action:nil];
    self.navigationItem.leftBarButtonItem=barbuttonL; 

    
    
   // barbuttonR=[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(btnLogoutpressed)];
    //self.navigationItem.rightBarButtonItem=barbuttonR; 
    
    
    //btnEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editBtnClicked)];

     
//    btnEdit = [[UIBarButtonItem alloc] init];
//    [btnEdit setStyle:UIBarButtonItemStyleDone];
//    [btnEdit setTarget:self];
//    [btnEdit setAction:@selector(editBtnClicked)];
//    [btnEdit setTitle:@"Edit"];
    
    
    //[btnEdit setStyle:UIBarButtonSystemItemEdit]
    
    
   // [btnEdit setTintColor:[UIColor colorWithRed:0.58 green:0.72 blue:0.80 alpha:1.0]];
      
    
    
    //Set Sketch Selected by default
    
    
    viewKeyButton = [[UIView alloc] initWithFrame:CGRectMake(261, 170, 58, 30)];
    btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 58, 30)];
    //[btnBack setImage:[UIImage imageNamed:@"arrow_up.gif"] forState:UIControlStateNormal];
    btnDone.layer.cornerRadius=5.00;
    [btnDone setTitle:@"Hide" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(HideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setBackgroundColor:[UIColor grayColor]];
   [btnDone setBackgroundColor:[[UIColor alloc] initWithRed:1.14
                                                        green:1.52
                                                         blue:1.63
                                                        alpha:0.0]];
   [viewKeyButton addSubview:btnDone];
    
    [self.view addSubview:viewKeyButton];
    [viewKeyButton setHidden:YES];
    
    
   // [btnSketch setBackgroundColor:[UIColor darkGrayColor]];
    //[btnConcept setBackgroundColor:[UIColor clearColor]];
    [btnScrapbook setBackgroundColor:[UIColor clearColor]];
    
    [viewSketch setHidden:YES];
    [viewConcept setHidden:NO];
    [viewScrapbook setHidden:YES];
    [view_having_edit_3WH setHidden:YES];
    
    
    isSketch = YES;
    isConcept = NO;
    isScrapbook = NO;
    isConceptEditing=NO;
    isScrapbookEditing=NO;
    
    [bgScrollView_Concept setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, btnScrapbook.frame.origin.y+btnScrapbook.frame.size.height+30)];
    
  //  [self CallWebService];
      [self CallWebServiceForSketchConcept];
    [super viewDidLoad];
    
}*/
#pragma mark - Added
-(void)perform_WHO_Method
{
    isScrapBook_Edit = FALSE;
    isSketchIdeaConceptEdit =FALSE;
    isWHO_Edit = TRUE;
    isWHAT_Edit = FALSE;
    isWHY_Edit = FALSE;
    
//    [UIView animateWithDuration:1.0
//                          delay: 0.5
//                        options: UIViewAnimationOptionCurveEaseIn
    //                     animations:^{UIFont *VerdanaFont = [UIFont fontWithName:@"verdana" size:12.0];
  //  NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:N
    
    UIFont *VerdanaFont = [UIFont boldSystemFontOfSize:14.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
    
                         lbl_onEdit_WHO_WHY_WHAT.text = str_edit_WHO;
                         
//                         NSMutableAttributedString *text_WHO =[[NSMutableAttributedString alloc]initWithAttributedString: lbl_onEdit_WHO_WHY_WHAT.attributedText];
    NSMutableAttributedString *text_WHO =[[NSMutableAttributedString alloc]initWithString:lbl_onEdit_WHO_WHY_WHAT.text attributes:verdanaDict];
                         
                         [text_WHO addAttribute:NSForegroundColorAttributeName
                                          value:[UIColor colorWithRed:0.0/255.0 green:136.0/255.0 blue:43.0/255.0 alpha:1.0]
                                          range:NSMakeRange(10, 3)];
                         [lbl_onEdit_WHO_WHY_WHAT setAttributedText: text_WHO];
                         
                         
                        // NSLog(@"lblWho--txtView_edit_WHO_WHY_WHAT--textR: 0 G: 136 B: 43---%@",lblWho.text);
                         
    if([lblWho.text isEqualToString:@"Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B..."])
                         {
                             txtView_edit_WHO_WHY_WHAT.text = @"Write down here...";
                             txtView_edit_WHO_WHY_WHAT.textColor = [UIColor lightGrayColor];
                         }
                         else
                         {
                             txtView_edit_WHO_WHY_WHAT.text = lblWho.text;
                             txtView_edit_WHO_WHY_WHAT.textColor = [UIColor blackColor];
                         }
                         
                         [activity1 setHidden:TRUE];
                         [activity2 setHidden:TRUE];
                         [activity3 setHidden:TRUE];
                         [activity4 setHidden:TRUE];
                         [activity1 stopAnimating];
                         [activity2 stopAnimating];
                         [activity3 stopAnimating];
                         [activity4 stopAnimating];
                         // move
                   //  }
                   //  completion:^(BOOL finished){
                         
                         [viewSketch setHidden:TRUE];
                         [viewConcept setHidden:TRUE];
                         [viewScrapbook setHidden:TRUE];
                         [view_having_edit_3WH setHidden:FALSE];
                         
                        // NSLog(@"lblWho--txtView_edit_WHO_WHY_WHAT--text---%@",txtView_edit_WHO_WHY_WHAT.text);
                         self.navigationItem.leftBarButtonItem =nil;
                         self.navigationItem.rightBarButtonItem = nil;
                         self.navigationItem.leftBarButtonItem = btnCancelEditIdea;
                         self.navigationItem.rightBarButtonItem = btnSaveEditIdea;
                         
                         
                     //}];
    

}
-(void)perForm_WHY_Method
{
    isWHO_Edit = FALSE;
    isWHAT_Edit = FALSE;
    isWHY_Edit = TRUE;
    
    
//    [UIView animateWithDuration:1.0
//                          delay: 0.5
//                        options: UIViewAnimationOptionCurveEaseIn
//                     animations:^{
    
                         
                         lbl_onEdit_WHO_WHY_WHAT.text = str_edit_WHY;
                         
                        // NSMutableAttributedString *text_WHY =[[NSMutableAttributedString alloc]initWithAttributedString: lbl_onEdit_WHO_WHY_WHAT.attributedText];
    UIFont *VerdanaFont = [UIFont boldSystemFontOfSize:14.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
    
  
    
       NSMutableAttributedString *text_WHY =[[NSMutableAttributedString alloc]initWithString:lbl_onEdit_WHO_WHY_WHAT.text attributes:verdanaDict];

    
                         [text_WHY addAttribute:NSForegroundColorAttributeName
                                          value:[UIColor colorWithRed:0.0/255.0 green:136.0/255.0 blue:43.0/255.0 alpha:1.0]
                                          range:NSMakeRange(10, 3)];
                         [lbl_onEdit_WHO_WHY_WHAT setAttributedText: text_WHY];
                         
                         
                        // NSLog(@"lblWhy----text---%@",lblWhy.text);
                         
                         
    if([lblWhy.text isEqualToString:@"Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?"])
                         {
                             txtView_edit_WHO_WHY_WHAT.text = @"Write down here...";
                              txtView_edit_WHO_WHY_WHAT.textColor = [UIColor lightGrayColor];
                         }
                         else
                         {
                             txtView_edit_WHO_WHY_WHAT.text = lblWhy.text;
                             txtView_edit_WHO_WHY_WHAT.textColor = [UIColor blackColor];
                         }
                         [activity1 stopAnimating];
                         [activity2 stopAnimating];
                         [activity3 stopAnimating];
                         [activity4 stopAnimating];
                         [activity1 setHidden:TRUE];
                         [activity2 setHidden:TRUE];
                         [activity3 setHidden:TRUE];
                         [activity4 setHidden:TRUE];
                         // move
                    // }
                     //completion:^(BOOL finished){
                         [viewSketch setHidden:TRUE];
                         [viewConcept setHidden:TRUE];
                         [viewScrapbook setHidden:TRUE];
                         [view_having_edit_3WH setHidden:FALSE];
                         
                         
                        // NSLog(@"lblWhy--txtView_edit_WHO_WHY_WHAT--text---%@",txtView_edit_WHO_WHY_WHAT.text);
                         
                         self.navigationItem.leftBarButtonItem =nil;
                         self.navigationItem.rightBarButtonItem = nil;
                         self.navigationItem.leftBarButtonItem = btnCancelEditIdea;
                         self.navigationItem.rightBarButtonItem = btnSaveEditIdea;
                         
                         
                         
                    // }];

}
-(void)perform_WHAT_Method
{
    isWHO_Edit = FALSE;
    isWHAT_Edit = TRUE;
    isWHY_Edit = FALSE;
    
//    [UIView animateWithDuration:1.0
//                          delay: 0.5
//                        options: UIViewAnimationOptionCurveEaseIn
//                     animations:^{
    
                         
                         lbl_onEdit_WHO_WHY_WHAT.text = str_edit_WHAT;
                         
                       //  NSMutableAttributedString *text_WHAT =[[NSMutableAttributedString alloc]initWithAttributedString: lbl_onEdit_WHO_WHY_WHAT.attributedText];
    
    UIFont *VerdanaFont = [UIFont boldSystemFontOfSize:14.0];
    NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
    
   
    
    NSMutableAttributedString *text_WHAT =[[NSMutableAttributedString alloc]initWithString:lbl_onEdit_WHO_WHY_WHAT.text attributes:verdanaDict];
    
                         [text_WHAT addAttribute:NSForegroundColorAttributeName
                                           value:[UIColor colorWithRed:0.0/255.0 green:136.0/255.0 blue:43.0/255.0 alpha:1.0]
                                           range:NSMakeRange(10, 4)];
                         
                         [lbl_onEdit_WHO_WHY_WHAT setAttributedText: text_WHAT];
                         
                         
                         
                       //  NSLog(@"lblWhat----text---%@",lblWhat.text);
                         
    if([lblWhat.text isEqualToString:@"What is the SOLUTION or BENEFIT you will be offering with your product/service?"])
                         {
                             txtView_edit_WHO_WHY_WHAT.text =@"Write down here..." ;
                              txtView_edit_WHO_WHY_WHAT.textColor = [UIColor lightGrayColor];
                         }
                         else
                         {
                             txtView_edit_WHO_WHY_WHAT.text = lblWhat.text;
                             txtView_edit_WHO_WHY_WHAT.textColor = [UIColor blackColor];
                         }
                         
                         [activity1 stopAnimating];
                         [activity2 stopAnimating];
                         [activity3 stopAnimating];
                         [activity4 stopAnimating];
                         
                         [activity1 setHidden:TRUE];
                         [activity2 setHidden:TRUE];
                         [activity3 setHidden:TRUE];
                         [activity4 setHidden:TRUE];
                         
                         // move
                    // }
                    // completion:^(BOOL finished){
                         
                         
                         [viewSketch setHidden:TRUE];
                         [viewConcept setHidden:TRUE];
                         [viewScrapbook setHidden:TRUE];
                         [view_having_edit_3WH setHidden:FALSE];
                         
                        // NSLog(@"txtView_edit_WHO_WHY_WHAT---%@",txtView_edit_WHO_WHY_WHAT.text);
                         
                         self.navigationItem.leftBarButtonItem =nil;
                         self.navigationItem.rightBarButtonItem = nil;
                         self.navigationItem.leftBarButtonItem = btnCancelEditIdea;
                         self.navigationItem.rightBarButtonItem = btnSaveEditIdea;
                         
                         
                     //}];
}
-(IBAction)bttn_WHO_Pressed:(id)sender
{
    

   
    
    
    bgView_WHO.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    bgView_WHY.backgroundColor = [UIColor whiteColor];
    bgView_WHAT.backgroundColor = [UIColor whiteColor];
    
    [self performSelector:@selector(perform_WHO_Method) withObject:nil afterDelay:0.5];
    
    
   
    
}
-(IBAction)bttn_WHY_Pressed:(id)sender
{
    
    
    bgView_WHO.backgroundColor = [UIColor whiteColor];
    bgView_WHY.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    bgView_WHAT.backgroundColor = [UIColor whiteColor];
    
    [self performSelector:@selector(perForm_WHY_Method) withObject:nil afterDelay:0.5];
    
}
-(IBAction)bttn_WHAT_Pressed:(id)sender
{
    
    
    
    
    
    bgView_WHO.backgroundColor = [UIColor whiteColor];
    bgView_WHY.backgroundColor = [UIColor whiteColor];
    bgView_WHAT.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    
    
     [self performSelector:@selector(perform_WHAT_Method) withObject:nil afterDelay:0.5];
    
      // no completion handler

    

//    
//
}
-(void)barButtonHomePressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setSketchIDEa_N_Title
{
    
    
    if([self connected])
    {
        isSketchDetailOnEdit = TRUE;
        [self CallWebServiceForSketchDetail];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity1 setHidden:YES];
        [activity2 setHidden:YES];
        [activity3 setHidden:YES];
        [activity4 setHidden:YES];
        
        [activity1 stopAnimating];
        [activity2 stopAnimating];
        [activity3 stopAnimating];
        [activity4 stopAnimating];
    }
    
}
-(void)bttnEditConceptPressed
{
    [activity1 setHidden:NO];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    [activity1 startAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    
    if([self connected])
    {
        isSketchDetailOnEdit = FALSE;
        [self CallWebServiceForSketchDetail];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity1 setHidden:YES];
        [activity2 setHidden:YES];
        [activity3 setHidden:YES];
        [activity4 setHidden:YES];
        
        [activity1 stopAnimating];
        [activity2 stopAnimating];
        [activity3 stopAnimating];
        [activity4 stopAnimating];
    }
    
    
    
    [viewConcept setHidden:YES];
    [viewSketch setHidden:NO];
    [view_having_edit_3WH setHidden:YES];
    [viewScrapbook setHidden:YES];
    
    self.navigationItem.leftBarButtonItem = btnCancelEditIdea;
    self.navigationItem.rightBarButtonItem = btnSaveEditIdea;
    
}
-(void)bttn_CancelEditIdeaPressed
{
    
    bgView_WHO.backgroundColor = [UIColor whiteColor];
    bgView_WHY.backgroundColor = [UIColor whiteColor];
    bgView_WHAT.backgroundColor = [UIColor whiteColor];
    
    [txtAreaScrapbook resignFirstResponder];
    [txtAreaIdea resignFirstResponder];
    [txtviewTitle resignFirstResponder];
    [txtView_edit_WHO_WHY_WHAT resignFirstResponder];
    
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    [activity1 stopAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    
   // [viewKeyButton setHidden:TRUE];
    [viewScrapbook setHidden:YES];
    [viewConcept setHidden:NO];
    [viewSketch setHidden:YES];
    [view_having_edit_3WH setHidden:YES];
    
    self.navigationItem.leftBarButtonItem = btnHome;
    self.navigationItem.rightBarButtonItem = btnConceptEdit;
}
-(void)bttn_SaveEditIDeaPressd
{
    bgView_WHO.backgroundColor = [UIColor whiteColor];
    bgView_WHY.backgroundColor = [UIColor whiteColor];
    bgView_WHAT.backgroundColor = [UIColor whiteColor];
  //  [viewKeyButton setHidden:TRUE];
    
    
    [txtAreaScrapbook resignFirstResponder];
    [txtAreaIdea resignFirstResponder];
    [txtviewTitle resignFirstResponder];
    [txtView_edit_WHO_WHY_WHAT resignFirstResponder];
    
//    NSLog(@"isScrapBook_Edit----%d",isScrapBook_Edit);
//    NSLog(@"isWHO_Edit----%d",isWHO_Edit);
//    NSLog(@"isWHY_Edit----%d",isWHY_Edit);
//    NSLog(@"isWHAT_Edit----%d",isWHAT_Edit);
//    NSLog(@"isSketchIdeaConceptEdit----%d",isSketchIdeaConceptEdit);
    

    if(isScrapBook_Edit || viewScrapbook.hidden == FALSE)
    {
        if(txtAreaScrapbook.text.length == 0 || [txtAreaScrapbook.text isEqualToString:@"Write down here..."])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please write something to save!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            if([self connected])
            {
                [self CallWebServiceForForEditScrapbook];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [activity1 setHidden:YES];
                [activity2 setHidden:YES];
                [activity3 setHidden:YES];
                [activity4 setHidden:YES];
                
                [activity1 stopAnimating];
                [activity2 stopAnimating];
                [activity3 stopAnimating];
                [activity4 stopAnimating];
            }

            
        }
        
        
    }
    else if (isWHO_Edit )
    {
        if(txtView_edit_WHO_WHY_WHAT.text.length == 0 || [txtView_edit_WHO_WHY_WHAT.text isEqualToString:@"Write down here..."])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please write something to save!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            target = txtView_edit_WHO_WHY_WHAT.text;
            benefit = lblWhat.text;
            pain = lblWhy.text;
            if([self connected])
            {
                [self CallWebServiceForForEditConcept];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [activity1 setHidden:YES];
                [activity2 setHidden:YES];
                [activity3 setHidden:YES];
                [activity4 setHidden:YES];
                
                [activity1 stopAnimating];
                [activity2 stopAnimating];
                [activity3 stopAnimating];
                [activity4 stopAnimating];
            }

            
            
        }
    }
    else if (isWHY_Edit)
    {
        if(txtView_edit_WHO_WHY_WHAT.text.length == 0 || [txtView_edit_WHO_WHY_WHAT.text isEqualToString:@"Write down here..."])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please write something to save!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            pain = txtView_edit_WHO_WHY_WHAT.text;
            target = lblWho.text;
            benefit = lblWhat.text;
           
            if([self connected])
            {
                 [self CallWebServiceForForEditConcept];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [activity1 setHidden:YES];
                [activity2 setHidden:YES];
                [activity3 setHidden:YES];
                [activity4 setHidden:YES];
                
                [activity1 stopAnimating];
                [activity2 stopAnimating];
                [activity3 stopAnimating];
                [activity4 stopAnimating];
            }

           
        }
    }
    else if (isWHAT_Edit)
    {
        if(txtView_edit_WHO_WHY_WHAT.text.length == 0 || [txtView_edit_WHO_WHY_WHAT.text isEqualToString:@"Write down here..."])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please write something to save!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            benefit = txtView_edit_WHO_WHY_WHAT.text;
            target = lblWho.text;
            pain = lblWhy.text;
            if([self connected])
            {
                 [self CallWebServiceForForEditConcept];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [activity1 setHidden:YES];
                [activity2 setHidden:YES];
                [activity3 setHidden:YES];
                [activity4 setHidden:YES];
                
                [activity1 stopAnimating];
                [activity2 stopAnimating];
                [activity3 stopAnimating];
                [activity4 stopAnimating];
            }

           
        }
        
    }
    else if (isSketchIdeaConceptEdit || viewSketch.hidden == FALSE)
    {
        NSString *message;
        int i=1;
        if([txtviewTitle.text length]<=0 || [txtviewTitle.text isEqualToString:@"Write down a working title for your idea in maximum 30 characters"])
        {
            message=@"Title Can't Empty";
            UIAlertView *ai=[[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [ai show];
            i=0;
        }
        else if([txtAreaIdea.text length]<=0 || [txtviewTitle.text isEqualToString:@"Write down a essence of the idea in maximum 140 characters"])
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
                 [self CallWebServiceForEditSketchIdea];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [activity1 setHidden:YES];
                [activity2 setHidden:YES];
                [activity3 setHidden:YES];
                [activity4 setHidden:YES];
                
                [activity1 stopAnimating];
                [activity2 stopAnimating];
                [activity3 stopAnimating];
                [activity4 stopAnimating];
            }

        }
        


    }

    // [self CallWebServiceForForEditConcept];
}
- (IBAction)btnScrapbookPressed:(id)sender
{
    
     
    
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:NO];
    [activity4 setHidden:YES];
    [activity3 startAnimating];
    
        
        
    
    
        
        [viewSketch setHidden:YES];
        [viewConcept setHidden:YES];
        [viewScrapbook setHidden:NO];
        [view_having_edit_3WH setHidden:TRUE];
        
        
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    self.navigationItem.leftBarButtonItem = btnCancelEditIdea;
    self.navigationItem.rightBarButtonItem = btnSaveEditIdea;
    
    if([self connected])
    {
        [self CallWebServiceForSketchScrapbook];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity1 setHidden:YES];
        [activity2 setHidden:YES];
        [activity3 setHidden:YES];
        [activity4 setHidden:YES];
        
        [activity1 stopAnimating];
        [activity2 stopAnimating];
        [activity3 stopAnimating];
        [activity4 stopAnimating];
    }

    
    
}

/*- (void) dismissView{

    [self.navigationController popViewControllerAnimated:YES];

}
*/

//-(void)HideKeyboard
//{
//    
//    [txtAreaScrapbook resignFirstResponder];
//  //  [whatTxtView resignFirstResponder];
//   // [whoTxtView resignFirstResponder];
//   // [whyTxtView resignFirstResponder];
//    [btnDone setHidden:YES];
//}

#pragma mark-

-(void)btnLogoutpressed
{

}


/*-(void) btncancelPress
{
    if (isScrapbook) 
     {
            isEditing = NO;
         [btnDone setHidden:YES];
         //[txtAreaScrapbook setText:temp];
         
          [scrapbookTxtView resignFirstResponder];
         
         [txtAreaScrapbook setHidden:YES];
         [lblScrap setHidden:NO];
         self.navigationItem.leftBarButtonItem=nil;
         
         [btnEdit setTitle:@"Edit"];
            txtAreaScrapbook.layer.borderWidth = 0.0f;
            txtAreaScrapbook.layer.borderColor = nil;
            [self.scrollView setContentSize:CGSizeMake(320.00,txtAreaScrapbook.frame.origin.y+txtAreaScrapbook.frame.size.height+10)];
         
        }

   if (isConcept) 
   {
       
        [btnDone setHidden:YES];
             self.navigationItem.leftBarButtonItem=nil;
       lblWhyMain.frame = CGRectMake( lblWhyMain.frame.origin.x, lblWho.frame.origin.y+lblWho.frame.size.height+10, lblWhyMain.frame.size.width,30 );

       lblWhy.frame = CGRectMake( lblWhy.frame.origin.x, lblWhyMain.frame.origin.y+lblWhyMain.frame.size.height+5, lblWhy.frame.size.width,lblWhy.frame.size.height  _hSizeWhy.height );
       
       
       lblwhatMain.frame = CGRectMake( lblwhatMain.frame.origin.x, lblWhy.frame.origin.y+lblWhy.frame.size.height+10, lblwhatMain.frame.size.width,30 );
       
       
       
       lblWhat.frame = CGRectMake( lblWhat.frame.origin.x, lblwhatMain.frame.origin.y+lblwhatMain.frame.size.height+5, lblWhat.frame.size.width,lblWhat.frame.size.height  _hSizeWhat.height );
       

       
       //[whatTxtView setHidden:YES];
      // [whoTxtView setHidden:YES];
      // [whyTxtView setHidden:YES];
       [lblWhat setHidden:NO];
       [lblWho setHidden:NO];
       [lblWhy setHidden:NO];
       
       isEditing = NO;
            
     //  [whoTxtView resignFirstResponder];
      // [whyTxtView resignFirstResponder];
      // [whatTxtView resignFirstResponder];
       
       [btnEdit setTitle:@"Edit"];
       [self.scrollView setContentSize:CGSizeMake(320.00,lblWhat.frame.origin.y+lblWhat.frame.size.height+10)];
       

       
   }
}*/


/*- (void) editBtnClicked
{
   // [btnDone setHidden:NO];
    
    NSLog(@"editBtnClicked");
    
    if(!isEditing)
    {
        barbuttonL=[[UIBarButtonItem alloc]initWithTitle:@"cancel" style:UIBarButtonItemStyleDone target:self action:@selector(btncancelPress)];
        self.navigationItem.leftBarButtonItem=barbuttonL;
    }
    else
    {
        self.navigationItem.leftBarButtonItem=nil;
    }
    if (isScrapbook) {
        
        
        if (!isEditing) 
        {
            [lblScrap setHidden:YES];
            [txtAreaScrapbook setHidden:NO];
            isEditing = YES;
            [scrapbookTxtView setEditable:YES];
            [scrapbookTxtView becomeFirstResponder];
            [btnEdit setTitle:@"Done"];
            [txtAreaScrapbook setText:lblScrap.text];
            //[btnEdit setStyle:UIBarButtonSystemItemDone];
                    
             [self.scrollView setContentSize:CGSizeMake(320.00,txtAreaScrapbook.frame.origin.y+scrollView.frame.size.height+100)];
            txtAreaScrapbook.layer.borderWidth = 1.0f;
            txtAreaScrapbook.layer.borderColor = [[UIColor grayColor] CGColor];
        }
        else 
        {
            // [txtAreaScrapbook setText:lblScrap.text];
            isEditing = NO;
            [lblScrap setHidden:NO];
            [btnDone setHidden:YES];
            [txtAreaScrapbook setHidden:YES];
            [scrapbookTxtView setEditable:NO];
            [scrapbookTxtView resignFirstResponder];
            [btnEdit setTitle:@"Edit"];
            [activity3 setHidden:NO];
            [activity3 startAnimating];
            txtAreaScrapbook.layer.borderWidth = 0.0f;
            txtAreaScrapbook.layer.borderColor = nil;
            [self CallWebServiceForForEditScrapbook];
            
            //[btnEdit setStyle:UIBarButtonSystemItemEdit];
        }
    }
    
    if (isConcept) {
        [self.scrollView addSubview:viewConcept];
        
        if (!isEditing) 
        {
            [lblWhat setHidden:YES];
            [lblWho setHidden:YES];
            [lblWhy setHidden:YES];
            
        //    [whatTxtView setHidden:NO];
         //   [whoTxtView setHidden:NO];
         //   [whyTxtView setHidden:NO];
            
            isEditing = YES;
            
                 //lblWho.frame = CGRectMake( lblWho.frame.origin.x, 53.00000  lblWho.frame.origin.y+10, lblWho.frame.size.width, _hSizeA.height+15);
                
                
                lblWhyMain.frame = CGRectMake( 20 , 144, 248,36 );
                
                
                
                whyTxtView.frame=CGRectMake(whyTxtView.frame.origin.x, whyTxtView.frame.origin.y, whyTxtView.frame.size.width, whyTxtView.frame.size.height);
                
                lblwhatMain.frame = CGRectMake( 20, 279, 231,30 );
                
                whatTxtView.frame=CGRectMake(whatTxtView.frame.origin.x, whatTxtView.frame.origin.y, whatTxtView.frame.size.width, whatTxtView.frame.size.height);  
            
            whoTxtView.layer.borderWidth = 1.0f;
            whoTxtView.layer.borderColor = [[UIColor grayColor] CGColor];
            
            whyTxtView.layer.borderWidth = 1.0f;
            whyTxtView.layer.borderColor = [[UIColor grayColor] CGColor];
            
            
            whatTxtView.layer.borderWidth = 1.0f;
            whatTxtView.layer.borderColor = [[UIColor grayColor] CGColor];
            
            
             
            [whoTxtView setEditable:YES];
            [whyTxtView setEditable:YES];
            [whatTxtView setEditable:YES];
           
            
            [whoTxtView setText:lblWho.text];
            [whyTxtView setText:lblWhy.text];
            [whatTxtView setText:lblWhat.text];
            //[self.scrollView setContentSize:CGSizeMake(320.00,whatTxtView.frame.origin.y+whatTxtView.frame.size.height+200)];
            
            //[scrapbookTxtView becomeFirstResponder];
            [btnEdit setTitle:@"Done"];
         
            
                        //[btnEdit setStyle:UIBarButtonSystemItemDone];
        }
        else {
            
             [btnDone setHidden:YES];
            //[whatTxtView setHidden:YES];
           // [whoTxtView setHidden:YES];
          //  [whyTxtView setHidden:YES];
            [lblWhat setHidden:NO];
            [lblWho setHidden:NO];
            [lblWhy setHidden:NO];
            
            isEditing = NO;
          //  [whoTxtView setEditable:NO];
           // [whyTxtView setEditable:NO];
           // [whatTxtView setEditable:NO];
            
           // [whoTxtView resignFirstResponder];
          //  [whyTxtView resignFirstResponder];
          //  [whatTxtView resignFirstResponder];
            
            //[btnEdit setStyle:UIBarButtonSystemItemEdit];
            [btnEdit setTitle:@"Edit"];
            [activity2 setHidden:NO];
            [activity2 startAnimating];
            [self CallWebServiceForForEditConcept];
        }
    }
    
    
    
    
    
    
}
*/
- (void)viewDidUnload
{
    [self setLbltitle:nil];
    [self setLbloriginalIdea:nil];
   // [self setTxtwho:nil];
    //[self setTxtAreaWhy:nil];
   // [self setTxtAreaWhat:nil];
    [self setTxtAreaScrapbook:nil];
    [self setLblWho:nil];
    [self setLblWhy:nil];
    [self setLblWhat:nil];
    [self setLblWhyMain:nil];
    [self setLblwhatMain:nil];
    [self setLblScrap:nil];
     [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/*- (IBAction)btnSketchPressed:(id)sender
{
    self.navigationItem.leftBarButtonItem=nil;
    
    [activity1 setHidden:NO];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    
    
    [activity1 startAnimating];
    if (!isSketch) 
    {
        
    
   // [btnSketch setBackgroundColor:[UIColor darkGrayColor]];
   // [btnConcept setBackgroundColor:[UIColor clearColor]];
    [btnScrapbook setBackgroundColor:[UIColor clearColor]];
    
    [viewSketch setHidden:NO];
    [viewConcept setHidden:YES];
    [viewScrapbook setHidden:YES];
    

        self.navigationItem.rightBarButtonItem = barbuttonR;
        
    isSketch = YES;
    isConcept = NO;
    isScrapbook = NO;
    }
    [self CallWebService];
}
- (IBAction)btnConceptPressed:(id)sender
{
    self.navigationItem.leftBarButtonItem=nil;
    
    [activity1 setHidden:YES];
    [activity2 setHidden:NO];
    [activity3 setHidden:YES];
    
    
    [activity2 startAnimating];
    NSLog(@"startAnimating");
    if (!isConcept) 
    {
        
    //[btnSketch setBackgroundColor:[UIColor clearColor]];
   // [btnConcept setBackgroundColor:[UIColor darkGrayColor]];
    [btnScrapbook setBackgroundColor:[UIColor clearColor]];
    
    [viewSketch setHidden:YES];
    [viewConcept setHidden:NO];
    [viewScrapbook setHidden:YES];
    
        self.navigationItem.rightBarButtonItem = btnEdit;
    
    isSketch = NO;
    isConcept = YES;
    isScrapbook = NO;

    }
    NSLog(@"btnConceptPressed.......");
    [self CallWebServiceForSketchConcept];
}


*/
#pragma mark -WebService Methods

-(void)CallWebServiceForSketchDetail
{
    
    [activity1 startAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:NO];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    isWHO_Edit = FALSE;
     isWHY_Edit = FALSE;
     isWHAT_Edit = FALSE;
     isScrapBook_Edit = FALSE;
     isSketchIdeaConceptEdit = FALSE;
     isSketchDetail = TRUE;
     isScrapBookDetail = FALSE;
     isConcept3WhDetail = FALSE;
    
    
    
   NSString * strurl = WEBSERVICEURL;


    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<urn:SketchDetail soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>\n"
                           "</urn:SketchDetail>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>",self.sketchId
                       ];

NSLog(@"123%@",soapMessage);
NSURL *url=[NSURL URLWithString:strurl];
NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];

[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
[theRequest addValue: @"urn:quote5#SketchDetail" forHTTPHeaderField:@"SOAPAction"];
[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
[theRequest setHTTPMethod:@"POST"];
[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];

_connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];


}


-(void)CallWebServiceForSketchConcept
{

    [activity1 stopAnimating];
    [activity2 startAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:YES];
    [activity2 setHidden:NO];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    isWHO_Edit = FALSE;
    isWHY_Edit = FALSE;
    isWHAT_Edit = FALSE;
    isScrapBook_Edit = FALSE;
    isSketchIdeaConceptEdit = FALSE;
    isSketchDetail = FALSE;
    isScrapBookDetail = FALSE;
    isConcept3WhDetail = TRUE;
    isSketchDetailOnEdit = FALSE;
    
  
    
    
    NSLog(@"SketchConcept");


NSString *strurl=WEBSERVICEURL;


NSString *soapMessage=[NSString stringWithFormat:
                       @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                       "<soapenv:Header/>\n"
                       "<soapenv:Body>\n"
                       "<urn:SketchConcept soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                       "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>\n"
                       "</urn:SketchConcept>\n"
                       "</soapenv:Body>\n"
                       "</soapenv:Envelope>",self.sketchId
                       ];

NSLog(@"123%@",soapMessage);
NSURL *url=[NSURL URLWithString:strurl];
NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];

[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
[theRequest addValue: @"urn:quote5#SketchConcept" forHTTPHeaderField:@"SOAPAction"];
[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
[theRequest setHTTPMethod:@"POST"];
[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];

_connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];

}

-(void)CallWebServiceForSketchScrapbook
{
    
    [activity1 stopAnimating];
    [activity2 stopAnimating];
    [activity3 startAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:NO];
    [activity4 setHidden:YES];
    
    
    isWHO_Edit = FALSE;
    isWHY_Edit = FALSE;
    isWHAT_Edit = FALSE;
    isScrapBook_Edit = FALSE;
    isSketchIdeaConceptEdit = FALSE;
    isSketchDetail = FALSE;
    isScrapBookDetail = TRUE;
    isConcept3WhDetail = FALSE;
    
      NSString *strurl=WEBSERVICEURL;
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<urn:SketchScrapbook soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>\n"
                           "</urn:SketchScrapbook>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>",self.sketchId
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#SketchScrapbook" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
    }


-(void) CallWebServiceForForEditConcept
{
    
    [activity1 stopAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 startAnimating];
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:NO];
    
    
    isScrapBook_Edit = FALSE;
    isSketchIdeaConceptEdit = FALSE;
    isSketchDetail = FALSE;
    isScrapBookDetail = FALSE;
    isConcept3WhDetail = TRUE;
    
    // target=whoTxtView.text;
    // benefit=whyTxtView.text;
    //  pain=whatTxtView.text;
    
//    NSLog(@"target--who---%@",target);
//    NSLog(@"benefit--what-%@",benefit);
//    NSLog(@"pain--why--%@",pain);
    
    
    NSString *txt_WHO_target =@""; NSString *txt_WHY_pain =@""; NSString *txt_WHAT_benefit =@"";
    if(target.length == 0 || [target isEqualToString:@"Write down here..."] ||[target isEqualToString:@"Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B..."] )
    {
        txt_WHO_target = @"";
    }
    else
    {
        //txt_WHO_target = txtView_edit_WHO_WHY_WHAT.text;
        txt_WHO_target = target;
    }
    if(benefit.length == 0  || [benefit isEqualToString:@"Write down here..."] || [benefit isEqualToString:@"What is the SOLUTION or BENEFIT you will be offering with your product/service?"])
    {
        txt_WHAT_benefit = @"";
    }
    else
    {
        //txt_WHAT_benefit = txtView_edit_WHO_WHY_WHAT.text;
        txt_WHAT_benefit = benefit;
    }
    if(pain.length == 0 || [pain isEqualToString:@"Write down here..."] || [pain isEqualToString:@"Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?"])
    {
        txt_WHY_pain = @"";
    }
    else
    {
       // txt_WHY_pain = txtView_edit_WHO_WHY_WHAT.text;
        txt_WHY_pain = pain;
    }
    
    
//    NSLog(@"txt_WHO_target-----%@",txt_WHO_target);
//    NSLog(@"txt_WHAT_benefit-----%@",txt_WHAT_benefit);
//    NSLog(@"txt_WHY_pain----%@",txt_WHY_pain);
    
    
    
    
   NSString * strurl=WEBSERVICEURL;
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<urn:EditConcept soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>\n"
                           "<text_target xsi:type=\"xsd:string\">%@</text_target>\n"
                           "<text_benefit xsi:type=\"xsd:string\">%@</text_benefit>\n"
                           "<text_pain xsi:type=\"xsd:string\">%@</text_pain>\n"
                           "</urn:EditConcept>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>",self.sketchId,[txt_WHO_target urlEncode],[txt_WHAT_benefit urlEncode],[txt_WHY_pain urlEncode]
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#EditConcept" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
}

-(void)CallWebServiceForForEditScrapbook
{
    
    [activity1 stopAnimating];
    [activity2 stopAnimating];
    [activity3 startAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:NO];
    [activity4 setHidden:YES];
    
    isWHO_Edit = FALSE;
    isWHY_Edit = FALSE;
    isWHAT_Edit = FALSE;
    isScrapBook_Edit = TRUE;
    isSketchIdeaConceptEdit = FALSE;
    isSketchDetail = FALSE;
    isScrapBookDetail = FALSE;
    isConcept3WhDetail = FALSE;
   
    
    NSString *scrap=[txtAreaScrapbook.text urlEncode];
    
   
    NSString *strurl=WEBSERVICEURL;
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<urn:EditScrapbook soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>\n"
                           "<text_scrapbook xsi:type=\"xsd:string\">%@</text_scrapbook>\n"
                           "</urn:EditScrapbook>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>",self.sketchId,scrap
                           ];
    
    NSLog(@"123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#EditScrapbook" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
    
    
    
}
-(void)CallWebServiceForEditSketchIdea
{
    [activity1 startAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:NO];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    isWHO_Edit = FALSE;
    isWHY_Edit = FALSE;
    isWHAT_Edit = FALSE;
    isScrapBook_Edit = FALSE;
    isSketchIdeaConceptEdit = TRUE;
    isSketchDetail = FALSE;
    isScrapBookDetail = FALSE;
    isConcept3WhDetail = FALSE;
    
    
    NSString *sketch_idea=[txtAreaIdea.text urlEncode];
     NSString *sketch_title=[txtviewTitle.text urlEncode];
    NSString *owenerId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    NSString *strurl=[NSString stringWithString:@""];
    strurl=WEBSERVICEURL;
    
    
    NSString *soapMessage=[NSString stringWithFormat:
                           @"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:quote5\">"
                           "<soapenv:Header/>"
                           "<soapenv:Body>"
                           "<urn:editSketch soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">"
                           "<sketch_id xsi:type=\"xsd:string\">%@</sketch_id>"
                           "<owner_id xsi:type=\"xsd:string\">%@</owner_id>"
                           "<sketch_title xsi:type=\"xsd:string\">%@</sketch_title>"
                           "<original_idea xsi:type=\"xsd:string\">%@</original_idea>"
                           "<isPublic xsi:type=\"xsd:string\">%@</isPublic>"
                           "</urn:editSketch>"
                           "</soapenv:Body>"
                           "</soapenv:Envelope>",self.sketchId,owenerId,sketch_title,sketch_idea,@"1"
                           ];
    
    NSLog(@"CallWebServiceForEditSketchIdea --123%@",soapMessage);
    NSURL *url=[NSURL URLWithString:strurl];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc]initWithURL:url];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"urn:quote5#editSketch" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    _connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    
    
    
    
}
#pragma mark - NSURLConnection Delegate Methods

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
    
    [activity1 stopAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    UIAlertView *alertFParser = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Internet Connection Not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertFParser show];
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    [activity1 stopAnimating];
    [activity2 stopAnimating];
    [activity3 stopAnimating];
    [activity4 stopAnimating];
    [activity1 setHidden:YES];
    [activity2 setHidden:YES];
    [activity3 setHidden:YES];
    [activity4 setHidden:YES];
    
    
    
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
    
//    NSLog(@"isSketchDetail--------%d",isSketchDetail);
//    NSLog(@"isConcept3WhDetail------%d",isConcept3WhDetail);
//    NSLog(@"isScrapBookDetail------%d",isScrapBookDetail);
//    NSLog(@"isScrapBook_Edit-------%d",isScrapBook_Edit);
//    NSLog(@"isSketchIdeaConceptEdit-----%d",isSketchIdeaConceptEdit);
    
    
    if(isSketchDetail)
    {
        [self parseJsonResultSketchDetail:responseString];
    }
    if(isConcept3WhDetail)
    {
        NSLog(@"SketchConcept123");
        if(isWHO_Edit)
        {
            [self parseJsonResultForConceptEditing:responseString];
        }
       else  if(isWHY_Edit)
        {
            [self parseJsonResultForConceptEditing:responseString];
        }
       else  if(isWHAT_Edit)
        {
            [self parseJsonResultForConceptEditing:responseString];
        }
       else{
        [self parseJsonResultForSketchConcept:responseString];
       }
        
    }
    if(isScrapBookDetail)
    {
        [self parseJsonResultForSketchScrapbook:responseString];
    }
    
    if(isScrapBook_Edit)
    {
        [self parseJsonResultForScrapbookEditing:responseString];
    }
    if(isSketchIdeaConceptEdit)
    {
        [self parseJsonResultForSketchDetailEditing:responseString];
    }
}


/*-(void) parseJsonResultForSketchConcept:(NSString *)_respponseString
{
    
    NSDictionary *mainDict=[_respponseString JSONValue];
    success=[[mainDict valueForKey:@"Status"] boolValue];
    if(success)
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *Title=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Title"]];
        NSString *conceptID=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"conceptID"]];
        NSString *Who=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Who"]];
        NSString *Why=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Why"]];
        NSString *What=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"What"]];
        //[txtwho setText:Who];
        //[txtAreaWhy setText:Why];
        //[txtAreaWhat setText:What];
        
        NSLog(@"SketchConcept456");
        NSLog(@"Who....%@",Who);
        
       // [lblWho setText:Who];
       // [lblWhy setText:Why];
        //[lblWhat setText:What];
        
        
        
       // lblWho.attributedText=attrStrA;
        
        lblWho.text=Who;
        [lblWho setTextColor:[UIColor blackColor]];
        lblWho.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        
        lblWho.lineBreakMode = UILineBreakModeWordWrap;
        lblWho.numberOfLines = 0;
        CGSize constraintSizeQ = CGSizeMake(lblWho.frame.size.width, MAXFLOAT);
        CGSize _hSizeA = [[lblWho text] sizeWithFont:[lblWho font] constrainedToSize:constraintSizeQ lineBreakMode:UILineBreakModeWordWrap];
       // lblWho.frame = CGRectMake( lblWho.frame.origin.x, lblWho.frame.origin.y+10, lblWho.frame.size.width, _hSizeA.height+15);
        
        
        lblWhy.text=Why;
        [lblWhy setTextColor:[UIColor blackColor]];
        lblWhy.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        
        lblWhy.lineBreakMode = UILineBreakModeWordWrap;
        lblWhy.numberOfLines = 0;
        CGSize constraintSizeLblWhy = CGSizeMake(lblWhy.frame.size.width, MAXFLOAT);
        CGSize _hSizeWhy = [[lblWhy text] sizeWithFont:[lblWhy font] constrainedToSize:constraintSizeLblWhy lineBreakMode:UILineBreakModeWordWrap];

               
        lblWhat.text=What;
        [lblWhat setTextColor:[UIColor blackColor]];
        lblWhat.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        
        lblWhat.lineBreakMode = UILineBreakModeWordWrap;
        lblWhat.numberOfLines = 0;
        CGSize constraintSizeLblWhat = CGSizeMake(lblWhat.frame.size.width, MAXFLOAT);
        CGSize _hSizeWhat = [[lblWhat text] sizeWithFont:[lblWhat font] constrainedToSize:constraintSizeLblWhat lineBreakMode:UILineBreakModeWordWrap];

        
    if(!isEditing)
    {
         if(_hSizeA.height>29)
         {             
              //lblWho.frame.origin.y+10
             lblWho.frame = CGRectMake( lblWho.frame.origin.x, 53.00000, lblWho.frame.size.width, _hSizeA.height+15);
             

             lblWhyMain.frame = CGRectMake( lblWhyMain.frame.origin.x, lblWho.frame.origin.y+lblWho.frame.size.height+10, lblWhyMain.frame.size.width,30 );
            
             
             lblWhy.frame = CGRectMake( lblWhy.frame.origin.x, lblWhyMain.frame.origin.y+lblWhyMain.frame.size.height+7, lblWhy.frame.size.width,_hSizeWhy.height+15 );
             
             
             lblwhatMain.frame = CGRectMake( lblwhatMain.frame.origin.x, lblWhy.frame.origin.y+lblWhy.frame.size.height+10, lblwhatMain.frame.size.width,30 );
            
             lblWhat.frame = CGRectMake( lblWhat.frame.origin.x, lblwhatMain.frame.origin.y+lblwhatMain.frame.size.height+7, lblWhat.frame.size.width,_hSizeWhat.height+15 );
             
         }
        
        if(_hSizeWhy.height>29)
        {
            lblWhy.frame = CGRectMake( lblWhy.frame.origin.x, lblWhyMain.frame.origin.y+lblWhyMain.frame.size.height+5, lblWhy.frame.size.width, _hSizeWhy.height+15);
       
            
            lblwhatMain.frame = CGRectMake( lblwhatMain.frame.origin.x, lblWhy.frame.origin.y+lblWhy.frame.size.height+10, lblwhatMain.frame.size.width,30 );
            
            lblWhat.frame = CGRectMake( lblWhat.frame.origin.x, lblwhatMain.frame.origin.y+lblwhatMain.frame.size.height+5, lblWhat.frame.size.width,_hSizeWhat.height+15);
            
            
        }
        
        if(_hSizeWhat.height>29)
        {
            lblWhat.frame = CGRectMake( lblWhat.frame.origin.x, lblwhatMain.frame.origin.y+lblwhatMain.frame.size.height+5, lblWhat.frame.size.width, _hSizeWhat.height+15);
            
            
        }
        
    //scrollView.frame=CGRectMake(0, 0, 320, lblWhat.frame.origin.y+lblWhat.frame.size.height+10);
        
    [self.scrollView setContentSize:CGSizeMake(320.00,lblWhat.frame.origin.y+lblWhat.frame.size.height+10)];
}
    
   
        [lblSketch setText:Title];
        
        if ((NSNull *) Title == [NSNull null] || [Title length] == 0) {
            Title=@"";
        }
        
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        if ((NSNull *) conceptID == [NSNull null] || [conceptID length] == 0) {
            conceptID=@"";
        }
        if ((NSNull *) Who == [NSNull null] || [Who length] == 0) {
            Who=@"";
        }
        if ((NSNull *) Why == [NSNull null] || [Why length] == 0) {
            Why=@"";
        }
        if ((NSNull *) What == [NSNull null] || [What length] == 0) {
            What=@"";
        }
        
        
        
        

         NSLog(@"sketch Message...%@",Message);
        NSLog(@"sketch conceptID...%@",conceptID);
    }
    else 
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *Error = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Error"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
            Error = @"";
        }
        
        
       // if[(Message isEqualToString:@"No concept added.") ]

        NSString *msg;
        if([Message isEqualToString:@"No concept added."])
        {
            msg=@"Click edit to start working on the concept.";
            //Click edit to start making notes
        }
        else 
        {
            msg=Message;
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }

    

}*/

#pragma mark - Parse JSON Results
-(void) parseJsonResultForSketchConcept:(NSString *)_respponseString
{
    
    NSDictionary *mainDict=[_respponseString JSONValue];
    success=[[mainDict valueForKey:@"Status"] boolValue];
    if(success)
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *Title=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Title"]] ;
        NSString *conceptID=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"conceptID"]];
        NSString *Who=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Who"]] ;
        NSString *Why=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Why"]] ;
        NSString *What=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"What"]] ;
        
        if(Title.length == 0|| Title ==(id)[NSNull null] || [Title isEqualToString:@"null"])
        {
            
        }
        else
        {
            Title = [Title URLDecodedString];
        }
        if(Who.length == 0|| Who ==(id)[NSNull null] || [Who isEqualToString:@"null"])
        {
            
        }
        else
        {
            Who = [Who URLDecodedString];
        }
        if(Why.length == 0|| Why ==(id)[NSNull null] || [Why isEqualToString:@"null"])
        {
            
        }
        else
        {
            Why = [Why URLDecodedString];
        }
        if(What.length == 0|| What ==(id)[NSNull null] || [What isEqualToString:@"null"])
        {
            
        }
        else
        {
            What = [What URLDecodedString];
        }
        
        
        
        
        NSLog(@"SketchConcept456");
        NSLog(@"Who....%@",Who);
        
        target = Who;
        benefit = What;
        pain = Why;
        
        lblWho.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        lblWho.textColor = [UIColor blackColor];
        
        lblWhy.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        lblWhy.textColor = [UIColor blackColor];
        
        lblWhat.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        lblWhat.textColor = [UIColor blackColor];
        
        lblWho.text=Who;
        [lblWho setTextColor:[UIColor blackColor]];
        lblWho.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        
       // lblWho.lineBreakMode = NSLineBreakByWordWrapping;
       
       // CGSize constraintSizeQ = CGSizeMake(lblWho.frame.size.width, MAXFLOAT);
      //  CGSize _hSizeA = [[lblWho text] sizeWithFont:[lblWho font] constrainedToSize:constraintSizeQ lineBreakMode:UILineBreakModeWordWrap];
        // lblWho.frame = CGRectMake( lblWho.frame.origin.x, lblWho.frame.origin.y+10, lblWho.frame.size.width, _hSizeA.height+15);
        
        
        lblWhy.text=Why;
        [lblWhy setTextColor:[UIColor blackColor]];
        //lblWhy.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        
     //   lblWhy.lineBreakMode = NSLineBreakByWordWrapping;
        
        
       // CGSize constraintSizeLblWhy = CGSizeMake(lblWhy.frame.size.width, MAXFLOAT);
        //CGSize _hSizeWhy = [[lblWhy text] sizeWithFont:[lblWhy font] constrainedToSize:constraintSizeLblWhy lineBreakMode:UILineBreakModeWordWrap];
        
        
        lblWhat.text=What;
        [lblWhat setTextColor:[UIColor blackColor]];
        
       // lblWhat.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        
        //lblWhat.lineBreakMode = NSLineBreakByWordWrapping;
       
        //CGSize constraintSizeLblWhat = CGSizeMake(lblWhat.frame.size.width, MAXFLOAT);
       // CGSize _hSizeWhat = [[lblWhat text] sizeWithFont:[lblWhat font] constrainedToSize:constraintSizeLblWhat lineBreakMode:UILineBreakModeWordWrap];
        
        
        
        
        [lblSketch setText:Title];
        
        if ((NSNull *) Title == [NSNull null] || [Title length] == 0) {
            Title=@"";
        }
        
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        if ((NSNull *) conceptID == [NSNull null] || [conceptID length] == 0) {
            conceptID=@"";
        }
        if ( Who == (id)[NSNull null] || [Who length] == 0  || [Who isEqualToString:@"(null)"] || [Who isEqualToString:@"<null>"]) {
            //Who=@"";
            lblWho.text = @"Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B...";
            lblWho.font = [UIFont italicSystemFontOfSize:13.0];
             lblWho.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
            
            target = @"Write down here...";
        }
        if ( Why == (id)[NSNull null] || [Why length] == 0 || [Why isEqualToString:@"(null)"] || [Why isEqualToString:@"<null>"]) {
            //Why=@"";
            lblWhy.text= @"Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?";
            lblWhy.font = [UIFont italicSystemFontOfSize:13.0];
            lblWhy.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
            pain = @"Write down here...";
        }
        if ( What == (id)[NSNull null] || [What length] == 0 || [What isEqualToString:@"(null)"] || [What isEqualToString:@"<null>"]) {
            //What=@"";
            lblWhat.text= @"What is the SOLUTION or BENEFIT you will be offering with your product/service?";
            lblWhat.font = [UIFont italicSystemFontOfSize:13.0];
            lblWhat.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
            benefit = @"Write down here...";
        }
        
        if(Who.length == 0 && Why.length == 0 && What.length == 0)
        {
            target = @"Write down here...";
            benefit = @"Write down here...";
            pain = @"Write down here...";
            txtView_edit_WHO_WHY_WHAT.text = @"Write down here...";
            txtView_edit_WHO_WHY_WHAT.textColor = [UIColor lightGrayColor];
            
            lblWho.font = [UIFont italicSystemFontOfSize:13.0];
            lblWhy.font = [UIFont italicSystemFontOfSize:13.0];
            lblWhat.font = [UIFont italicSystemFontOfSize:13.0];
            
            
            lblWho.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
            lblWhy.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
            lblWhat.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
            
            lblWho.text = @"Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B...";
            lblWhy.text= @"Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?";
            lblWhat.text= @"What is the SOLUTION or BENEFIT you will be offering with your product/service?";
        }
        
        
        
//        NSLog(@"lblWho--true--%@",lblWho.text);
//        NSLog(@"lblWhy----true--%@",lblWhy.text);
//        NSLog(@"lblWhat---true---%@",lblWhat.text);
//        NSLog(@"bttn_arrow---true---%f",bttn_arrow.frame.origin.x);
        
        NSLog(@"sketch Message...%@",Message);
        NSLog(@"sketch conceptID...%@",conceptID);
        
        
        lblWhy.numberOfLines = 6;
        lblWhy.frame = CGRectMake(lblWhy.frame.origin.x, lblWhy.frame.origin.y,bttn_arrow.frame.origin.x-85, lblWhy.frame.size.height);
        [lblWhy sizeToFit];
        
        
        lblWhat.numberOfLines = 6;
        lblWhat.frame = CGRectMake(lblWhat.frame.origin.x, lblWhat.frame.origin.y, bttn_arrow.frame.origin.x-85, lblWhat.frame.size.height);
        [lblWhat sizeToFit];
        
        
        lblWho.numberOfLines = 6;
        lblWho.frame = CGRectMake(lblWho.frame.origin.x, lblWho.frame.origin.y, bttn_arrow.frame.origin.x-85, lblWho.frame.size.height);
        [lblWho sizeToFit];
        
        
//        NSLog(@"lblWhy---frame.size.width---%f",lblWhy.frame.size.width);
//        NSLog(@"lblWhat--frame.size.width----%f",lblWhat.frame.size.width);
//        NSLog(@"lblWho---frame.size.width---%f",lblWho.frame.size.width);
        
        
    }
    else
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *Error = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Error"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
            Error = @"";
        }
        
        
        // if[(Message isEqualToString:@"No concept added.") ]
        
        NSString *msg;
        if([Message isEqualToString:@"Develop your sketch."])
        {
            msg=@"Click on WHO, WHY and WHAT to start working on the concept.";
            //Click edit to start making notes
        }
        else
        {
            msg=Message;
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
        
        lblWho.font = [UIFont italicSystemFontOfSize:13.0];
        lblWhy.font = [UIFont italicSystemFontOfSize:13.0];
        lblWhat.font = [UIFont italicSystemFontOfSize:13.0];
        
        
        lblWho.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
        lblWhy.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
        lblWhat.textColor = [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0];
        
        
        target = @"Write down here...";
        benefit = @"Write down here...";
        pain = @"Write down here...";
        
        lblWho.text = @"Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B...";
        
        lblWhy.text= @"Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?";
        
        lblWhat.text= @"What is the SOLUTION or BENEFIT you will be offering with your product/service?";
        
//        NSLog(@"lblWho--false--%@",lblWho.text);
//        NSLog(@"lblWhy----false--%@",lblWhy.text);
//        NSLog(@"lblWhat---false---%@",lblWhat.text);
        
        lblWho.numberOfLines = 6;
        [lblWho sizeToFit];
        
        lblWhy.numberOfLines = 6;
        [lblWhy sizeToFit];
        
        lblWhat.numberOfLines = 6;
        [lblWhat sizeToFit];
        
        txtView_edit_WHO_WHY_WHAT.text = @"Write down here...";
        txtView_edit_WHO_WHY_WHAT.textColor = [UIColor lightGrayColor];
        
    }
    
    
    
}
- (void) parseJsonResultSketchDetail:(NSString *) _respponseString
{
    /*
     {"Status":true,"Message":"Sketch detail","Title":"My Sketch","OrigionalIdea":"This is testing sketch"}
    */

    NSLog(@"_respponseString---- sketchDetail--%@",_respponseString);
    
    NSDictionary *mainDict=[_respponseString JSONValue];
    success=[[mainDict valueForKey:@"Status"] boolValue];
    if(success)
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *title=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Title"]];
        NSString *OrigionalIdea=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"OrigionalIdea"]];
        
        
        //[lbltitle setText:title];
        if(title == (id)[NSNull null] || title.length == 0 ||  [title isEqualToString:@"null"] ||[title isEqualToString:@"<null>"] ||[title isEqualToString:@"(null)"])
        {
            
        }
        else
        {
            title =  [title URLDecodedString];
        }
        if( OrigionalIdea == (id)[NSNull null] || OrigionalIdea.length == 0 ||  [OrigionalIdea isEqualToString:@"null"]||[OrigionalIdea isEqualToString:@"(null)"]||[OrigionalIdea isEqualToString:@"<null>"])
        {
            
        }
        else
        {
            OrigionalIdea = [OrigionalIdea URLDecodedString];
        }
       
        //        lbloriginalIdea.text=OrigionalIdea;
//        [lbloriginalIdea setTextColor:[UIColor blackColor]];
//        lbloriginalIdea.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
//        lbloriginalIdea.lineBreakMode = UILineBreakModeWordWrap;
//        lbloriginalIdea.numberOfLines = 0;
//        CGSize constraintSizelbloriginalIdea = CGSizeMake(lbloriginalIdea.frame.size.width, MAXFLOAT);
//        CGSize _hSizelbloriginalIdea  = [[lbloriginalIdea text] sizeWithFont:[lbloriginalIdea font] constrainedToSize:constraintSizelbloriginalIdea lineBreakMode:UILineBreakModeWordWrap];
//        
//       if(_hSizelbloriginalIdea.height >267) 
//       {
//           lbloriginalIdea.frame = CGRectMake( lbloriginalIdea.frame.origin.x, 81.00000/*lblWho.frame.origin.y+10*/, lbloriginalIdea.frame.size.width, _hSizelbloriginalIdea.height+15);
//
//           [self.scrollView setContentSize:CGSizeMake(320.00,lbloriginalIdea.frame.origin.y+lbloriginalIdea.frame.size.height+10)];
//
//       }
//        
//       
//        
//        [lblSketch setText:title];
//        [self.scrollView setContentSize:CGSizeMake(320.00,lbloriginalIdea.frame.origin.y+lbloriginalIdea.frame.size.height+10)];
        
        self.title = title;
        
        txtviewTitle.text =title;
        lbl_essence_sketch_idea.text = OrigionalIdea;
        txtAreaIdea.text = OrigionalIdea;
        txtviewTitle.textColor = [UIColor blackColor];
        txtAreaIdea.textColor = [UIColor blackColor];
        
        NSLog(@"[title URLDecodedString]----%@",[title URLDecodedString]);
        NSLog(@"[OrigionalIdea URLDecodedString]-----%@",[OrigionalIdea URLDecodedString]);
        
        
        lbl_essence_sketch_idea.textColor =[ UIColor blackColor];
        lbl_essence_sketch_idea.font =[UIFont fontWithName:@"Helvetica" size:14.0];
        
        
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        if ((NSNull *) title == [NSNull null] || [title length] == 0) {
           // title=@"";
        }
        if ( OrigionalIdea == (id)[NSNull null] || [OrigionalIdea length] == 0 || [OrigionalIdea isEqualToString:@"<null>"]) {
          //  OrigionalIdea=@"";
            
            lbl_essence_sketch_idea.text = @"Essence of the idea in maximum 140 characters";
            lbl_essence_sketch_idea.textColor =[ UIColor lightGrayColor];
            lbl_essence_sketch_idea.font =[UIFont italicSystemFontOfSize:14.0];
            
        }

      
        


        
        
        NSLog(@"sketch Message...%@",Message);
        
    }
    else 
    {
        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *Error = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Error"]];
        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
            Message=@"";
        }
        
        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
            Error = @"";
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        txtviewTitle.text =@"Write down a working title for your idea in maximum 30 characters";
        txtAreaIdea.text =@"Write down a essence of the idea in maximum 140 characters";
        txtviewTitle.textColor = [UIColor lightGrayColor];
        txtAreaIdea.textColor = [UIColor lightGrayColor];
    }
//    isScrapBook_Edit= FALSE;
//    isWHO_Edit= FALSE;
//    isWHY_Edit= FALSE;
//    isWHAT_Edit= FALSE;
//    isSketchIdeaConceptEdit = TRUE;
    
    //isEditing=NO;
    if(isSketchDetailOnEdit)
    {
        if([self connected])
        {
            isSketchDetailOnEdit = FALSE;
            [self CallWebServiceForSketchConcept];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [activity1 setHidden:YES];
            [activity2 setHidden:YES];
            [activity3 setHidden:YES];
            [activity4 setHidden:YES];
            
            [activity1 stopAnimating];
            [activity2 stopAnimating];
            [activity3 stopAnimating];
            [activity4 stopAnimating];
        }
        
    }
    

}



-(void) parseJsonResultForSketchScrapbook:(NSString *)_respponseString
{
    /*{"Status":true,"Message":"Sketch Scrapbook","Title":"My Sketch","scrapbookID":"35","Scrapbook":"TEst Scrapbook"}*/
    
    NSDictionary *mainDict=[_respponseString JSONValue];
    success=[[mainDict valueForKey:@"Status"] boolValue];
    NSString *Scrapbook=@"";
    if(success)
    {
        NSString *message=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
        NSString *title=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Title"]] ;
    NSString *scrapbookID=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"scrapbookID"]];
        Scrapbook=[NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Scrapbook"]] ;
        if(title.length == 0 || title == (id)[NSNull null] || [title isEqualToString:@"null"]||[title isEqualToString:@"<null>"]||[title isEqualToString:@"(null)"])
        {
            
        }
        else
        {
            title = [title URLDecodedString];
        }
        if(Scrapbook.length == 0 || Scrapbook == (id)[NSNull null] || [Scrapbook isEqualToString:@"null"]||[Scrapbook isEqualToString:@"<null>"] || [Scrapbook isEqualToString:@"(null)"])
        {
            
        }
        else
        {
             Scrapbook = [Scrapbook URLDecodedString];
        }
        NSLog(@"scrap...%@",Scrapbook);
        NSLog(@"hello");
        
//        lblScrap.text=Scrapbook;
//        
//           [lblScrap setTextColor:[UIColor blackColor]];
//        lblScrap.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
//        
//        lblScrap.lineBreakMode = UILineBreakModeWordWrap;
//      lblScrap.numberOfLines = 0;
//        CGSize constraintSize = CGSizeMake(lblScrap.frame.size.width, MAXFLOAT);
//        CGSize _hSize = [[lblScrap text] sizeWithFont:[lblScrap font] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//
//        if(_hSize.height>51)
//        {
//            lblScrap.frame = CGRectMake( lblScrap.frame.origin.x, 45.00000/*lblWho.frame.origin.y+10*/, lblScrap.frame.size.width, _hSize.height+15);
//            [self.scrollView setContentSize:CGSizeMake(320.00,lblScrap.frame.origin.y+lblScrap.frame.size.height+10)];
//        }
        txtAreaScrapbook.text = Scrapbook;
        txtAreaScrapbook.textColor = [UIColor blackColor];
        
       // [lblSketch setText:title];
        
        if ((NSNull *) message == [NSNull null] || [message length] == 0) {
            message=@"";
        }
        if ((NSNull *) title == [NSNull null] || [title length] == 0) {
            title=@"";
        }
        if ((NSNull *) scrapbookID == [NSNull null] || [scrapbookID length] == 0) {
            scrapbookID=@"";
        }
        if ((NSNull *) Scrapbook == [NSNull null] || [Scrapbook length] == 0 || [Scrapbook isEqualToString:@"<null>"]) {
            Scrapbook=@"";
        }

        
        NSLog(@"scrapbookID...%@",scrapbookID);
        NSLog(@"message....%@",message);
        
    }
    else 
    {
//        NSString *Message = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Message"]];
//        NSString *Error = [NSString stringWithFormat:@"%@",[mainDict valueForKey:@"Error"]];
//        if ((NSNull *) Message == [NSNull null] || [Message length] == 0) {
//            Message=@"";
//        }
//        
//        if ((NSNull *) Error == [NSNull null] || [Error length] == 0) {
//            Error = @"";
//        }
        
    
       /* if([Message isEqualToString:@"No scrap added."] || [Scrapbook  length]<=0)
        {
           [txtAreaScrapbook setText:@"Click edit to start making notes"];
            //
        }
        else 
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:Message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }*/
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
        txtAreaScrapbook.text = @"Write down here...";
        txtAreaScrapbook.textColor = [UIColor lightGrayColor];
        
    }
//    isScrapBook_Edit= TRUE;
//    isWHO_Edit= FALSE;
//    isWHY_Edit= FALSE;
//    isWHAT_Edit= FALSE;
//    isSketchIdeaConceptEdit = FALSE;
}








-(void) parseJsonResultForConceptEditing:(NSString *)_respponseString
{
    /*{"Status": true, "Message":"Concept has been updated successfully."}*/
   // isEditing=NO;
    NSDictionary *dict=[_respponseString JSONValue];
    success=[[dict valueForKey:@"Status"] boolValue];
   
    if(success)
    {
//        NSString *message=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
//        
//        UIAlertView *Ai=[[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [Ai show];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = btnHome;
        self.navigationItem.rightBarButtonItem = btnConceptEdit;

        [view_having_edit_3WH setHidden:YES];
        [viewConcept setHidden:NO];
        [viewSketch setHidden:YES];
        [viewScrapbook setHidden:YES];
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
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    
    if([self connected])
    {
        [self CallWebServiceForSketchConcept];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity1 setHidden:YES];
        [activity2 setHidden:YES];
        [activity3 setHidden:YES];
        [activity4 setHidden:YES];
        
        [activity1 stopAnimating];
        [activity2 stopAnimating];
        [activity3 stopAnimating];
        [activity4 stopAnimating];
    }

   
    
    
}



-(void) parseJsonResultForScrapbookEditing:(NSString *)_respponseString
{
 /*
  {"Status": true, "Message":"Scrapbook has been updated successfully."}
  */
    
    NSDictionary *dict=[_respponseString JSONValue];
    success=[[dict valueForKey:@"Status"] boolValue];
    
    if(success)
    {
//        NSString *message=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
//        
//        UIAlertView *Ai=[[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [Ai show];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = btnHome;
        self.navigationItem.rightBarButtonItem = btnConceptEdit;

        [view_having_edit_3WH setHidden:YES];
        [viewConcept  setHidden:NO];
        [viewSketch setHidden:YES];
        [viewScrapbook setHidden:YES];
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
    
    if([self connected])
    {
         [self CallWebServiceForSketchScrapbook];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Please check your internet connectivity!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [activity1 setHidden:YES];
        [activity2 setHidden:YES];
        [activity3 setHidden:YES];
        [activity4 setHidden:YES];
        
        [activity1 stopAnimating];
        [activity2 stopAnimating];
        [activity3 stopAnimating];
        [activity4 stopAnimating];
    }

    
   
    
}

-(void) parseJsonResultForSketchDetailEditing:(NSString *)_respponseString
{
    /*
     {"Status":true,"Message":"Sketch successfully updated.","sketchID":"50"}
     */
    
    NSDictionary *dict=[_respponseString JSONValue];
    success=[[dict valueForKey:@"Status"] boolValue];
    
    if(success)
    {
//        NSString *message=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Message"]];
//        
//        UIAlertView *Ai=[[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [Ai show];
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = btnHome;
        self.navigationItem.rightBarButtonItem = btnConceptEdit;

        [view_having_edit_3WH setHidden:YES];
        [viewConcept  setHidden:NO];
        [viewSketch setHidden:YES];
        [viewScrapbook setHidden:YES];
        
        if([self connected])
        {
            [self CallWebServiceForSketchDetail];
        }
        
        
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
#pragma  mark - Textview Delegate methods
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView == txtviewTitle)
    {
      // [viewKeyButton setHidden:NO];
        
        
        
//        viewKeyButton.frame = CGRectMake(self.view.frame.size.width-60, txtviewTitle.frame.origin.y+30, viewKeyButton.frame.size.width, viewKeyButton.frame.size.height);
//        NSLog(@"viewKeyButton----%f",viewKeyButton.frame.origin.y);
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
    else if (textView == txtView_edit_WHO_WHY_WHAT)
    {
//        viewKeyButton.frame = CGRectMake(self.view.frame.size.width-60, txtView_edit_WHO_WHY_WHAT.frame.origin.y, viewKeyButton.frame.size.width, viewKeyButton.frame.size.height);
//        [viewKeyButton setHidden:NO];
        
         txtView_edit_WHO_WHY_WHAT.textColor =[UIColor blackColor];
        if([textView.text isEqualToString:@"Write down here..."])
        {
            textView.text =@"";
           
        }
        else if ([textView.text isEqualToString:@"Describe the customer or consumer SEGMENT you would be targeting with your product: Who would be using your product? Retailers, Consumers, B2B..."])
        {
            textView.text =@"";
        }
        else if ([textView.text isEqualToString:@"Describe the NEED of the customer/consumer in the segment you would be targeting. I.e. towards which need will your product/service be playing against?"])
        {
            textView.text =@"";
        }
        else if ([textView.text isEqualToString:@"What is the SOLUTION or BENEFIT you will be offering with your product/service?"])
        {
            textView.text =@"";
        }
    }
    else if (textView == txtAreaScrapbook)
    {
//        viewKeyButton.frame = CGRectMake(self.view.frame.size.width-60, viewKeyButton.frame.origin.y, viewKeyButton.frame.size.width, viewKeyButton.frame.size.height);
//        [viewKeyButton setHidden:NO];
         txtAreaScrapbook.textColor =[UIColor blackColor];
        if([textView.text isEqualToString:@"Write down here..."])
        {
            textView.text =@"";
           
        }
    }
    return YES;
}




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
    else if (textView == txtAreaScrapbook)
    {
         txtAreaScrapbook.textColor = [UIColor blackColor];
        return YES;
    }
    else if (textView == txtView_edit_WHO_WHY_WHAT)
    {
         txtView_edit_WHO_WHY_WHAT.textColor = [UIColor blackColor];
        return YES;
    }
    else{
        return YES;
    }
    
    

}

#pragma mark -
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
    [txtAreaScrapbook resignFirstResponder];
    [txtAreaIdea resignFirstResponder];
    [txtviewTitle resignFirstResponder];
    [txtView_edit_WHO_WHY_WHAT resignFirstResponder];
  //  [viewKeyButton setHidden:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if(viewConcept.hidden == FALSE)
    {
        bgScrollView_Concept.frame=CGRectMake(0,-50, bgScrollView_Concept.frame.size.width, bgScrollView_Concept.frame.size.height);
        
        [bgScrollView_Concept setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, bgScrollView_Concept.frame.size.height+220)];
        
    }
    else if (viewSketch.hidden  == FALSE)
    {
        bg_scrollview_EditSketchIdea.frame=CGRectMake(0,-50, bg_scrollview_EditSketchIdea.frame.size.width, bg_scrollview_EditSketchIdea.frame.size.height);
        [bg_scrollview_EditSketchIdea setContentSize:CGSizeMake(bg_scrollview_EditSketchIdea.frame.size.width, bg_scrollview_EditSketchIdea.frame.size.height+220)];
    }
    else if (viewScrapbook.hidden == FALSE)
    {
        bg_scrollVIew_ScrapBook.frame=CGRectMake(0,-50, bg_scrollVIew_ScrapBook.frame.size.width, bg_scrollVIew_ScrapBook.frame.size.height);
        [bg_scrollVIew_ScrapBook setContentSize:CGSizeMake(bg_scrollVIew_ScrapBook.frame.size.width, bg_scrollVIew_ScrapBook.frame.size.height+220)];
    }
    else if (view_having_edit_3WH.hidden == FALSE)
    {
        bg_scrollView_EDit3WH.frame=CGRectMake(0,-50, bg_scrollView_EDit3WH.frame.size.width, bg_scrollView_EDit3WH.frame.size.height);
        [bg_scrollView_EDit3WH setContentSize:CGSizeMake(bg_scrollView_EDit3WH.frame.size.width, bg_scrollView_EDit3WH.frame.size.height+220)];
    }
    
    [UIView commitAnimations];
   
//    NSLog(@"textViewDidBeginEditing----");
//    NSLog(@"viewConcept.hidden----%d",viewConcept.hidden);
//    NSLog(@"viewSketch.hidden----%d",viewSketch.hidden);
//    NSLog(@"viewScrapbook.hidden----%d",viewScrapbook.hidden);
//    NSLog(@"view_having_edit_3WH.hidden----%d",view_having_edit_3WH.hidden);
  
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if(viewConcept.hidden == FALSE)
    {
        bgScrollView_Concept.frame=CGRectMake(0,0, bgScrollView_Concept.frame.size.width, bgScrollView_Concept.frame.size.height);
        
        [bgScrollView_Concept setContentSize:CGSizeMake(bgScrollView_Concept.frame.size.width, btnScrapbook.frame.size.height+btnScrapbook.frame.origin.y+30)];
    }
    else if (viewSketch.hidden  == FALSE)
    {
        bg_scrollview_EditSketchIdea.frame=CGRectMake(0,0, bg_scrollview_EditSketchIdea.frame.size.width, bg_scrollview_EditSketchIdea.frame.size.height);
        
        [bg_scrollview_EditSketchIdea setContentSize:CGSizeMake(bg_scrollview_EditSketchIdea.frame.size.width, viewSketch.frame.size.height)];
    }
    else if (viewScrapbook.hidden == FALSE)
    {
        bg_scrollVIew_ScrapBook.frame=CGRectMake(0,0, bg_scrollVIew_ScrapBook.frame.size.width, bg_scrollVIew_ScrapBook.frame.size.height);
        
        [bg_scrollVIew_ScrapBook setContentSize:CGSizeMake(bg_scrollVIew_ScrapBook.frame.size.width, txtAreaScrapbook.frame.size.height+txtAreaScrapbook.frame.origin.y)];
    }
    else if (view_having_edit_3WH.hidden == FALSE)
    {
       bg_scrollView_EDit3WH.frame=CGRectMake(0,0, bg_scrollView_EDit3WH.frame.size.width, bg_scrollView_EDit3WH.frame.size.height);
        
        [bg_scrollView_EDit3WH setContentSize:CGSizeMake(bg_scrollView_EDit3WH.frame.size.width, txtView_edit_WHO_WHY_WHAT.frame.size.height+txtView_edit_WHO_WHY_WHAT.frame.origin.y)];
    }
    
    [UIView commitAnimations];
    
    //[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height)];
    
    [textView resignFirstResponder];
//    NSLog(@"textViewDidEndEditing----");
//    
//    NSLog(@"viewConcept.hidden----%d",viewConcept.hidden);
//    NSLog(@"viewSketch.hidden----%d",viewSketch.hidden);
//    NSLog(@"viewScrapbook.hidden----%d",viewScrapbook.hidden);
//    NSLog(@"view_having_edit_3WH.hidden----%d",view_having_edit_3WH.hidden);
}

/*
 
 
 */
@end
