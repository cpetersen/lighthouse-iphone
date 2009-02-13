//
//  NSTicketXMLParser.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"
#import "TicketsViewController.h"
#import "lighthouseAppDelegate.h"

@interface TicketXMLParser : NSObject {
	TicketsViewController *ticketView;
	Ticket *aTicket;
	NSMutableString *currentElementValue;
	BOOL TITLE_FLAG;
	BOOL NUMBER_FLAG;
	BOOL STATE_FLAG;
	BOOL PRIORITY_FLAG;
}

@property (nonatomic, retain) TicketsViewController *ticketView;

- (TicketXMLParser *) initXMLParser:(TicketsViewController *)myView;

@end
