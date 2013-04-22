//
//  AMGGameManager.h
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMGCircle.h"

@interface AMGGameManager : NSObject

@property (strong, nonatomic) NSMutableSet *circles;  // of AMGCircle
@property (strong, nonatomic) NSArray *colorsToTouch; // of UIColor
@property (strong, nonatomic) NSArray *colorsToAvoid; // of UIColor

@property (nonatomic) int livesRemaining;
@property (nonatomic) int timePlaying;
@property (nonatomic) int circlesTouchedWell;
@property (nonatomic) int circlesTouchedBadly;
@property (nonatomic) int circlesAvoidedWell;
@property (nonatomic) int circlesAvoidedBadly;

- (void)loadInitialArraysWithColorsToTouchAndAvoid;
- (BOOL)isItOkToTouchColor:(UIColor *)color;
- (void)makeSomeChangesInArraysWithColorsToTouchAndAvoid;
- (float)nextColorsChangeInterval;

// Next circle randoms
- (float)nextCircleIntervalCreation;
- (float)nextCircleLife;
- (BOOL)nextCirclePositionX:(int *)x y:(int *)y;
- (UIColor *)nextCircleColor;

@end