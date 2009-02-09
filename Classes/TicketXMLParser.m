//
//  NSTicketXMLParser.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "TicketXMLParser.h"


@implementation TicketXMLParser

@synthesize project;

- (TicketXMLParser *) initXMLParser:(Project *)my_project {
	[super init];
	self.project = my_project;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.project.ticketArray = tempArray;
	[tempArray release];
	
	TITLE_FLAG = NO;
	NUMBER_FLAG = NO;
	
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
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(TITLE_FLAG) {
		aTicket.ticketTitle = string;
		TITLE_FLAG = NO;
	} else if(NUMBER_FLAG) {
		aTicket.ticketNumber = [string intValue];
		NUMBER_FLAG = NO;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"ticket"]) {
		[self.project.ticketArray addObject:aTicket];		
		[aTicket release];
	}
}

- (void) dealloc {
	[project release];
	[super dealloc];
}

@end
