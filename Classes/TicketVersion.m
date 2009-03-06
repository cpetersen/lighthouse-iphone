//
//  TicketVersion.m
//  lighthouse
//
//  Created by Christopher Petersen on 3/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketVersion.h"


@implementation TicketVersion

@synthesize user;
@synthesize body;
@synthesize bodyHtml;

- (void) dealloc {
	[user release];
	[body release];
	[bodyHtml release];
	[super dealloc];
}

@end
