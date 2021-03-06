//
//  ShowProjectViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/28/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lighthouseAppDelegate.h"
#import "Project.h"

@interface ShowProjectViewController : UIViewController {
	IBOutlet UISwitch *sslSwitch;
	Project *project;
}

@property (nonatomic, retain) Project *project;

-(IBAction) updateProjectSecurity: (id) sender;
-(IBAction) deleteProject: (id) sender;

@end
