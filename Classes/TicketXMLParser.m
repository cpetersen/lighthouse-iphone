//
//  NSTicketXMLParser.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketXMLParser.h"

@implementation TicketXMLParser

@synthesize tickets;

- (TicketXMLParser *) initXMLParser {
	[super init];

	tickets = [[NSMutableArray alloc] init];
	
	TITLE_FLAG = NO;
	NUMBER_FLAG = NO;
	STATE_FLAG = NO;
	PRIORITY_FLAG = NO;
	ASSIGNED_FLAG = NO;
	CREATOR_FLAG = NO;
	URL_FLAG = NO;
	MILESTONE_FLAG = NO;
	BODY_FLAG = NO;
	
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
	} else if([elementName isEqualToString:@"creator-name"]) {
		CREATOR_FLAG = YES;
	} else if([elementName isEqualToString:@"assigned-user-name"]) {
		ASSIGNED_FLAG = YES;
	} else if([elementName isEqualToString:@"url"]) {
		URL_FLAG = YES;
	} else if([elementName isEqualToString:@"milestone-title"]) {
		MILESTONE_FLAG = YES;
	} else if([elementName isEqualToString:@"body"]) {
		NSLog(@"BODY START!");
		BODY_FLAG = YES;
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
	} else if(CREATOR_FLAG) {
		aTicket.creatorUserName = string;
		CREATOR_FLAG = NO;
	} else if(ASSIGNED_FLAG) {
		aTicket.assignedUserName = string;
		ASSIGNED_FLAG = NO;
	} else if(URL_FLAG) {
		aTicket.url = string;
		URL_FLAG = NO;
	} else if(MILESTONE_FLAG) {
		aTicket.milestone = string;
		MILESTONE_FLAG = NO;
	} else if(BODY_FLAG) {
		NSLog(@"BODY [%@]", string);
		aTicket.body = string;
		BODY_FLAG = NO;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"ticket"]) {
		[tickets addObject:aTicket];		
		[aTicket release];
	}
}

- (void) dealloc {
	[tickets release];
	[super dealloc];
}

@end
