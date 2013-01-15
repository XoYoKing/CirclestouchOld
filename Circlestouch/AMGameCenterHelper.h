//
//  AMGameCenterHelper.h
//  Circlestouch
//
//  Created by Albert Mata on 15/01/2013.
//  Copyright (c) 2013 Albert Mata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface AMGameCenterHelper : NSObject

@property (nonatomic) BOOL userAuthenticated;

+ (AMGameCenterHelper *)sharedInstance;
- (void)authenticateLocalPlayer;
- (void)reportScore:(int)score;

@end