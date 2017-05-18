

#import "RearViewController.h"
#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "AppFirstViewController.h"
#import "AppSecondViewController.h"

@interface RearViewController()
{
    NSInteger _presentedRow;
}

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height-1,self.navigationController.navigationBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:[UIColor whiteColor]];
    [navBorder setOpaque:YES];
    [self.navigationController.navigationBar addSubview:navBorder];
    self.rearTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.translucent = NO;
    

    UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    
    NSString *userName =[[NSUserDefaults standardUserDefaults] valueForKey:@"username_val"];
    
    UILabel *lbl_username =[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 110, 30)];
    if(userName.length == 0 || userName == (id)[NSNull null])
    {
        lbl_username.text = @"Name of User";
    }
    else
    {
        lbl_username.text = userName;
    }
    
    lbl_username.textColor = [UIColor whiteColor];
    lbl_username.font = [UIFont boldSystemFontOfSize:16.0];
    
    
    
    
    UIButton *bttnLogout =[[UIButton alloc] initWithFrame:CGRectMake(lbl_username.frame.size.width+30, 5, 120, 30)];
    [bttnLogout setTitle:@"(Logout)" forState:UIControlStateNormal];
    [bttnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bttnLogout.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [bttnLogout addTarget:self action:@selector(logoutApp) forControlEvents:UIControlEventTouchUpInside];
   
    
    [navBarView addSubview:lbl_username];
    [navBarView addSubview:bttnLogout];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navBarView];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
   
    
    
    
//    }
}
-(void)logoutApp
{
    NSLog(@"logout app rear view ---");
   LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
   UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
    nav.navigationBarHidden = YES;
  
    [UIView transitionWithView:[[UIApplication sharedApplication] keyWindow]
                      duration:0.5
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
                    }
                    completion:nil];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = YES;
}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	NSInteger row = indexPath.row;
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
    NSString *text = nil;
	if (row == 0)
	{
		text = @"Home";
	}
	else if (row == 1)
	{
        text = @"About";
	}
    
    cell.textLabel.text = NSLocalizedString( text, nil );
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
	cell.backgroundColor = [UIColor darkGrayColor];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if ( row == _presentedRow )
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    else if (row == 2)
    {
        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
        return;
    }
   
    // otherwise we'll create a new frontViewController and push it with animation

    UIViewController *newFrontController = nil;

    if (row == 0)
    {
        AppFirstViewController *frontViewController = [[AppFirstViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    else if (row == 1)
    {
        AppSecondViewController *mapViewController = [[AppSecondViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    }
    
   
    
    [revealController pushFrontViewController:newFrontController animated:YES];
    
    _presentedRow = row;  // <- store the presented row
}



@end