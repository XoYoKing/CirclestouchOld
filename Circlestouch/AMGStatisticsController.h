//
//  AMGStatisticsController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGGameDelegate.h"
#import "AMGBlackRectButton.h"

@interface AMGStatisticsController : UIViewController

@property (nonatomic, weak) id<AMGGameDelegate> gameDelegate;
@property (nonatomic, strong) AMGBlackRectButton *playButton;
@property (nonatomic, strong) UILabel *touchedWellResult;
@property (nonatomic, strong) UILabel *avoidedWellResult;
@property (nonatomic, strong) UILabel *touchedBadlyResult;
@property (nonatomic, strong) UILabel *avoidedBadlyResult;
@property (nonatomic, strong) UILabel *gameStatus;

- (void)hidePlayButtonForSomeSeconds;

@end