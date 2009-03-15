//
//  LighthouseAppDelegate.m
//  Lighthouse
//
//  Created by Christopher Petersen on 1/20/09.
//  Copyright Assay Depot 2009. All rights reserved.
//

#import "lighthouseAppDelegate.h"
#import "RootViewController.h"
#import "Project.h"

static sqlite3 *database = nil;

@implementation lighthouseAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize projectArray;
@synthesize reloadProjects;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	reloadProjects = NO;
	//Copy database to the user's phone if needed.
	/****** DATABASE WORK ******/
	[self copyDatabaseIfNeeded];

	/****** UI WORK ******/
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}

- (void)reloadProjectArray {
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.projectArray = tempArray;
	[tempArray release];
	
	//Once the db is copied, get the initial data to display on the screen.
	[Project loadProjects:[self getDBPath]];	
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	[Project finalizeStatements];
}

- (NSString *) getApiKey {
	return [self getProperty:@"api_key"];
}

- (void) setApiKey:(NSString *)apiKey {
	[self setProperty:@"api_key" value:apiKey];
}

- (NSString *) getProperty:(NSString *)name {
	NSString *value;
	value = @"";
	if (sqlite3_open([self.getDBPath UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select value from properties where name = ?";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			sqlite3_bind_text(selectstmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
			}
		}
	} else {
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
	}
	return value;
}

- (void) setProperty:(NSString *)name value:(NSString *)newValue {
	if (sqlite3_open([self.getDBPath UTF8String], &database) == SQLITE_OK) {
		const char *sql_delete = "delete from properties where name = ?";
		const char *sql_insert = "insert into properties (name, value) values (?,?)";
		sqlite3_stmt *deletestmt;
		sqlite3_stmt *insertstmt;
		if(sqlite3_prepare_v2(database, sql_delete, -1, &deletestmt, NULL) == SQLITE_OK) {
			sqlite3_bind_text(deletestmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			if (SQLITE_DONE != sqlite3_step(deletestmt)) {
				NSLog(@"Error while executing delete statement. '%s'", sqlite3_errmsg(database));
			}
		}
		if(sqlite3_prepare_v2(database, sql_insert, -1, &insertstmt, NULL) == SQLITE_OK) {
			sqlite3_bind_text(insertstmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(insertstmt, 2, [newValue UTF8String], -1, SQLITE_TRANSIENT);
			if(sqlite3_step(insertstmt) == SQLITE_ROW) {
				NSLog(@"Error while executing insert statement. '%s'", sqlite3_errmsg(database));
			}
		}
	} else {
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
	}
}

- (void) addProject:(Project *)projectObj {
	// Add it to the database.
	[projectObj insertProject];
	// Reload the project array.
	[self reloadProjectArray];
	// Add it to the array.
	//[projectObj retain];
	//[projectArray addObject:projectObj];
}

- (void) removeProject:(Project *)projectObj {	
	// Delete it from the database.
	[projectObj deleteProject];
	// Remove it from the array.
	[projectArray removeObject:projectObj];
}

- (NSString *) getDBPath {
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"lighthouse.1.sqlite"];
}

- (void) copyDatabaseIfNeeded {	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"lighthouse.1.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (void)dealloc {
	[projectArray release];
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
