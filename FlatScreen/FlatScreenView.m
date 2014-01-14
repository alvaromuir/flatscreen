//
//  FlatScreenView.m
//  FlatScreen
//
//  Created by Alvaro Muir on 1/11/14.
//  Copyright (c) 2014 muiral. All rights reserved.
//

#import "FlatScreenView.h"
#import "DateTime.h"
#import "Utilities.h"

@implementation FlatScreenView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    
    Utilities *utils = [[Utilities alloc] init];
    [utils fontActivate:@"BentonSans-Bold.otf"];
    [utils fontActivate:@"BentonSans-ExtraLight.otf"];
    [utils fontActivate:@"meteocons.ttf"];
    [utils fontActivate:@"RobotoSlab-Thin.ttf"];
    
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {

        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    NSColor *backgroundColor = [NSColor colorWithCalibratedRed:(37.0/255.0)
                                                         green:(36.0/255.0)
                                                          blue:(36.0/255.0)
                                                         alpha:(255.0/255.0)
                                ];
    
    NSColor *foregroundColor = [NSColor colorWithCalibratedRed:(230.0/255.0)
                                                         green:(230.0/255.0)
                                                          blue:(230.0/255.0)
                                                         alpha:(255.0/255.0)
                                ];
    NSRect bounds = self.bounds;
    [backgroundColor set];
    NSRectFill(bounds);
    
    
    DateTime *currentDateTime = [[DateTime alloc] init];

    
    NSDictionary *dateTimeDict = [currentDateTime dateTimeDict];
    NSLog(@"%@",  dateTimeDict);
    
    CGFloat posX = (NSWidth (bounds)* 0.03);
    CGFloat posY = (NSWidth (bounds)* 0.12);
    CGFloat widthX = (NSWidth (bounds)*0.20);
    CGFloat widthY = (NSWidth (bounds)*0.15);
    NSRect contentBounds = NSMakeRect( posX, posY, widthX, widthY );
    
    NSMutableParagraphStyle *alignTextRight = [[NSMutableParagraphStyle alloc] init];
    [alignTextRight setAlignment:NSRightTextAlignment];
    
    
    
    NSString *timePrefix, *timeLead, *timeString;
    NSString *hour = [[dateTimeDict objectForKey:@"time"] objectForKey:@"hour"];
    
    
    if([[dateTimeDict objectForKey:@"time"] valueForKey:@"prefix"] != nil) {
        timePrefix = [[dateTimeDict objectForKey:@"time"] objectForKey:@"prefix"];
        timeLead =  [[dateTimeDict objectForKey:@"time"] objectForKey:@"lead"];
        timeString = [NSString stringWithFormat:@"%@ %@", timeLead, hour];
        
    }
    else
        timeString = [[dateTimeDict objectForKey:@"time"] objectForKey:@"timeString"];
    
    
    
    // draw time prefix, if applicable
    NSRect timePrefixBounds = NSMakeRect(contentBounds.origin.x,
                                         contentBounds.origin.y * 2.1,
                                         contentBounds.size.width,
                                         contentBounds.size.height * 0.2);
    
    NSMutableDictionary *timePrefixAttribs = [NSMutableDictionary dictionaryWithDictionary: @{
                                              NSForegroundColorAttributeName: foregroundColor,
                                              NSParagraphStyleAttributeName: alignTextRight,
                                              NSFontAttributeName: [NSFont fontWithName: @"BentonSans Extra Light"
                                                                                   size: contentBounds.size.height * 0.2]
                                              }];
    [timePrefix drawInRect:timePrefixBounds withAttributes:timePrefixAttribs];
    
    
    
    
    // draw time hour
    NSRect hourBounds = NSMakeRect(contentBounds.origin.x,
                                   timePrefixBounds.origin.y - contentBounds.size.height * 0.17,
                                   contentBounds.size.width,
                                   contentBounds.size.height * 0.20);

    NSMutableDictionary *timeStringAttribs = [NSMutableDictionary dictionaryWithDictionary: @{
                                              NSForegroundColorAttributeName: foregroundColor,
                                              NSParagraphStyleAttributeName: alignTextRight,
                                              NSFontAttributeName: [NSFont fontWithName: @"BentonSans Bold"
                                                                                   size: contentBounds.size.height * 0.2]
                                              }];
    [timeString drawInRect:hourBounds withAttributes:timeStringAttribs];
    
    
    
    //    // Draw date line
    NSString *dateString = dateTimeDict[@"date"];
    NSRect dateBounds = NSMakeRect(contentBounds.origin.x,
                                   hourBounds.origin.y - contentBounds.size.height * .075,
                                   contentBounds.size.width,
                                   contentBounds.size.height * 0.15);

    NSMutableDictionary *dateStringAttribs = [NSMutableDictionary dictionaryWithDictionary: @{
                                              NSForegroundColorAttributeName: foregroundColor,
                                              NSParagraphStyleAttributeName: alignTextRight,
                                              NSFontAttributeName: [NSFont fontWithName: @"Roboto Slab Thin"
                                                                                   size: contentBounds.size.height * 0.10]
                                              }];
    [dateString drawInRect:dateBounds withAttributes:dateStringAttribs];
    

}

- (void)animateOneFrame
{
//    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
