//
//  RegisterViewController.h
//  Sketcher
//
//  Created by Sanjay on 19/08/16.
//
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIView *view_Having_registr_filds;
    IBOutlet UIView *view_having_back_bttn;
    IBOutlet UIScrollView *bg_scrollView;
    IBOutlet UITextField *txt_fld_email;
    IBOutlet UITextField *txt_fld_full_name;
    IBOutlet UITextField *txt_fld_username;
    IBOutlet UITextField *txt_fld_password;
    IBOutlet UITextField *txt_fld_retype_password;
    IBOutlet UITextField *txt_fld_country;
    IBOutlet UIButton *bttn_create_account;
    IBOutlet UITableView *tbl_view_country_list;
    IBOutlet UIScrollView *parent_Scrollview;
    
    IBOutlet UIActivityIndicatorView *activity;
    
    IBOutlet UILabel *lbl_error_username;
    IBOutlet UILabel *lbl_error_email;
    IBOutlet UILabel *lbl_success;
    
}
@end
