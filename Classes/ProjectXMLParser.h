//
//  NSProjectXMLParser.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lighthouseAppDelegate.h"
#import "Project.h"

@interface ProjectXMLParser : NSObject {
	Project *project;
	Project *aProject;
	NSMutableString *currentElementValue;
	BOOL NAME_FLAG;
	BOOL ID_FLAG;
	BOOL ERROR_FLAG;
}

@property (nonatomic, retain) Project *project;

- (ProjectXMLParser *) initXMLParser:(Project *)my_project;

@end
