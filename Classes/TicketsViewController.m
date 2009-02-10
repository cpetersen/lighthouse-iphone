//
//  TicketsViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketsViewController.h"


@implementation TicketsViewController

@synthesize project, query;

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
	[NSThread detachNewThreadSelector:@selector(loadTickets) toTarget:self withObject:nil];
	
	tableView.tableHeaderView = searchBar;
	
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;	
	searching = NO;
	letUserSelectRow = YES;
}

-(void)loadTickets {
	NSLog(@"loadTickets 1");
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"loadTickets 2");
	[project loadTickets:query page:1];
	NSLog(@"loadTickets 3");
	[tableView reloadData];
	NSLog(@"loadTickets 4");
	[pool release];
	NSLog(@"loadTickets 5");
}

- (void) searchTableView {
	NSLog(@"searchTableView 1");
	[NSThread detachNewThreadSelector:@selector(loadTickets) toTarget:self withObject:nil];
	NSLog(@"searchTableView 2");
}

#pragma mark Search Bar methods

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	NSLog(@"searchBarTextDidBeginEditing");
	searching = YES;
	letUserSelectRow = NO;
	
	//Add the done button.
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
											   target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

/*
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	NSLog(@"textDidChange");
	//Remove all objects first.
	//[copyListOfItems removeAllObjects];
	if([searchText length] > 0) {
		searching = YES;
		letUserSelectRow = YES;
		//[self searchTableView];
	} else {
		searching = NO;
		letUserSelectRow = NO;
	}
	[tableView reloadData];
}
*/
- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {	
	NSLog(@"searchBarSearchButtonClicked");
	[searchBar resignFirstResponder];
	self.query = searchBar.text;
	[self searchTableView];
}

/*
- (void) doneSearching_Clicked:(id)sender {
	NSLog(@"doneSearching_Clicked");
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	
	[tableView reloadData];
}
*/
#pragma mark Table view methods

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSectionsInTableView:(UITableView *)tableView2 {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[self project] ticketArray] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TicketView"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TicketView"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if([[[self project] ticketArray] objectAtIndex:indexPath.row]) {
		cell.text = [[self.project.ticketArray objectAtIndex:indexPath.row] ticketTitle];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else {
		cell.text = @"ROW IS NULL";
	}

    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}


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
    [query release];
    [super dealloc];
}


@end
