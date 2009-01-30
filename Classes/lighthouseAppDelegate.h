//
//  LighthouseAppDelegate.h
//  Lighthouse
//
//  Created by Christopher Petersen on 1/20/09.
//  Copyright Assay Depot 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

@interface lighthouseAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;

	NSMutableArray *projectArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSMutableArray *projectArray;

//-(void) 

- (NSString *) getApiKey;
- (void) setApiKey:(NSString *)apiKey;

- (void) addProject:(Project *)projectObj;
- (void) removeProject:(Project *)projectObj;
- (void) reloadProjectArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

@end

