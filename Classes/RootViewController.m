//
//  RootViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/20/09.
//  Copyright Assay Depot 2009. All rights reserved.
//
// Database config

#import "RootViewController.h"

@implementation RootViewController

@synthesize tvController;

- (void)viewDidLoad {
    [super viewDidLoad];

	appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	/*** XML PARSING STUFF
	NSURL *url;
	NSXMLParser *xmlParser;
	
	url = [[NSURL alloc] initWithString:@"http://assaydepot.lighthouseapp.com/projects.xml?_token=b6866f005646d1b8be2bece7e500f52c9f90ba37"];
	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	[xmlParser setDelegate:self];

	success = [xmlParser parse];

	[xmlParser release];
	[url release];
	*/

	//Adding a bar button item to the right side.
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithTitle:@"Accounts" style:UIBarButtonItemStyleBordered
											  target:self action:@selector(adminClicked:)];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] 
											initWithTitle:@"API Token" style:UIBarButtonItemStyleBordered
											target:self action:@selector(tokenClicked:)];
}
-(void)adminClicked:(id)sender {
	//Load the view
	if(pavController == nil) {
		pavController = [[ProjectAdminViewController alloc] initWithNibName:@"ProjectAdminView" bundle:nil];
	}
	//Set the view title
	pavController.title = @"Accounts";

//	if(addNavigationController == nil) {
//		addNavigationController = [[UINavigationController alloc] initWithRootViewController:pavController];
//	}
	
	//add it to stack.
	[[self navigationController] pushViewController:pavController animated:YES];
	//[[self navigationController] presentModalViewController:addNavigationController animated:YES];
	//[self.tableView reloadData];
}
-(void)tokenClicked:(id)sender {
	//Load the view
	ApiKeyViewController *akvController = [[ApiKeyViewController alloc] initWithNibName:@"ApiKeyView" bundle:nil];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:akvController];

	//Set the view title
	akvController.title = @"Projects";
		
	//add it to stack.
	[[self navigationController] presentModalViewController:navigationController animated:YES];

	[navigationController release];
	[akvController release];
}

/*
-(void)addClicked:(id)sender {
	//Load the view
	if(apvController == nil) {
		apvController = [[AddProjectViewController alloc] initWithNibName:@"AddProjectView" bundle:nil];
	}
	if(addNavigationController == nil) {
		addNavigationController = [[UINavigationController alloc] initWithRootViewController:apvController];
	}
	//Set the view title
	apvController.title = @"Add Project";
	
	//add it to stack.
//	[[self navigationController] pushViewController:aController animated:YES];
	[[self navigationController] presentModalViewController:addNavigationController animated:YES];
	[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}
*/
/*
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:YES];
	
	//Do not let the user add if the app is in edit mode.
	if(editing) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	} else {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
} 
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [appDelegate.projectArray count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[appDelegate.projectArray objectAtIndex:section] projectArray] count];	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return  [[appDelegate.projectArray objectAtIndex:section] projectName];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	//cell.font = [UIFont systemFontOfSize:14];
	if([appDelegate.projectArray objectAtIndex:indexPath.section]) {
		if([[[appDelegate.projectArray objectAtIndex:indexPath.section] projectArray] objectAtIndex:indexPath.row]) {
			cell.text = [[appDelegate.projectArray objectAtIndex:indexPath.row] projectName];
		} else {
			cell.text = @"ROW IS NULL";
		}
	} else {
		cell.text = @"SECTION IS NULL";
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Check to see if the controller is nil or not.
	if(tvController == nil) {
		//Initialize the controller.
		TicketsViewController *aController = [[TicketsViewController alloc] initWithNibName:@"TicketsView" bundle:nil];
		aController.title = [NSString stringWithFormat:@"%@", [[appDelegate.projectArray objectAtIndex:indexPath.row] projectName]];

		//Set the controller to our variable.
		self.tvController = aController;
		
		//Release the temp controller
		[aController release];
	}

	//Add the controller to the top of the present view.
	[[self navigationController] pushViewController:tvController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void)dealloc {
	[pavController release];
	[addNavigationController release];
	[tvController release];
    [super dealloc];
}

@end

