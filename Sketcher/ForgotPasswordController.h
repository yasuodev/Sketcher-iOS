//
//  ForgotPasswordController.h
//  Sketcher
//
//  Created by Sanjay on 19/08/16.
//
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordController : UIViewController<NSXMLParserDelegate,UITextFieldDelegate>
{
    IBOutlet UIView *view_Having_email;
    IBOutlet UIView *view_Having_bttn;
    IBOutlet UITextField *txt_fld_email;
    IBOutlet UIButton *bttn_Reset;
    IBOutlet UIButton *bttn_back_to_login;
    IBOutlet UIScrollView *bg_scrollView;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UILabel *lbl_success;
    IBOutlet UILabel *lbl_error;
}
-(IBAction)bttn_reset_password_pressed:(id)sender;
-(IBAction)bttn_back_to_login_screen_pressed:(id)sender;

@end
