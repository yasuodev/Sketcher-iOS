//
//  CustomTabBarControllerViewController.m
//  Sketcher
//
//  Created by SANJAY on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBarControllerViewController.h"

@implementation CustomUITabBarController

@synthesize tabBar1;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    NSLog(@"11");
    
    CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, 40);
    
    UIView *v = [[UIView alloc] initWithFrame:frame];
    
    [v setBackgroundColor:[[UIColor alloc] initWithRed:1.0
                                                 green:0.0
                                                  blue:0.0
                                                 alpha:1.0]];
    
    [tabBar1 insertSubview:v atIndex:0];
    
    
    UIView *v1 = [[UIView alloc] initWithFrame:frame];
    
    [v1 setBackgroundColor:[[UIColor alloc] initWithRed:0.0
                                                 green:1.0
                                                  blue:0.0
                                                 alpha:1.0]];
    
    [tabBar1 insertSubview:v1 atIndex:0];
    //[v release];
}

@end

