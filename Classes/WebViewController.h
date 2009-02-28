//
//  WebViewController.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/18/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	NSString *url;
//	NSString *body;
}

@property (nonatomic, retain) NSString *url;
//@property (nonatomic, retain) NSString *body;

@end
