//
//  NSTicketXMLParser.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketXMLParser.h"

@implementation TicketXMLParser

@synthesize ticketView;

- (TicketXMLParser *) initXMLParser:(TicketsViewController *)myView {
	[super init];
	self.ticketView = myView;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.ticketView.ticketArray = tempArray;
	[tempArray release];
	
	TITLE_FLAG = NO;
	NUMBER_FLAG = NO;
	STATE_FLAG = NO;
	PRIORITY_FLAG = NO;
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:@"ticket"]) {
		//Initialize the book.
		aTicket = [[Ticket alloc] init];
	} else if([elementName isEqualToString:@"title"]) {
		TITLE_FLAG = YES;
	} else if([elementName isEqualToString:@"number"]) {
		NUMBER_FLAG = YES;
	} else if([elementName isEqualToString:@"state"]) {
		STATE_FLAG = YES;
	} else if([elementName isEqualToString:@"priority"]) {
		PRIORITY_FLAG = YES;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(TITLE_FLAG) {
		aTicket.ticketTitle = string;
		TITLE_FLAG = NO;
	} else if(NUMBER_FLAG) {
		aTicket.ticketNumber = [string intValue];
		NUMBER_FLAG = NO;
	} else if(STATE_FLAG) {
		aTicket.ticketState = string;
		STATE_FLAG = NO;
	} else if(PRIORITY_FLAG) {
		aTicket.ticketPriority = [string intValue];
		PRIORITY_FLAG = NO;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"ticket"]) {
		[self.ticketView.ticketArray addObject:aTicket];		
		[aTicket release];
	}
}

- (void) dealloc {
	[ticketView release];
	[super dealloc];
}

@end
