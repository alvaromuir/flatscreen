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

-(NSDateComponents *) components{
    _date = [NSDate date];
    _calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                            NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [_calendar components:units fromDate:_date];
    return components;
}

-(NSString *) dateString{
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

-(NSString *) currentHour {
    Utilities *utils = [Utilities new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    [formatter setLocale:_posix];
    
    NSString *formattedTime = [formatter stringFromDate:_date];
    NSArray *timeArray = [formattedTime componentsSeparatedByString:@":"];

    NSString *hour = [utils hourInWords:[timeArray[0] intValue]];
    NSString *minutes;
    NSNumber *min;
    int intMin = [timeArray[1] intValue];
    switch (intMin) {
        case 00 ... 3:
            min = [NSNumber numberWithInteger: intMin];
            minutes = [NSString stringWithFormat:@"%@ minutes past %@", min, hour];
            break;
            
        case 10:
            min = [NSNumber numberWithInteger: intMin];
            minutes = [NSString stringWithFormat:@"%@ minutes past %@", min, hour];
            break;
            
        case 15:
            minutes = [NSString stringWithFormat:@"quarter past %@", hour];
            break;

//        case 16 ... 29:
//            min = [NSNumber numberWithInteger: intMin];
//            minutes = [NSString stringWithFormat:@"%@ minutes past %@", min, hour];
//            break;

        case 20:
            min = [NSNumber numberWithInteger: intMin];
            minutes = [NSString stringWithFormat:@"%@ minutes past %@", min, hour];
            break;
            
        case 30:
            minutes = [NSString stringWithFormat:@"half past %@", hour];
            break;

//        case 31 ... 44:
//            min = [NSNumber numberWithInteger: intMin];
//            minutes = [NSString stringWithFormat:@"%@ minutes past %@", min, hour];
//            break;

        case 40:
            minutes = [NSString stringWithFormat:@"20 minutes til %@", hour];
            
        case 45:
            minutes = [NSString stringWithFormat:@"quarter to %@", hour];
            break;
            
//        case 46 ... 49:
//            min = [NSNumber numberWithInteger: intMin];
//            minutes = [NSString stringWithFormat:@"%@ minutes past %@", min, hour];
//            break;
            
        case 50 ... 59:
            min = [NSNumber numberWithInteger: (60 - intMin)];
            minutes = [NSString stringWithFormat:@"%@ minutes til %@", min, hour];
            break;
            
        default:
            [formatter setDateFormat:@"h:mm a"];
            formattedTime = [formatter stringFromDate:_date];
            minutes = formattedTime;
    }
    
    
    return minutes;
}


@end
