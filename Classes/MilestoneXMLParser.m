//
//  MilestoneXMLParser.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/4/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "MilestoneXMLParser.h"


@implementation MilestoneXMLParser

@synthesize project;

- (MilestoneXMLParser *) initXMLParser:(Project *)my_project {
	[super init];
	self.project = my_project;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.project.milestonesArray = tempArray;
	[tempArray release];
	
	TITLE_FLAG = NO;
	ID_FLAG = NO;
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:@"milestone"]) {
		//Initialize the book.
		aMilestone = [[Milestone alloc] init];
	} else if([elementName isEqualToString:@"title"]) {
		TITLE_FLAG = YES;
	} else if([elementName isEqualToString:@"id"]) {
		ID_FLAG = YES;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(TITLE_FLAG) {
		aMilestone.milestoneTitle = string;
		TITLE_FLAG = NO;
	} else if(ID_FLAG) {
		aMilestone.milestoneID = [string intValue];
		ID_FLAG = NO;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"milestone"]) {
		[self.project.milestonesArray addObject:aMilestone];
		[aMilestone release];
	}
}

- (void) dealloc {
	[project release];
	[super dealloc];
}

@end

