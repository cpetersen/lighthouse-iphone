//
//  TicketDetailViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/10/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketDetailViewController.h"
#import "TicketXMLParser.h"

@implementation TicketDetailViewController

@synthesize project, ticket;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	[NSThread detachNewThreadSelector:@selector(loadTicket) toTarget:self withObject:nil];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadTicket {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	//[project loadTickets:new_query page:1];
	
	/****** XML WORK ******/
	lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *apiKey = [appDelegate getApiKey];

	NSString *urlString = [[NSString alloc] initWithFormat:@"http://%@.lighthouseapp.com/projects/%i/tickets/%i.xml?_token=%@", project.accountName, project.projectID, ticket.ticketNumber, apiKey ];
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
		self.ticket = [parser.tickets objectAtIndex:0];
	}

	[[self tableView] reloadData];
	[pool release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0) {
		return 8;
	} else {
		return 0;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 0) {
		return ticket.ticketTitle;
	}
	return @"";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.accessoryType = UITableViewCellAccessoryNone;
	if(indexPath.section == 0) {
		if(indexPath.row == 0) {
			NSString *tp = [[NSString alloc] initWithFormat:@"Assigned To: %@", ticket.assignedUserName];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 1) {
			NSString *tp = [[NSString alloc] initWithFormat:@"State: %@", ticket.ticketState];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 2) {
			NSString *tp = [[NSString alloc] initWithFormat:@"%i", ticket.ticketPriority];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 3) {
			NSString *tp = [[NSString alloc] initWithFormat:@"Milestone: %@", ticket.milestone];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 4) {
			NSString *tp = [[NSString alloc] initWithFormat:@"Created By: %@", ticket.creatorUserName];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 5) {
			NSString *tp = [[NSString alloc] initWithFormat:@"Tags: %@", ticket.tags];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 6) {
			NSString *tp = [[NSString alloc] initWithFormat:@"URL: %@", ticket.url];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 7) {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.text = ticket.body;
		}
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	NSLog(@"didSelectRowAtIndexPath 1");
	if(indexPath.row == 6) {
		NSLog(@"didSelectRowAtIndexPath 2");
		WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
		NSLog(@"didSelectRowAtIndexPath 3");
		webViewController.url = ticket.url;
		
		NSLog(@"didSelectRowAtIndexPath 4");
		[[self navigationController] pushViewController:webViewController animated:YES];

		NSLog(@"didSelectRowAtIndexPath 5");
		[webViewController release];
		NSLog(@"didSelectRowAtIndexPath 6");
	} else if(indexPath.row == 7) {
		WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
		[[self navigationController] pushViewController:webViewController animated:YES];
		[webViewController release];
	}	
	NSLog(@"didSelectRowAtIndexPath 7");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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


- (void)dealloc {
//    [ticket dealloc];
//    [project dealloc];
    [super dealloc];
}


@end

