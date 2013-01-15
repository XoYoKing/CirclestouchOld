//
//  AMStatisticsController.m
//  Test01
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMStatisticsController.h"

@implementation AMStatisticsController

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    self = [super init];
    if (self) {
        self.view.frame = viewFrame;
    }
    [self drawUserInterface];
    return self;
}

- (void)drawUserInterface
{
    UIColor *color = [UIColor whiteColor];
    UIColor *backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont fontWithName:APP_MAIN_FONT size:16.0f];
    UIFont *mainFont = [UIFont fontWithName:APP_MAIN_FONT size:28.0f];
    float viewWidth;
    float viewHeight;
    float viewHorizontalMargin;
    float viewVerticalMargin;
    
    viewWidth = 210;
    viewHeight = 30;
    viewHorizontalMargin = 30;
    viewVerticalMargin = 40;
    
    // "Circles well touched"
    UILabel *circlesTouchedWell = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin,
                                                                            viewVerticalMargin,
                                                                            viewWidth,
                                                                            viewHeight)];
    circlesTouchedWell.text = NSLocalizedString(@"Circles touched correctly", @"Statistics screen");
    circlesTouchedWell.textColor = color;
    circlesTouchedWell.backgroundColor = backgroundColor;
    circlesTouchedWell.font = font;
    [self.view addSubview:circlesTouchedWell];
    
    // Result for "Circles well touched"
    UILabel *twr = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin + viewWidth,
                                                             viewVerticalMargin,
                                                             50,
                                                             viewHeight)];
    self.touchedWellResult = twr;
    self.touchedWellResult.textColor = color;
    self.touchedWellResult.backgroundColor = backgroundColor;
    self.touchedWellResult.font = font;
    self.touchedWellResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.touchedWellResult];

    // "Circles well avoided"
    viewVerticalMargin += viewHeight + 5;
    UILabel *circlesAvoidedWell = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin,
                                                                            viewVerticalMargin,
                                                                            viewWidth,
                                                                            viewHeight)];
    circlesAvoidedWell.text = NSLocalizedString(@"Circles avoided correctly", @"Statistics screen");
    circlesAvoidedWell.textColor = color;
    circlesAvoidedWell.backgroundColor = backgroundColor;
    circlesAvoidedWell.font = font;
    [self.view addSubview:circlesAvoidedWell];
    
    // Result for "Circles well avoided"
    UILabel *awr = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin + viewWidth,
                                                             viewVerticalMargin,
                                                             50,
                                                             viewHeight)];
    self.avoidedWellResult = awr;
    self.avoidedWellResult.textColor = color;
    self.avoidedWellResult.backgroundColor = backgroundColor;
    self.avoidedWellResult.font = font;
    self.avoidedWellResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.avoidedWellResult];
    

    // "Circles badly touched"
    viewVerticalMargin += viewHeight + 5;
    UILabel *circlesTouchedBadly = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin,
                                                                             viewVerticalMargin,
                                                                             viewWidth,
                                                                             viewHeight)];
    circlesTouchedBadly.text = NSLocalizedString(@"Circles touched incorrectly", @"Statistics screen");
    circlesTouchedBadly.textColor = color;
    circlesTouchedBadly.backgroundColor = backgroundColor;
    circlesTouchedBadly.font = font;
    [self.view addSubview:circlesTouchedBadly];
    
    // Result for "Circles badly touched"
    UILabel *tbr = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin + viewWidth,
                                                             viewVerticalMargin,
                                                             50,
                                                             viewHeight)];
    self.touchedBadlyResult = tbr;
    self.touchedBadlyResult.textColor = color;
    self.touchedBadlyResult.backgroundColor = backgroundColor;
    self.touchedBadlyResult.font = font;
    self.touchedBadlyResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.touchedBadlyResult];
    
    // "Circles badly avoided"
    viewVerticalMargin += viewHeight + 5;
    UILabel *circlesAvoidedBadly = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin,
                                                                             viewVerticalMargin,
                                                                             viewWidth,
                                                                             viewHeight)];
    circlesAvoidedBadly.text = NSLocalizedString(@"Circles avoided incorrectly", @"Statistics screen");
    circlesAvoidedBadly.textColor = color;
    circlesAvoidedBadly.backgroundColor = backgroundColor;
    circlesAvoidedBadly.font = font;
    [self.view addSubview:circlesAvoidedBadly];
    
    // Result for "Circles badly avoided"
    UILabel *abr = [[UILabel alloc] initWithFrame:CGRectMake(viewHorizontalMargin + viewWidth,
                                                             viewVerticalMargin,
                                                             50,
                                                             viewHeight)];
    self.avoidedBadlyResult = abr;
    self.avoidedBadlyResult.textColor = color;
    self.avoidedBadlyResult.backgroundColor = backgroundColor;
    self.avoidedBadlyResult.font = font;
    self.avoidedBadlyResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.avoidedBadlyResult];
    
    // "Game over / paused"
    viewHeight = 50;
    viewVerticalMargin = 20;
    UILabel *gs = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                            self.view.frame.size.height - viewHeight - viewVerticalMargin,
                                                            self.view.frame.size.width,
                                                            viewHeight)];
    self.gameStatus = gs;
    self.gameStatus.textColor = color;
    self.gameStatus.backgroundColor = backgroundColor;
    self.gameStatus.font = mainFont;
    self.gameStatus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.gameStatus];
}

#pragma mark -
#pragma mark Memory management
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"AMStatisticsController > didReceiveMemoryWarning");
}

@end
