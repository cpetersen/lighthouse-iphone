//
//  LighthouseAppDelegate.h
//  Lighthouse
//
//  Created by Christopher Petersen on 1/20/09.
//  Copyright Assay Depot 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectXMLParser.h"
#import "Project.h"
#import "Ticket.h"

@interface lighthouseAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;

	NSMutableArray *projectArray;
//	NSMutableArray *ticketsArray;
	BOOL reloadProjects;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSMutableArray *projectArray;
//@property (nonatomic, retain) NSMutableArray *ticketsArray;

@property BOOL reloadProjects;

//-(void) 

- (NSString *) getApiKey;
- (void) setApiKey:(NSString *)apiKey;
- (NSInteger) getDbVersion;
- (void) setDbVersion:(int)apiKey;

- (void) addProject:(Project *)projectObj;
- (void) removeProject:(Project *)projectObj;
- (void) reloadProjectArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

- (NSString *) getProperty:(NSString *)name;
- (void) setProperty:(NSString *)name value:(NSString *)newValue;
- (void) deleteProperty:(NSString *)name;

- (void)updatedDbVersion1;
	
@end

