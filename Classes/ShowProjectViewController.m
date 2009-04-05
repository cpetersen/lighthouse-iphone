//
//  ShowProjectViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/28/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "ShowProjectViewController.h"


@implementation ShowProjectViewController

@synthesize project;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[sslSwitch setOn:FALSE];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(IBAction) deleteProject: (id) sender {
	lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate removeProject:[self project]];
	[[self navigationController] popViewControllerAnimated:TRUE];

}

- (void)dealloc {
    [super dealloc];
}


@end
