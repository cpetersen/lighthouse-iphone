//
//  MilestonesViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "MilestonesViewController.h"


@implementation MilestonesViewController

@synthesize project;

//@synthesize viewTitle;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[NSThread detachNewThreadSelector:@selector(loadMilestones) toTarget:self withObject:nil];
	[activityIndicator setHidesWhenStopped:YES];
	empty = NO;
}

-(void)loadMilestones {
	[activityIndicator startAnimating];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	BOOL RESULT = [project loadMilestones];
	if([[project milestonesArray] count] == 0) {
		empty = YES;
	}
	
	if(!RESULT) {
		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Error Connecting"];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];		
	}
	
	[tableView reloadData];
	[pool release];
	[activityIndicator stopAnimating];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(empty) {
		return 1;
	} else {
		return [[[self project] milestonesArray] count];
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TicketView"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TicketView"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if(empty) {
		cell.text = @"NO MILESTONES";
		cell.accessoryType = UITableViewCellAccessoryNone;
	} else {
		if([[[self project] milestonesArray] objectAtIndex:indexPath.row]) {
			cell.text = [[self.project.milestonesArray objectAtIndex:indexPath.row] milestoneTitle];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		} else {
			cell.text = @"ROW IS NULL";
		}
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(!empty) {
		TicketsViewController *ticketsController = [[TicketsViewController alloc] initWithNibName:@"TicketsView" bundle:nil];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ticketsController];

		Milestone *milestone = [project.milestonesArray objectAtIndex:indexPath.row];
		
		ticketsController.title = @"Tickets";
		ticketsController.project = project;
		[ticketsController notTabbedView];
		
		NSString *query = [[NSString alloc] initWithFormat:@"state:open milestone:\"%@\"", milestone.milestoneTitle];
		ticketsController.query = query;

		[[[self tabBarController] navigationController] pushViewController:ticketsController animated:YES];

		[ticketsController release];
		[navigationController release];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [project release];
    [super dealloc];
}


@end
