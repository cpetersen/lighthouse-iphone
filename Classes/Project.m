//
//  Project.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/25/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//
// sqlite> create table "projects" ("id" integer primary key autoincrement not null, "name" varchar);
// sqlite> insert into projects (name) values ("assaydepot");
// sqlite> insert into projects (name) values ("rails");
// sqlite> insert into projects (name) values ("merb");
// sqlite> create table "properties" ("id" integer primary key autoincrement not null, "name" varchar, "value" varchar);

#import "lighthouseAppDelegate.h"
#import "Project.h"

static sqlite3 *database = nil;
static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *deleteStmt = nil;

@implementation Project

@synthesize projectID, projectName;
@synthesize projectArray;
@synthesize ticketArray;

+ (void) loadProjects:(NSString *)dbPath {
	lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select id, name from projects";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSInteger projectID = sqlite3_column_int(selectstmt, 0);
				Project *projectObj = [[Project alloc] initWithPrimaryKey:projectID];
				projectObj.projectName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				
//				[projectObj loadSubProjects];
				[appDelegate.projectArray addObject:projectObj];
				[projectObj release];
			}
		}
	} else {
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
	}
}

+ (void) finalizeStatements {	
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(insertStmt) sqlite3_finalize(insertStmt);
}

- (void) loadSubProjects {	
	/****** XML WORK ******/
	NSString *urlString = [[NSString alloc] initWithFormat:@"http://%@.lighthouseapp.com/projects.xml?_token=%@", projectName, @"b6866f005646d1b8be2bece7e500f52c9f90ba37" ];
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	[urlString release];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	//Initialize the delegate.
	ProjectXMLParser *parser = [[ProjectXMLParser alloc] initXMLParser:self];
	//Set delegate
	[xmlParser setDelegate:parser];
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(!success) {
		NSLog(@"Parsing Error!!!");
	}
	
//	Project *projectObj = [[Project alloc] initWithPrimaryKey:18618];
//	projectObj.projectName = @"assayrepo";
//	[self.projectArray addObject:projectObj];
//	[projectObj release];
}

- (void) insertProject {
	if(insertStmt == nil) {
		const char *sql = "insert into projects (name) values (?)";
		if(sqlite3_prepare_v2(database, sql, -1, &insertStmt, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}
	}
	
	sqlite3_bind_text(insertStmt, 1, [projectName UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(insertStmt)) {
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	} else {
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		projectID = sqlite3_last_insert_rowid(database);
	}
	//Reset the add statement.
	sqlite3_reset(insertStmt);
}

- (void) deleteProject {
	if(deleteStmt == nil) {
		const char *sql = "delete from projects where id = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1, projectID);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) {
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	}
	sqlite3_reset(deleteStmt);
}

- (id) initWithPrimaryKey:(NSInteger) pk {
	[super init];
	projectID = pk;
	return self;
}

- (void) dealloc {
	[projectName release];
	[projectArray release];
	[ticketArray release];
	[super dealloc];
}

@end
