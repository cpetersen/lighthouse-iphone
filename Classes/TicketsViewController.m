//
//  TicketsViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketsViewController.h"
#import "TicketXMLParser.h"

@implementation TicketsViewController

@synthesize project, query, ticketArray;

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
	searchBar.text = self.query;
	searching = NO;
	letUserSelectRow = YES;
}

-(void)loadTickets {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSString *new_query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];

	//[project loadTickets:new_query page:1];

	/****** XML WORK ******/
	//	NSString *urlString = [[NSString alloc] initWithFormat:@"http://%@.lighthouseapp.com/projects/%i/tickets.xml?q=state%%3Aopen&_token=%@", parentName, projectID, @"b6866f005646d1b8be2bece7e500f52c9f90ba37" ];
	NSString *urlString = [[NSString alloc] initWithFormat:@"http://%@.lighthouseapp.com/projects/%i/tickets.xml?q=%@&_token=%@", project.parentName, project.projectID, new_query, @"b6866f005646d1b8be2bece7e500f52c9f90ba37" ];
	NSLog(@"LOADING TICKETS WITH URL <%@>", urlString);
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	[urlString release];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	//Initialize the delegate.
	TicketXMLParser *parser = [[TicketXMLParser alloc] initXMLParser:self];
	//Set delegate
	[xmlParser setDelegate:parser];
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(!success) {
		NSLog(@"Parsing Error!!!");
	} else {
		NSLog(@"TICKETS %i", [[self ticketArray] count]);
	}
	
	[tableView reloadData];
	[pool release];
}

- (void) searchTableView {
	[NSThread detachNewThreadSelector:@selector(loadTickets) toTarget:self withObject:nil];
}

#pragma mark Search Bar methods

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	searching = YES;
	letUserSelectRow = NO;
	
	//Add the done button.
	self.tabBarController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
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
	[searchBar resignFirstResponder];
	self.query = searchBar.text;
	[self searchTableView];
}

- (void) doneSearching_Clicked:(id)sender {
	NSLog(@"doneSearching_Clicked");
	searchBar.text = self.query;
	[searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	
	[tableView reloadData];
}

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
	return [[self ticketArray] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TicketView"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TicketView"] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if([[self ticketArray] objectAtIndex:indexPath.row]) {
		cell.text = [[self.ticketArray objectAtIndex:indexPath.row] ticketTitle];
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
