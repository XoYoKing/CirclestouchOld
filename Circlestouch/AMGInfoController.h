//
//  AMGInfoController.h
//  Circlestouch
//
//  Created by Albert Mata on 05/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGGameDelegate.h"
#import "AMGBlackRectButton.h"

@interface AMGInfoController : UIViewController

@property (nonatomic, weak) id<AMGGameDelegate> gameDelegate;
@property (nonatomic, strong) AMGBlackRectButton *playButton;

- (void)animateArrows;

@end