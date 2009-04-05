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

	USER_FLAG = NO;
	BODY_FLAG = NO;
	BODY_HTML_FLAG = NO;
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:@"ticket"]) {
		aTicket = [[Ticket alloc] init];
		aTicket.versions = [[NSMutableArray alloc] init];
	} else if([elementName isEqualToString:@"version"]) {
		aTicketVersion = [[TicketVersion alloc] init];
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
	} else if([elementName isEqualToString:@"user-name"]) {
		USER_FLAG = YES;
	} else if([elementName isEqualToString:@"body"]) {
		BODY_FLAG = YES;
	} else if([elementName isEqualToString:@"body-html"]) {
		BODY_HTML_FLAG = YES;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(TITLE_FLAG) {
		if(aTicket.ticketTitle && aTicketVersion == NULL) {
			aTicket.ticketTitle = [aTicket.ticketTitle stringByAppendingString:string];
		} else {
			aTicket.ticketTitle = string;
		}
	} else if(NUMBER_FLAG) {
		aTicket.ticketNumber = [string intValue];
	} else if(STATE_FLAG) {
		aTicket.ticketState = string;
	} else if(PRIORITY_FLAG) {
		aTicket.ticketPriority = [string intValue];
	} else if(CREATOR_FLAG) {
		aTicket.creatorUserName = string;
	} else if(ASSIGNED_FLAG) {
		aTicket.assignedUserName = string;
	} else if(URL_FLAG) {
		aTicket.url = string;
	} else if(MILESTONE_FLAG) {
		aTicket.milestone = string;
	} else if(USER_FLAG) {
		if(aTicketVersion) {
			aTicketVersion.user = string;
		}
	} else if(BODY_FLAG) {
		if(aTicketVersion) {
			if(aTicketVersion.body) {
				aTicketVersion.body = [aTicketVersion.body stringByAppendingString:string];
			} else {
				aTicketVersion.body = string;
			}
		}
	} else if(BODY_HTML_FLAG) {
		if(aTicketVersion) {
			if(aTicketVersion.bodyHtml) {
				aTicketVersion.bodyHtml = [aTicketVersion.bodyHtml stringByAppendingString:string];
			} else {
				aTicketVersion.bodyHtml = string;
			}
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"ticket"]) {
		[tickets addObject:aTicket];		
		[aTicket release];
	} else if([elementName isEqualToString:@"version"]) {
		[aTicket.versions addObject:aTicketVersion];		
		[aTicketVersion release];
	} else if([elementName isEqualToString:@"title"]) {
		TITLE_FLAG = NO;
	} else if([elementName isEqualToString:@"number"]) {
		NUMBER_FLAG = NO;
	} else if([elementName isEqualToString:@"state"]) {
		STATE_FLAG = NO;
	} else if([elementName isEqualToString:@"priority"]) {
		PRIORITY_FLAG = NO;
	} else if([elementName isEqualToString:@"creator-name"]) {
		CREATOR_FLAG = NO;
	} else if([elementName isEqualToString:@"assigned-user-name"]) {
		ASSIGNED_FLAG = NO;
	} else if([elementName isEqualToString:@"url"]) {
		URL_FLAG = NO;
	} else if([elementName isEqualToString:@"milestone-title"]) {
		MILESTONE_FLAG = NO;
	} else if([elementName isEqualToString:@"user-name"]) {
		USER_FLAG = NO;
	} else if([elementName isEqualToString:@"body"]) {
		BODY_FLAG = NO;
	} else if([elementName isEqualToString:@"body-html"]) {
		BODY_HTML_FLAG = NO;
	}
}

- (void) dealloc {
	[tickets release];
	[super dealloc];
}

@end
