//
//  AMGameCenterHelper.m
//  Circlestouch
//
//  Created by Albert Mata on 15/01/2013.
//  Copyright (c) 2013 Albert Mata. All rights reserved.
//

#import "AMGameCenterHelper.h"

@implementation AMGameCenterHelper

#pragma mark -
#pragma mark Initialization
#pragma mark -

// Singleton
static AMGameCenterHelper *sharedHelper = nil;
+ (AMGameCenterHelper *) sharedInstance
{
    if (!sharedHelper) {
        sharedHelper = [[AMGameCenterHelper alloc] init];
    }
    return sharedHelper;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(authenticationChanged)
                   name:GKPlayerAuthenticationDidChangeNotificationName
                 object:nil];
    }
    return self;
}

- (void)authenticationChanged
{
    if ([GKLocalPlayer localPlayer].isAuthenticated && !self.userAuthenticated) {
        NSLog(@"GameCenter > Authentication changed: player authenticated.");
        self.userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && self.userAuthenticated) {
        NSLog(@"GameCenter > Authentication changed: player not authenticated.");
        self.userAuthenticated = FALSE;
    }
}

#pragma mark -
#pragma mark Player functions
#pragma mark -

- (void)authenticateLocalPlayer {
    NSLog(@"GameCenter > Authenticating local player...");
    if ([GKLocalPlayer localPlayer].authenticated == YES) {
        NSLog(@"GameCenter > Local player was already authenticated!");
    } else {
        NSLog(@"GameCenter > Local player wasn't authenticated, trying to do now.");
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    }
}

#pragma mark -
#pragma mark Scores functions
#pragma mark -

- (void)reportScore:(int)score
{
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:@"AM.CirclestouchLeaderbord"];
    scoreReporter.value = score;
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil) {
            // It'd be a good idea to save it into NSUserDefaults and try to send it later.
        }
    }];
}

#pragma mark -
#pragma mark GKLeaderboardViewController
#pragma mark -

//
// Code to be added in a view controller in order to show GameCenter leaderboard.
//
//- (void)showGameCenterLeaderboard
//{
//    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
//    if (leaderboardController != nil)
//    {
//        leaderboardController.leaderboardDelegate = self;
//        [self presentModalViewController:leaderboardController animated:YES];
//    }
//}
//- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
//{
//    [self dismissModalViewControllerAnimated:YES];
//}

@end