//
//  DateTime.m
//  Clock
//
//  Created by Alvaro Muir on 1/11/14.
//  Copyright (c) 2014 muiral. All rights reserved.
//

#import "DateTime.h"
#import "Utilities.h"

@implementation DateTime

-(instancetype) init{
    self = [super init];
    if (self){
        NSDate *now = [NSDate date];
        _date = now;
        _calendar = [NSCalendar currentCalendar];
        _posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
    }
    return self;
}

-(NSString *) description{
    _date = [NSDate date];
    _calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:_posix];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSString *dateString = [formatter stringFromDate:_date];
    
    return dateString;
}


-(NSString *) dateString{
    /*
     Returns the current date in MMMM dd[ord], YYYY -ord is the ordinal
     */
    Utilities *utils = [Utilities new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM,dd,y"];
    [formatter setLocale:_posix];
    
    NSString *formattedDate = [formatter stringFromDate:_date];
    NSArray *dateArray = [formattedDate componentsSeparatedByString:@","];
    
    NSString *dayNum = dateArray[1];
    NSString *ordDayNum = [utils numberWithOrdinal: dayNum.intValue];
    
    NSString *dateString = [NSString stringWithFormat:@"%@ %@, %@", dateArray[0], ordDayNum, dateArray[2]];
    return dateString;
}


-(NSDictionary *) timeDict {
    /*
     Returns dictionary of human readable time as: 
     {
        prefix (if applicable): [xx mins., quarter, half],
        lead (if applicable):[to, past],
        hour (if applicable): [twelve, one],
        timeString: [1:33pm]
     }
    */
    Utilities *utils = [Utilities new];
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionaryWithDictionary:@{}];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    [formatter setLocale:_posix];
    
    NSString *formattedTime = [formatter stringFromDate:_date];
    NSArray *timeArray = [formattedTime componentsSeparatedByString:@":"];
    
    
    NSString *hour = [utils hourInWords:[timeArray[0] intValue]];
    
    NSString *nextHour;
    if ([timeArray[0] intValue] == 12)
        nextHour = @"one";
    else
        nextHour = [utils hourInWords:[timeArray[0] intValue] + 1];
    
    
    NSNumber *min;
    [timeDict setObject: hour forKey:@"hour"];
    int intMin = [timeArray[1] intValue];
    switch (intMin) {
        case 02 ... 5:
        case 10:
        case 20:
            min = [NSNumber numberWithInteger: intMin];
            [timeDict setObject: [NSString stringWithFormat:@"%@ mins.",min] forKey:@"prefix"];
            [timeDict setObject: @"past" forKey:@"lead"];

            break;
            
            
        case 15:
            [timeDict setObject: @"it's a quarter" forKey:@"prefix"];
            [timeDict setObject: @"past" forKey:@"lead"];
            break;
            
            
        case 30:
            [timeDict setObject: @"it's half" forKey:@"prefix"];
            [timeDict setObject: @"past" forKey:@"lead"];
            break;
            
            
        case 40:
            min = [NSNumber numberWithInteger: (intMin - 20)];
            [timeDict setObject: [NSString stringWithFormat:@"%@ mins.",min] forKey:@"prefix"];
            [timeDict setObject: @"to" forKey:@"lead"];
            [timeDict setObject: nextHour forKey:@"hour"];
            break;
            
        case 45:
            [timeDict setObject: @"quarter" forKey:@"prefix"];
            [timeDict setObject: @"to" forKey:@"lead"];
            [timeDict setObject: nextHour forKey:@"hour"];
            break;
            
        case 50 ... 50:
            min = [NSNumber numberWithInteger: (60 - intMin)];
            [timeDict setObject: [NSString stringWithFormat:@"%@ mins.",min] forKey:@"prefix"];
            [timeDict setObject: @"to" forKey:@"lead"];
            [timeDict setObject: nextHour forKey:@"hour"];
            break;
            
        default:
            break;
    }
    [formatter setDateFormat:@"h:mm a"];
    formattedTime = [formatter stringFromDate:_date];
    [timeDict setObject:formattedTime forKey:@"timeString"];
    
    
    return timeDict;
}


-(NSDictionary *) dateTimeDict {
    // Returns dictionary of date string and human readable time
    NSDictionary *dateTimeDict = @{
                                   @"time": [self timeDict], @"date": [self dateString]
                                   };
    return dateTimeDict;
}


@end
