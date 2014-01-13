//
//  DateTime.h
//  Clock
//
//  Created by Alvaro Muir on 1/11/14.
//  Copyright (c) 2014 muiral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTime : NSObject
@property NSDate *date;
@property NSCalendar *calendar;
@property NSLocale *posix;

-(NSDictionary *) dateTimeDict;

@end