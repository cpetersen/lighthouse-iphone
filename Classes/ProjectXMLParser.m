//
//  NSProjectXMLParser.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "ProjectXMLParser.h"

@implementation ProjectXMLParser

@synthesize project;

- (ProjectXMLParser *) initXMLParser:(Project *)my_project {
	[super init];
	self.project = my_project;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.project.projectArray = tempArray;
	[tempArray release];
	
	NAME_FLAG = NO;
	ID_FLAG = NO;
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:@"project"]) {
		//Initialize the book.
		aProject = [[Project alloc] init];
	} else if([elementName isEqualToString:@"name"]) {
		NAME_FLAG = YES;
	} else if([elementName isEqualToString:@"id"]) {
		ID_FLAG = YES;
	} else if([elementName isEqualToString:@"error"]) {
		ERROR_FLAG = YES;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(NAME_FLAG) {
		aProject.projectName = string;
	} else if(ID_FLAG) {
		aProject.projectID = [string intValue];
	} else if(ERROR_FLAG) {
		project.loadErrorMessage = string;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"project"]) {
		aProject.accountName = project.projectName;
		aProject.secure = project.secure;
		[self.project.projectArray addObject:aProject];		
		[aProject release];
	} else if(NAME_FLAG) {
		NAME_FLAG = NO;
	} else if(ID_FLAG) {
		ID_FLAG = NO;
	} else if(ERROR_FLAG) {
		if(project.loadErrorMessage == NULL) {
			project.loadErrorMessage = @"You don't have access to this project";
		}
		ERROR_FLAG = NO;
	}
}

- (void) dealloc {
	[project release];
	[super dealloc];
}

@end
