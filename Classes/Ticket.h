//
//  Ticket.h
//  lighthouse
//
//  Created by Christopher Petersen on 1/27/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ticket : NSObject {
	NSInteger ticketNumber;
	NSString *ticketTitle;
	NSString *ticketState;
	NSInteger ticketPriority;
	NSMutableArray *tags;
}

@property (nonatomic) NSInteger ticketNumber;
@property (nonatomic, copy) NSString *ticketTitle;
@property (nonatomic, copy) NSString *ticketState;
@property (nonatomic) NSInteger ticketPriority;
@property (nonatomic, retain) NSMutableArray *tags;

@end
