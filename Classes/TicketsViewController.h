//
//  TicketsViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface TicketsViewController : UIViewController<UITableViewDelegate> {
	IBOutlet UISearchBar *searchBar;
	IBOutlet UITableView *tableView;

	Project *project;
	NSString *query;
	BOOL searching;
	BOOL letUserSelectRow;
}

@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSString *query;

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@end
