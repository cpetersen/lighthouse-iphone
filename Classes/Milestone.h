//
//  Milestone.h
//  lighthouse
//
//  Created by Christopher Petersen on 2/3/09.
//  Copyright 2009 Assay Depot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Milestone : NSObject {
	NSInteger milestoneID;
	NSString *milestoneTitle;
}

@property (nonatomic) NSInteger milestoneID;
@property (nonatomic, copy) NSString *milestoneTitle;

@end
