//
//  Ticket.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/27/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "Ticket.h"


@implementation Ticket

@synthesize ticketID, ticketName, ticketDescription;

- (void) dealloc {
	[ticketName release];
	[ticketDescription release];
	[super dealloc];
}

@end
