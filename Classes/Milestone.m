//
//  Milestone.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/3/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "Milestone.h"


@implementation Milestone

@synthesize milestoneID, milestoneTitle;

- (void) dealloc {
	[milestoneTitle release];
	[super dealloc];
}

@end
