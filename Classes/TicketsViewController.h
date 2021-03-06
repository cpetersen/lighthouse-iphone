//
//  TicketsViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "TicketDetailViewController.h"

@interface TicketsViewController : UIViewController<UITableViewDelegate> {
	IBOutlet UISearchBar *searchBar;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *moreCell;
	IBOutlet UIActivityIndicatorView *moreActivityIndicator;

	NSMutableArray *ticketArray;
	Project *project;
	NSString *query;
	BOOL searching;
	BOOL letUserSelectRow;
	BOOL tabbedView;
	BOOL empty;
	NSInteger currentPage;
}

@property (nonatomic, retain) NSMutableArray *ticketArray;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSString *query;

- (void) notTabbedView;
- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;

@end
