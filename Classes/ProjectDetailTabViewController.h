//
//  ProjectDetailTabViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/6/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketsViewController.h"
#import "Project.h"

@interface ProjectDetailTabViewController : UITabBarController {
	Project *project;

}

@property (nonatomic, retain) Project *project;

@end
