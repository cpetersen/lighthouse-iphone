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

@synthesize project;
@synthesize ticket;
//@synthesize ticketDescription;

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
	//[self loadTicket];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadTicket {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	//[project loadTickets:new_query page:1];
	
	/****** XML WORK ******/
	lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *apiKey = [appDelegate getApiKey];

	NSString *urlString = [[NSString alloc] initWithFormat:@"%@://%@.lighthouseapp.com/projects/%i/tickets/%i.xml?_token=%@", [project getProtocol], project.accountName, project.projectID, ticket.ticketNumber, apiKey ];
	NSLog (urlString);
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
	
	// LOAD UP THE HTML
	//NSString *html = [[NSString alloc] initWithFormat:@"<html><style>body { font-size: 40pt; font-family: sans-serif; }</style><body>%@</body></html>", ticket.body];
	//[webView loadHTMLString:html baseURL:NULL];
	//ticketDescription = html;

	// HAVE THE MAIN THREAD LOAD THE UIWEBVIEW
	//[self performSelectorOnMainThread:refreshTicketDescription withObject:html waitUntilDone:YES];

	//[self performSelectorOnMainThread:@selector(refreshTicketDescription:) withObject:html waitUntilDone:YES];
	//[webView performSelectorOnMainThread:@selector(loadHTMLString:) withObject:html waitUntilDone:YES];
	//ticketDescription = html;
	[[self tableView] reloadData];
	[pool release];
}

//- (void)refreshTicketDescription:(NSString *)html {
//	[webView loadHTMLString:html baseURL:NULL];
//}

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
    return [ticket.versions count]+1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0) {
		return 5;
	} else {
		return 2;
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
			NSString *tp = [[NSString alloc] initWithFormat:@"Milestone: %@", ticket.milestone];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 3) {
			NSString *tp = [[NSString alloc] initWithFormat:@"Created By: %@", ticket.creatorUserName];
			cell.text = tp;
			[tp release];
		} else if (indexPath.row == 4) {
			NSString *tp = [[NSString alloc] initWithFormat:@"%@", ticket.url];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.text = tp;
			[tp release];
//		} else if (indexPath.row == 7) {
//			cell = tableViewCell;
//			[webView loadHTMLString:ticketDescription baseURL:NULL];
//			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
	} else {
		if(indexPath.row == 0) {
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.text = [[ticket.versions objectAtIndex:indexPath.section-1] user];
		} else if(indexPath.row == 1) {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.text = [[ticket.versions objectAtIndex:indexPath.section-1] body];
		}
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	if(indexPath.section == 0) {
		if(indexPath.row == 4) {
			WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
			webViewController.url = ticket.url;
			[[self navigationController] pushViewController:webViewController animated:YES];
			[webViewController release];
		}
	} else {
		if(indexPath.row == 1) {
			WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
			webViewController.body = [[ticket.versions objectAtIndex:indexPath.section-1] bodyHtml];
			[[self navigationController] pushViewController:webViewController animated:YES];
			[webViewController release];
		}
	}
}

//RootViewController.m
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
//	if(indexPath.row == 7) {
//		return 150;
//	} else {
//		return 40;
//	}
//}

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
// DELETING THE PROJECT CAUSES CRASHES
//  [project dealloc];
//	[ticketDescription dealloc];
    [super dealloc];
}


@end

