//
//  Project.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/25/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Project : NSObject {
	NSInteger projectID;
	NSString *projectName;
	NSString *accountName;
	NSInteger secure;

	NSString *loadErrorMessage;
	NSMutableArray *projectArray;
	NSMutableArray *milestonesArray;
}

@property (nonatomic) NSInteger projectID;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) NSString *loadErrorMessage;
@property (nonatomic) NSInteger secure;

@property (nonatomic, retain) NSMutableArray *projectArray;
@property (nonatomic, retain) NSMutableArray *milestonesArray;

//Static methods.
+ (void) loadProjects:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (BOOL) loadMilestones;

- (BOOL) loadSubProjects;
- (void) insertProject;
- (void) updateProject;
- (void) deleteProject;
- (id) initWithPrimaryKey:(NSInteger)pk;
- (NSString *) getProtocol;

@end
