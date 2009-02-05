//
//  NSTicketXMLParser.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/1/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticket.h"
#import "Project.h"
#import "lighthouseAppDelegate.h"

@interface TicketXMLParser : NSObject {
	Project *project;
	Ticket *aTicket;
	NSMutableString *currentElementValue;
	BOOL TITLE_FLAG;
	BOOL NUMBER_FLAG;
}

@property (nonatomic, retain) Project *project;

- (TicketXMLParser *) initXMLParser:(Project *)my_project;

@end
