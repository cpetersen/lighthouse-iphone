//
//  NSTicketXMLParser.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"
#import "lighthouseAppDelegate.h"

@interface TicketXMLParser : NSObject {
	NSMutableArray *tickets;

	Ticket *aTicket;
	NSMutableString *currentElementValue;
	BOOL TITLE_FLAG;
	BOOL NUMBER_FLAG;
	BOOL STATE_FLAG;
	BOOL PRIORITY_FLAG;
	BOOL ASSIGNED_FLAG;
	BOOL CREATOR_FLAG;
	BOOL URL_FLAG;
	BOOL MILESTONE_FLAG;
	BOOL BODY_FLAG;
}

@property (nonatomic, retain) NSMutableArray *tickets;

- (TicketXMLParser *) initXMLParser;

@end
