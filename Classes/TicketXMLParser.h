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
	NSMutableString *currentElementValue;
	
	lighthouseAppDelegate *appDelegate;
	Ticket *aTicket;
}

- (TicketXMLParser *) initXMLParser;

@end
