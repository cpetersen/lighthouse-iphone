//
//  Ticket.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/27/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "Ticket.h"


@implementation Ticket

@synthesize ticketNumber, ticketTitle, ticketState, ticketPriority, tags, url, milestone, creatorUserName, assignedUserName;

- (void) dealloc {
	[ticketTitle release];
	[ticketState release];
	[assignedUserName release];
	[creatorUserName release];
	[url release];
	[milestone release];
	[tags release];
	[super dealloc];
}

@end
