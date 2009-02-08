//
//  RootViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/20/09.
//  Copyright Assay Depot 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectAdminViewController.h"
#import "TicketsViewController.h"
#import "lighthouseAppDelegate.h"
#import "ApiKeyViewController.h"
#import "ProjectDetailTabViewController.h"

@interface RootViewController : UITableViewController {
	lighthouseAppDelegate *appDelegate;
	ProjectAdminViewController *pavController;
	UINavigationController *addNavigationController;
}

@end
