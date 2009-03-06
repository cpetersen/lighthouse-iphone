//
//  TicketVersion.h
//  lighthouse
//
//  Created by Christopher Petersen on 3/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TicketVersion : NSObject {
	NSString *user;
	NSString *body;
	NSString *bodyHtml;
}

@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *bodyHtml;

@end
