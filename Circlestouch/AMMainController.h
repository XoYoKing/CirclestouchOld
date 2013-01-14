//
//  AMViewController.h
//  Test01
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGameDelegate.h"
#import "AMGameManager.h"
#import "AMPageControlController.h"
#import "AMColorsPanel.h"
#import "AMLivesRepresentation.h"

@interface AMMainController : UIViewController <AMGameDelegate> 

@property (nonatomic, strong) AMGameManager *gameManager;

@property (nonatomic, strong) NSTimer *timePlayingTimer;
@property (nonatomic, strong) NSTimer *circleCreationTimer;
@property (nonatomic, strong) NSTimer *colorsChangingTimer;

@property (nonatomic, strong) AMPageControlController *pageControlController;

@property (nonatomic, weak) AMColorsPanel *colorsPanel;
@property (nonatomic, weak) AMLivesRepresentation *livesRepresentation;
@property (nonatomic, weak) UIButton *timePlayingButton;

@property (nonatomic, getter=soundActivated, setter=setSoundActivated:) BOOL soundActivated;

@property (nonatomic) float lifeAcum;
@property (nonatomic) int circlesAcum;

- (void)activateColorsChangingTimer;
- (void)inactivateTimePlayingTimer;
- (void)inactivateColorsChangingTimer;
- (void)inactivateCircleCreationTimer;
- (void)showPageControl:(id)sender;
- (void)saveGame;
- (void)loadGame;

@end
