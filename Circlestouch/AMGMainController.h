//
//  AMGMainController.h
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGGameDelegate.h"
#import "AMGGameManager.h"
#import "AMGPageControlController.h"
#import "AMGColorsPanel.h"
#import "AMGLivesRepresentation.h"

@interface AMGMainController : UIViewController <AMGGameDelegate>

@property (nonatomic, strong) AMGGameManager *gameManager;

@property (nonatomic, strong) NSTimer *timePlayingTimer;
@property (nonatomic, strong) NSTimer *circleCreationTimer;
@property (nonatomic, strong) NSTimer *colorsChangingTimer;

@property (nonatomic, strong) AMGPageControlController *pageControlController;

@property (nonatomic, strong) AMGColorsPanel *colorsPanel;
@property (nonatomic, strong) AMGLivesRepresentation *livesRepresentation;
@property (nonatomic, strong) UIButton *timePlayingButton;

//@property (nonatomic, getter=soundActivated, setter=setSoundActivated:) BOOL soundActivated;

@property (nonatomic) float lifeAcum;
@property (nonatomic) int circlesAcum;

- (void)activateColorsChangingTimer;
- (void)inactivateTimePlayingTimer;
- (void)inactivateColorsChangingTimer;
- (void)inactivateCircleCreationTimer;
- (void)showPageControl;
- (void)saveGame;
- (void)loadGame;

@end
