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

- (void) notTabbedView {
	tabbedView = NO;
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		tabbedView = YES;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[activityIndicator setHidesWhenStopped:YES];

    [super viewDidLoad];
	[NSThread detachNewThreadSelector:@selector(loadTickets) toTarget:self withObject:nil];
	
	tableView.tableHeaderView = searchBar;
	
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchBar.text = self.query;
	searching = NO;
	letUserSelectRow = YES;
	empty = NO;
	currentPage = 1;
}

-(void)loadTickets {
	[activityIndicator startAnimating];

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSString *new_query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	NSString *new_query2 = [new_query stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];

	//[project loadTickets:new_query page:1];

	/****** XML WORK ******/
	lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *apiKey = [appDelegate getApiKey];

	NSString *urlString = [[NSString alloc] initWithFormat:@"http://%@.lighthouseapp.com/projects/%i/tickets.xml?q=%@&_token=%@&page=%i", project.accountName, project.projectID, new_query2, apiKey, currentPage ];
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	[urlString release];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	//Initialize the delegate.
	TicketXMLParser *parser = [[TicketXMLParser alloc] initXMLParser];
	//Set delegate
	[xmlParser setDelegate:parser];
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(!success) {
		NSLog(@"Parsing Error!!!");

		UIAlertView* dialog = [[[UIAlertView alloc] init] retain];
		[dialog setDelegate:self];
		[dialog setTitle:@"Error Connecting"];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];		
	} else {
		if(ticketArray == NULL) {
			ticketArray = [[NSMutableArray alloc] init];
		}
		for(int i=0; i<[parser.tickets count]; i++) {
			[ticketArray addObject:[parser.tickets objectAtIndex:i]];
		}
		if([ticketArray count] == 0) {
			empty = YES;
		}
	}
	
	[tableView reloadData];
	[pool release];

	[activityIndicator stopAnimating];
}

- (void) searchTableView {
	[NSThread detachNewThreadSelector:@selector(loadTickets) toTarget:self withObject:nil];
}

#pragma mark Search Bar methods

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	searching = YES;
	letUserSelectRow = NO;
	
	//Add the done button.
	if(tabbedView == YES) {
		self.tabBarController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
																	initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																	target:self action:@selector(doneSearching_Clicked:)] autorelease
																   ];
	} else {
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
												   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												   target:self action:@selector(doneSearching_Clicked:)] autorelease
												  ];
	}
}

/*
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
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

	if(tabbedView) {
		self.tabBarController.navigationItem.rightBarButtonItem = nil;
	} else {
		self.navigationItem.rightBarButtonItem = nil;
	}
	
	[self searchTableView];
}

- (void) doneSearching_Clicked:(id)sender {
	searchBar.text = self.query;
	[searchBar resignFirstResponder];

	letUserSelectRow = YES;
	searching = NO;
	if(tabbedView) {
		self.tabBarController.navigationItem.rightBarButtonItem = nil;
	} else {
		self.navigationItem.rightBarButtonItem = nil;
	}

	[tableView reloadData];
}

#pragma mark Table view methods

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(letUserSelectRow) {
		return indexPath;
	} else {
		return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSectionsInTableView:(UITableView *)tableView2 {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(empty) {
		return 1;
	} else {
		return [[self ticketArray] count] + 1;
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
		cell.text = @"NO TICKETS";
		cell.accessoryType = UITableViewCellAccessoryNone;
	} else {
		if(indexPath.row == [[self ticketArray] count]) {
			cell.text = @"More Tickets";
			cell.accessoryType = UITableViewCellAccessoryNone;
		} else if([[self ticketArray] objectAtIndex:indexPath.row]) {
			cell.text = [[self.ticketArray objectAtIndex:indexPath.row] ticketTitle];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		} else {
			cell.text = @"ROW IS NULL";
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(!empty) {
		if(indexPath.row == [[self ticketArray] count]) {
			currentPage++;
			[NSThread detachNewThreadSelector:@selector(loadTickets) toTarget:self withObject:nil];
		} else {
			TicketDetailViewController *tdController = [[TicketDetailViewController alloc] initWithNibName:@"TicketDetailView" bundle:nil];
			Ticket *ticket = [self.ticketArray objectAtIndex:indexPath.row];
			tdController.project = project;
			tdController.ticket = ticket;
			tdController.title = [[NSString alloc] initWithFormat:@"Ticket %i", ticket.ticketNumber];
			if(tabbedView) {
				[[self.tabBarController navigationController] pushViewController:tdController animated:YES];
			} else {
				[self.navigationController pushViewController:tdController animated:YES];
			}
			[tdController release];
		}
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
    [ticketArray release];
    [project release];
    [query release];
    [super dealloc];
}


@end
