//
//  MilestonesViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface MilestonesViewController : UITableViewController<UITableViewDelegate> {
	Project *project;
}

@property (nonatomic, retain) Project *project;

@end
