//
//  TicketDetailViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/10/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Ticket.h"
#import "WebViewController.h"

@interface TicketDetailViewController : UITableViewController {
	IBOutlet UITableView *tableView;
//	IBOutlet UITableViewCell *tableViewCell;
//	IBOutlet UIWebView *webView;
	
	Ticket *ticket;
	Project *project;
//	NSString *ticketDescription;
}

@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) Project *project;
//@property (nonatomic, retain) NSString *ticketDescription;

-(void)loadTicket;
//- (void)refreshTicketDescription:(NSString *)html;

@end
