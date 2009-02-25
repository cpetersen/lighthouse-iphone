//
//  WebViewController.m
//  lighthouse
//
//  Created by Christopher Petersen on 2/18/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize url, body;

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    [super viewDidLoad];
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	if([self url]) {
		NSURL *ns_url = [NSURL URLWithString:[self url]];
		NSURLRequest *request = [NSURLRequest requestWithURL:ns_url];
		[webView loadRequest:request];
	} else if([self body]) {
		NSLog(@"viewDidLoad 8");
	}

    [pool release];
}

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


- (void)dealloc {
    [url dealloc];
    [body dealloc];
    [super dealloc];
}


@end
