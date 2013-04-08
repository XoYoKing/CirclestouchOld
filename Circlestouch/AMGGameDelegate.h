//
//  AMGGameDelegate.h
//  Circlestouch
//
//  Created by Albert Mata on 12/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AMGGameDelegate <NSObject>

- (void)userPressedResumeOrNewGame:(id)sender;
- (int)circlesTouchedWell;
- (int)circlesTouchedBadly;
- (int)circlesAvoidedWell;
- (int)circlesAvoidedBadly;
- (int)timePlaying;
- (int)livesRemaining;
- (AMGGameStatus)gameStatus;
- (BOOL)soundActivated;
- (void)setSoundActivated:(BOOL)soundActivated;

@end