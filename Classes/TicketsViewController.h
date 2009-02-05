//
//  TicketsViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/23/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface TicketsViewController : UIViewController {

	Project *project;
	NSMutableArray *milestonesArray;

}

@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSMutableArray *milestonesArray;

@end
