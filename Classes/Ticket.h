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
	NSString *ticketDescription;
}

@property (nonatomic) NSInteger ticketNumber;
@property (nonatomic, copy) NSString *ticketTitle;
@property (nonatomic, copy) NSString *ticketDescription;

@end
