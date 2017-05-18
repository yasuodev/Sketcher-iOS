//
//  Classes.h
//  Sketcher
//
//  Created by Sanjay Shekhawat on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SketchItem : NSObject
{
    NSString *sketchId,*sketchTitle;
}

@property(nonatomic,strong)NSString  *sketchId;
@property(nonatomic,strong)NSString  *sketchTitle;
@property(nonatomic,strong)NSString  *sketchDescrition;
@property(nonatomic,strong)NSString  *sketchDate;
@property(nonatomic,strong)NSString  *is_starred;

@end
