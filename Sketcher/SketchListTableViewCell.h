//
//  SketchListTableViewCell.h
//  Sketcher
//
//  Created by Sanjay on 09/08/16.
//
//

#import <UIKit/UIKit.h>

@interface SketchListTableViewCell : UITableViewCell
{
}
@property(nonatomic,strong)IBOutlet UIButton *bttn_star;
@property(nonatomic,strong) IBOutlet UILabel *lbl_sketch_idea;
@property(nonatomic,strong)IBOutlet UILabel *lbl_date;
@property(nonatomic,strong)IBOutlet UIButton *bttn_next_detail;
@property(nonatomic,strong)IBOutlet UILabel *lbl_sketch_desc;
@end
