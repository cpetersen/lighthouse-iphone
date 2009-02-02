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

	NSMutableArray *projectArray;
	NSMutableArray *ticketArray;
}

@property (nonatomic) NSInteger projectID;
@property (nonatomic, copy) NSString *projectName;

@property (nonatomic, retain) NSMutableArray *projectArray;
@property (nonatomic, retain) NSMutableArray *ticketArray;

//Static methods.
+ (void) loadProjects:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (void) loadSubProjects;
- (void) insertProject;
- (void) deleteProject;
- (id) initWithPrimaryKey:(NSInteger)pk;

@end
