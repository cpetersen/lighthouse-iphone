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

@interface TicketDetailViewController : UITableViewController {
	Ticket *ticket;
	Project *project;
}

@property (nonatomic, retain) Ticket *ticket;
@property (nonatomic, retain) Project *project;

@end
