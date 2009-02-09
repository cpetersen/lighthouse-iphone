//
//  ApiKeyViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 1/29/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "ApiKeyViewController.h"


@implementation ApiKeyViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"API Token";
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
											  target:self action:@selector(cancelClicked:)] autorelease];
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
											   target:self action:@selector(saveClicked:)] autorelease];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	//lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];

	//Set the textboxes to empty string.
	//txtApiKey.text = [[appDelegate getApiKey] UTF8String];
	txtApiKey.text = @"THIS IS A TEST";
	
	//Make the coffe name textfield to be the first responder.
	[txtApiKey becomeFirstResponder];
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
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)saveClicked:(id)sender {
	lighthouseAppDelegate *appDelegate = (lighthouseAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	// Save the key
	[appDelegate setApiKey:txtApiKey.text];

	[self.navigationController dismissModalViewControllerAnimated:YES];
}

-(void)cancelClicked:(id)sender {
	// pop it off the stack.
	//	[[self navigationController] popViewControllerAnimated:TRUE];
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
