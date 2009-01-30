//
//  Ticket.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/27/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ticket : NSObject {
	NSInteger ticketID;
	NSString *ticketName;
	NSString *ticketDescription;
}

@property (nonatomic, readonly) NSInteger ticketID;
@property (nonatomic, copy) NSString *ticketName;
@property (nonatomic, copy) NSString *ticketDescription;

@end
