//
//  Ticket.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/27/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "Ticket.h"


@implementation Ticket

@synthesize ticketNumber;
@synthesize ticketTitle;
@synthesize ticketState;
@synthesize ticketPriority;
@synthesize url;
@synthesize milestone;
@synthesize creatorUserName;
@synthesize assignedUserName;
//@synthesize body;
@synthesize versions;
@synthesize tags;

- (void) dealloc {
	[ticketTitle release];
	[ticketState release];
	[assignedUserName release];
	[creatorUserName release];
	[url release];
	[milestone release];
//	[body release];
	[versions release];
	[tags release];
	[super dealloc];
}

@end
