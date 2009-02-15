#import "ProjectAdminViewController.h"

@implementation ProjectAdminViewController

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
	AddProjectViewController *apvController = [[AddProjectViewController alloc] initWithNibName:@"AddProjectView" bundle:nil];
	UINavigationController *addNavigationController = [[UINavigationController alloc] initWithRootViewController:apvController];
	
	//add it to stack.
	//	[[self navigationController] pushViewController:aController animated:YES];
	[[self navigationController] presentModalViewController:addNavigationController animated:YES];
	[tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	[tableView setEditing:editing animated:YES];
	
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
- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProjectAdminView";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	//cell.font = [UIFont systemFontOfSize:14];
	if([appDelegate.projectArray objectAtIndex:indexPath.row]) {
		cell.text = [[appDelegate.projectArray objectAtIndex:indexPath.row] projectName];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else {
		cell.text = @"ROW IS NULL";
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Initialize the controller.
	ShowProjectViewController *controller = [[ShowProjectViewController alloc] initWithNibName:@"ShowProjectView" bundle:nil];
	controller.title = [NSString stringWithFormat:@"%@", [[appDelegate.projectArray objectAtIndex:indexPath.row] projectName]];
	controller.project = [appDelegate.projectArray objectAtIndex:indexPath.row];
		
	//Add the controller to the top of the present view.
	[[self navigationController] pushViewController:controller animated:YES];

	//Release the temp controller
	[controller release];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView2 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		//Get the object to delete from the array.
		Project *projectObj = [appDelegate.projectArray objectAtIndex:indexPath.row];
		[appDelegate removeProject:projectObj];
		
		//Delete the object from the table.
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}


@end
