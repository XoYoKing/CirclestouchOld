//
//  AMGameManager.m
//  Test01
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMGameManager.h"
#import "AMCircle.h"

@implementation AMGameManager

- (id)init
{
    self = [super init];
    if (self) {
        self.circles = [[NSMutableSet alloc] init];
        [self loadInitialArraysWithColorsToTouchAndAvoid];
        self.livesRemaining = INITIAL_LIVES;
    }
    return self;
}

- (void)dealloc
{
    self.circles = nil;
    self.colorsToTouch = nil;
    self.colorsToAvoid = nil;
}

- (void)setLivesRemaining:(int)livesRemaining
{
    if (livesRemaining > MAX_LIVES) livesRemaining = MAX_LIVES;
    if (livesRemaining < MIN_LIVES) livesRemaining = MIN_LIVES;
    _livesRemaining = livesRemaining;
}

- (void)loadInitialArraysWithColorsToTouchAndAvoid
{
    NSMutableSet *ms = [[NSMutableSet alloc] init];
    
    while ([ms count] < NUM_COLORS_TOUCH_INITIAL) {
        [ms addObject:[self randomColor]];
    }
    self.colorsToTouch = [ms allObjects];
    
    [ms removeAllObjects];
    while ([ms count] < (NUM_COLORS - NUM_COLORS_TOUCH_INITIAL)) {
        UIColor *c = [self randomColor];
        if (![self.colorsToTouch containsObject:c]) {
            [ms addObject:c];
        }
    }
    self.colorsToAvoid = [ms allObjects];
}

- (BOOL)isItOkToPutACircleInPositionWithX:(int)x andY:(int)y
{
    CGRect testFrame = CGRectMake(x - MARGIN_BUTTON,
                                  y - MARGIN_BUTTON,
                                  BUTTON_SIZE + MARGIN_BUTTON * 2,
                                  BUTTON_SIZE + MARGIN_BUTTON * 2);
    for (AMCircle *c in self.circles) {
        CGRect busyFrame = CGRectMake(c.x - MARGIN_BUTTON,
                                      c.y - MARGIN_BUTTON,
                                      BUTTON_SIZE + MARGIN_BUTTON * 2,
                                      BUTTON_SIZE + MARGIN_BUTTON * 2);
        if(CGRectIntersectsRect(testFrame, busyFrame)) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isItOkToTouchColor:(UIColor *)color
{
    return [self.colorsToTouch containsObject:color];
}

- (UIColor *)randomColor
{
    switch (arc4random() % NUM_COLORS) {
        case 0:
            return [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f]; // purple
        case 1:
            return [UIColor colorWithRed:1.0f green:0.5f blue:0.5f alpha:1.0f]; // salmon
        case 2:
            return [UIColor colorWithRed:0.4f green:0.6f blue:1.0f alpha:1.0f]; // light blue
        case 3:
            return [UIColor colorWithRed:0.6f green:0.0f blue:0.0f alpha:1.0f]; // red
        case 4:
            return [UIColor colorWithRed:0.15f green:0.15f blue:0.7f alpha:1.0f]; // dark blue
        case 5:
            return [UIColor colorWithRed:0.5f green:0.8f blue:0.0f alpha:1.0f]; // green
        case 6:
            return [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f]; // light gray
        case 7:
            return [UIColor colorWithRed:1.0f green:0.6f blue:0.0f alpha:1.0f]; // orange
        case 8:
            return [UIColor colorWithRed:1.0f green:1.0f blue:0.25f alpha:1.0f]; // yellow
        default:
            return [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]; // white
    }
}

- (void)makeSomeChangesInArraysWithColorsToTouchAndAvoid
{
    // Moving 2 to 3 colors from Touch to Avoid
    int rnd = 2 + (arc4random() % 2);
    for (int i = 1; i <= rnd; i++) {
        [self removeOneColorFromColorsToTouchAndAddToColorsToAvoid];
    }
    
    // Moving 0 to N colors from Avoid to Touch
    rnd =  arc4random() % [self.colorsToAvoid count];
    // Tuning so Avoid never has less than 3 colors or more than 6 (so the same for Touch)
    if ([self.colorsToAvoid count] - rnd < 3) rnd = [self.colorsToAvoid count] - 3;
    if ([self.colorsToAvoid count] - rnd > 6) rnd = [self.colorsToAvoid count] - 6;
    for (int i = 1; i <= rnd; i++) {
        [self removeOneColorFromColorsToAvoidAndAddToColorsToTouch];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)removeOneColorFromColorsToTouchAndAddToColorsToAvoid
{
    NSMutableArray *touch = [NSMutableArray arrayWithArray:self.colorsToTouch];
    NSMutableArray *avoid = [NSMutableArray arrayWithArray:self.colorsToAvoid];
    int index = arc4random() % [touch count];
    UIColor *color = [touch objectAtIndex:index];
    [touch removeObjectAtIndex:index];
    [avoid addObject:color];
    self.colorsToTouch = [NSArray arrayWithArray:touch];
    self.colorsToAvoid = [NSArray arrayWithArray:avoid];
}

- (void)removeOneColorFromColorsToAvoidAndAddToColorsToTouch
{
    NSMutableArray *touch = [NSMutableArray arrayWithArray:self.colorsToTouch];
    NSMutableArray *avoid = [NSMutableArray arrayWithArray:self.colorsToAvoid];
    int index = arc4random() % [avoid count];
    UIColor *color = [avoid objectAtIndex:index];
    [avoid removeObjectAtIndex:index];
    [touch addObject:color];
    self.colorsToTouch = [NSArray arrayWithArray:touch];
    self.colorsToAvoid = [NSArray arrayWithArray:avoid];
}

@end