//
//  SketchListTableViewCell.m
//  Sketcher
//
//  Created by Sanjay on 09/08/16.
//
//

#import "SketchListTableViewCell.h"

@implementation SketchListTableViewCell
@synthesize bttn_star,lbl_date,lbl_sketch_idea,lbl_sketch_desc,bttn_next_detail;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
