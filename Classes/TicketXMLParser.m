//
//  NSTicketXMLParser.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketXMLParser.h"


@implementation TicketXMLParser

- (TicketXMLParser *) initXMLParser {
	[super init];
	appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];	
	return self;
}

@end
