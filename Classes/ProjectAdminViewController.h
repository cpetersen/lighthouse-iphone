//
//  RootViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/20/09.
//  Copyright Assay Depot 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lighthouseAppDelegate.h"
#import "AddProjectViewController.h"
#import "ShowProjectViewController.h"
#import "Project.h"

@interface ProjectAdminViewController : UITableViewController {
	lighthouseAppDelegate *appDelegate;
	AddProjectViewController *apvController;
	ShowProjectViewController *spvController;
	Project *project;
	UINavigationController *addNavigationController;
}

@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) ShowProjectViewController *spvController;

@end
