//
//  Utils.m
//  Clock
//
//  Created by Alvaro Muir on 1/11/14.
//  Copyright (c) 2014 muiral. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

-(NSString *)numberWithOrdinal:(int)number{
    NSString *suffix;
    int ones = number % 10;
    int temp = floor(number/10.0);
    int tens = temp%10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    NSString *completeAsString = [NSString stringWithFormat:@"%d%@",number,suffix];
    return completeAsString;
}

-(NSString *)hourInWords:(int)hour{
    NSString *hourInWords;
    switch (hour) {
            
        case 1:
        case 13:
            hourInWords = @"one";
            break;
            
        case 2:
        case 14:
            hourInWords = @"two";
            break;
            
        case 3:
        case 15:
            hourInWords = @"three";
            break;
            
        case 4:
        case 16:
            hourInWords = @"four";
            break;
            
        case 5:
        case 17:
            hourInWords = @"five";
            break;
            
        case 6:
        case 18:
            hourInWords = @"six";
            break;
            
        case 7:
        case 19:
            hourInWords = @"seven";
            break;
            
        case 8:
        case 20:
            hourInWords = @"eight";
            break;
            
        case 9:
        case 21:
            hourInWords = @"nine";
            break;
            
        case 10:
        case 22:
            hourInWords = @"ten";
            break;
            
        case 11:
        case 23:
            hourInWords = @"eleven";
            break;
            
        case 12:
        case 0:
            hourInWords = @"twelve";
            break;
    }
    return hourInWords;
}

@end
