//
//  Classes.m
//  Sketcher
//
//  Created by Sanjay Shekhawat on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Classes.h"

@implementation SketchItem

@synthesize sketchId,sketchTitle,sketchDescrition,sketchDate,is_starred;

-(id)init
{
    if (self == [super init]) 
    {
        self.sketchId=@"";
        self.sketchTitle=@"";
        self.sketchDescrition = @"";
        self.sketchDate = @"";
        self.is_starred = @"";
        
    }
    return self;
}

-(void)dealloc
{
    
  
}


@end
