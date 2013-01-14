//
//  AMGameProtocol.h
//  Test01
//
//  Created by Albert Mata on 12/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMConstants.h"

@protocol AMGameDelegate <NSObject>

- (void)userPressedResumeOrNewGame:(id)sender;
- (int)circlesTouchedWell;
- (int)circlesTouchedBadly;
- (int)circlesAvoidedWell;
- (int)circlesAvoidedBadly;
- (int)timePlaying;
- (int)livesRemaining;
- (AMGameStatus)gameStatus;
- (BOOL)soundActivated;
- (void)setSoundActivated:(BOOL)soundActivated;

@end