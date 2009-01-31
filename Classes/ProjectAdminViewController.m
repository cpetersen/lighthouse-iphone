#import "ProjectAdminViewController.h"

@implementation ProjectAdminViewController

@synthesize spvController;
@synthesize project;

- (void)viewDidLoad {
    [super viewDidLoad];

	appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	//self.navigationItem.leftBarButtonItem = self.editButtonItem;

	//Adding a bar button item to the right side.
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
											  target:self action:@selector(addClicked:)];
}


-(void)addClicked:(id)sender {
	//Load the view
	if(apvController == nil) {
		apvController = [[AddProjectViewController alloc] initWithNibName:@"AddProjectView" bundle:nil];
	}
	if(addNavigationController == nil) {
		addNavigationController = [[UINavigationController alloc] initWithRootViewController:apvController];
	}
	
	//add it to stack.
	//	[[self navigationController] pushViewController:aController animated:YES];
	[[self navigationController] presentModalViewController:addNavigationController animated:YES];
	[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [appDelegate.projectArray count];	
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
	if([appDelegate.projectArray objectAtIndex:indexPath.row]) {
		cell.text = [[appDelegate.projectArray objectAtIndex:indexPath.row] projectName];
	} else {
		cell.text = @"ROW IS NULL";
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Check to see if the controller is nil or not.
	if(spvController == nil) {
		//Initialize the controller.
		ShowProjectViewController *controller = [[ShowProjectViewController alloc] initWithNibName:@"ShowProjectView" bundle:nil];
		controller.title = [NSString stringWithFormat:@"%@", [[appDelegate.projectArray objectAtIndex:indexPath.row] projectName]];
		controller.project = [appDelegate.projectArray objectAtIndex:indexPath.row];
		
		//Set the controller to our variable.
		self.spvController = controller;
		
		//Release the temp controller
		[controller release];
	}
	
	//Add the controller to the top of the present view.
	[[self navigationController] pushViewController:spvController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		//Get the object to delete from the array.
		Project *projectObj = [appDelegate.projectArray objectAtIndex:indexPath.row];
		[appDelegate removeProject:projectObj];
		
		//Delete the object from the table.
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}


@end
