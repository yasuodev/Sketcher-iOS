//
//  ListSketches.m
//  Sketcher
//
//  Created by Sanjay Shekhawat on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListSketches.h"

@interface ListSketches ()

@end

@implementation ListSketches

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *viewButtonR = [[UIView alloc] initWithFrame:CGRectMake(0,0 , 58, 30)];
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 58, 30)];
    [btnAdd setImage:[UIImage imageNamed:@"medical.png"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(AddbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [viewButtonR addSubview:btnAdd];
    
    
    
    UIBarButtonItem *barButtonR = [[UIBarButtonItem alloc] initWithCustomView:viewButtonR];
    self.navigationItem.rightBarButtonItem = barButtonR;
    [super viewDidLoad];

    
    list=[[NSMutableArray alloc]initWithObjects:@"ABC",@"XYZ",@"MNW", nil];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    
    NSString *cellValue = [list objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    
    return cell;
}

@end
