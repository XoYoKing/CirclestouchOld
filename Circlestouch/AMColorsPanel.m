//
//  AMColorsPanel.m
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMColorsPanel.h"

@implementation AMColorsPanel

- (id)initWithFrame:(CGRect)frame 
{
    return [self initWithFrame:frame andColorsToTouch:nil andColorsToAvoid:nil];
}

- (id)initWithFrame:(CGRect)frame andColorsToTouch:(NSArray *)colorsToTouch andColorsToAvoid:(NSArray *)colorsToAvoid
{
    self = [super initWithFrame:frame];
    if (self) {
        self.colorsToTouch = colorsToTouch;
        self.colorsToAvoid = colorsToAvoid;
    }
    return self;
}

- (void)setColorsToTouch:(NSArray *)colorsToTouch
{
    _colorsToTouch = colorsToTouch;
    [self setNeedsDisplay];
}

- (void)setColorsToAvoid:(NSArray *)colorsToAvoid
{
    _colorsToAvoid = colorsToAvoid;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    int centralSeparation = SCREEN_WIDTH
                            - MARGIN_LEFTMOST
                            - MARGIN_RIGHTMOST
                            - NUM_COLORS * MINICIRCLE_DIAMETER
                            - (NUM_COLORS - 2) * MINICIRCLE_SEPARATION;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    int x = MARGIN_LEFTMOST;
    
    // Drawing colors to touch
    for (int i = 0; i < [self.colorsToTouch count]; i++) {
        UIColor *color = [self.colorsToTouch objectAtIndex:i];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(x, MARGIN_TOPMOST, MINICIRCLE_DIAMETER, MINICIRCLE_DIAMETER));
        x += MINICIRCLE_DIAMETER + MINICIRCLE_SEPARATION;
    }
    
    x += centralSeparation;
    
    // Drawing colors to avoid
    for (int i = 0; i < [self.colorsToAvoid count]; i++) {
        UIColor *color = [self.colorsToAvoid objectAtIndex:i];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(x, MARGIN_TOPMOST, MINICIRCLE_DIAMETER, MINICIRCLE_DIAMETER));
        x += MINICIRCLE_DIAMETER + MINICIRCLE_SEPARATION;
    }
}

@end