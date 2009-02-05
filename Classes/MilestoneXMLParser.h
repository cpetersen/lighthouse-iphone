//
//  MilestoneXMLParser.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/4/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Milestone.h"
#import "Project.h"

@interface MilestoneXMLParser : NSObject {
	Project *project;
	Milestone *aMilestone;
	NSMutableString *currentElementValue;
	BOOL TITLE_FLAG;
	BOOL ID_FLAG;
}

@property (nonatomic, retain) Project *project;

- (MilestoneXMLParser *) initXMLParser:(Project *)my_project;

@end
