//
//  AMGGameCenterHelper.h
//  Circlestouch
//
//  Created by Albert Mata on 15/01/2013.
//  Copyright (c) 2013 Albert Mata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface AMGGameCenterHelper : NSObject

@property (nonatomic) BOOL userAuthenticated;

+ (AMGGameCenterHelper *)sharedInstance;
- (void)authenticateLocalPlayer;
- (void)reportScore:(int)score;

@end