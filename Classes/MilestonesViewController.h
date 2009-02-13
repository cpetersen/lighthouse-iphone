//
//  MilestonesViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "Milestone.h"
#import "TicketsViewController.h"

@interface MilestonesViewController : UIViewController<UITableViewDelegate> {
	IBOutlet UITableView *tableView;
	IBOutlet UIActivityIndicatorView *activityIndicator;

	Project *project;
}

@property (nonatomic, retain) Project *project;

@end
