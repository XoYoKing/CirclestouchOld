//
//  AMGInfoController.h
//  Circlestouch
//
//  Created by Albert Mata on 05/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGGameDelegate.h"
#import "AMGUIControls/AMGPlainRectButton.h"

@interface AMGInfoController : UIViewController

@property (nonatomic, weak) id<AMGGameDelegate> gameDelegate;
@property (nonatomic, strong) AMGPlainRectButton *playButton;

- (void)animateArrows;

@end