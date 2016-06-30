//
//  AMGGameManager.m
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGGameManager.h"
#import "AMGCircle.h"

@implementation AMGGameManager

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

- (BOOL)isItOkToTouchColor:(UIColor *)color
{
    return [self.colorsToTouch containsObject:color];
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
    if ([self.colorsToAvoid count] - rnd < 3) rnd = (int)[self.colorsToAvoid count] - 3;
    if ([self.colorsToAvoid count] - rnd > 6) rnd = (int)[self.colorsToAvoid count] - 6;
    for (int i = 1; i <= rnd; i++) {
        [self removeOneColorFromColorsToAvoidAndAddToColorsToTouch];
    }
}

- (float)nextColorsChangeInterval
{
    int min = 10.0f * CHANGE_COLORS_INTERVAL_MIN;
    int max = 10.0f * CHANGE_COLORS_INTERVAL_MAX;
    return (min + (arc4random() % (max - min))) / 10.0f;
}

- (void)resetGame
{
    [self.circles removeAllObjects];
    self.livesRemaining = INITIAL_LIVES;
    self.timePlaying = 0;
    self.circlesTouchedWell = 0;
    self.circlesTouchedBadly = 0;
    self.circlesAvoidedWell = 0;
    self.circlesAvoidedBadly = 0;
}

#pragma mark - 
#pragma mark Next circle randoms
#pragma mark -

- (float)nextCircleIntervalCreation
{
    int min = 10.0f *
    MAX(MIN_CIRCLE_CREATION_INTERVAL + 0.4f - (0.1f * self.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_CREATION_INTERVAL);
    int max = 10.0f *
    MAX(MAX_CIRCLE_CREATION_INTERVAL - (0.1f * self.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_CREATION_INTERVAL + 0.3f);
    return (min + (arc4random() % (max - min))) / 10.0f;
}

- (float)nextCircleLife
{
    int min = 10.0f * MAX(MIN_CIRCLE_LIFE + 1.0f - (0.1f * self.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_LIFE);
    int max = 10.0f * MAX(MAX_CIRCLE_LIFE - (0.1f * self.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_LIFE + 0.5f);
    return (min + (arc4random() % (max - min))) / 10.0f;
}

- (BOOL)nextCirclePositionX:(int *)x y:(int *)y
{
    // If it can't find a location in 10 tries, return NO and we'll try again later. This way
    // the GameManager will have the chance to remove some circles. Without this, when it can't
    // find a location it tries forever, as it blocks the app and no circles are ever removed
    // from GameManager, so no location can be ever found.
    for (int tries = 0; tries < 10; tries++) {
        *x = MARGIN_BUTTON + (arc4random() % ((int)SCREEN_WIDTH - BUTTON_SIZE - MARGIN_BUTTON * 2));
        *y = MARGIN_TOP + MARGIN_BUTTON + (arc4random() % ((int)SCREEN_HEIGHT - BUTTON_SIZE - MARGIN_TOP - MARGIN_BOTTOM - MARGIN_BUTTON * 2));
        if ([self isItOkToPutACircleInPositionWithX:*x andY:*y]) return YES;
    }
    return NO;
}

- (UIColor *)nextCircleColor
{
    return [self randomColor];
}

#pragma mark -
#pragma mark Private methods
#pragma mark -

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

- (BOOL)isItOkToPutACircleInPositionWithX:(int)x andY:(int)y
{
    CGRect testFrame = CGRectMake(x - MARGIN_BUTTON,
                                  y - MARGIN_BUTTON,
                                  BUTTON_SIZE + MARGIN_BUTTON * 2,
                                  BUTTON_SIZE + MARGIN_BUTTON * 2);
    for (AMGCircle *c in self.circles) {
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

- (UIColor *)randomColor
{
    switch (arc4random() % NUM_COLORS) {
        case 0:
            return [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f]; // purple
        case 1:
            return [UIColor colorWithRed:0.953f green:0.518f blue:0.478f alpha:1.0f]; // salmon
        case 2:
            return [UIColor colorWithRed:0.404f green:0.733f blue:0.953f alpha:1.0f]; // light blue
        case 3:
            return [UIColor colorWithRed:0.7f green:0.1f blue:0.1f alpha:1.0f]; // red
        case 4:
            return [UIColor colorWithRed:0.15f green:0.15f blue:0.7f alpha:1.0f]; // dark blue
        case 5:
            return [UIColor colorWithRed:0.5f green:0.8f blue:0.0f alpha:1.0f]; // green
        case 6:
            return [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f]; // light gray
        case 7:
            return [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:1.0f]; // orange
        case 8:
            return [UIColor colorWithRed:1.0f green:0.8f blue:0.0f alpha:1.0f]; // dark yellow
        default:
            return [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]; // white
    }
}

@end