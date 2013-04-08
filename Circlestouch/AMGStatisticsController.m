//
//  AMGStatisticsController.m
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGStatisticsController.h"

@implementation AMGStatisticsController

#pragma mark - Drawing view

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIColor *color = [UIColor whiteColor];
    UIColor *backgroundColor = [UIColor clearColor];
    UIFont *smallFont = [UIFont fontWithName:APP_MAIN_FONT size:16.0f];
    UIFont *middleFont = [UIFont fontWithName:APP_MAIN_FONT size:22.0f];
    UIFont *bigFont = [UIFont fontWithName:APP_MAIN_FONT size:28.0f];
    
    float width = 210.0f;
    float height = 30.0f;
    float x = 30.0f;
    float y = MARGIN_TOP + (IS_WIDESCREEN ? 80.0f : 40.0f);
        
    // "Circles well touched"
    
    UILabel *circlesTouchedWell = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    circlesTouchedWell.text = NSLocalizedString(@"Circles touched correctly", @"Statistics screen");
    circlesTouchedWell.textColor = color;
    circlesTouchedWell.backgroundColor = backgroundColor;
    circlesTouchedWell.font = smallFont;
    [self.view addSubview:circlesTouchedWell];
    
    // Result for "Circles well touched"
    
    self.touchedWellResult = [[UILabel alloc] initWithFrame:CGRectMake(x + width, y, 50.0f, height)];
    self.touchedWellResult.textColor = color;
    self.touchedWellResult.backgroundColor = backgroundColor;
    self.touchedWellResult.font = smallFont;
    self.touchedWellResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.touchedWellResult];

    // "Circles well avoided"
    
    y += height + 5.0f;
    
    UILabel *circlesAvoidedWell = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    circlesAvoidedWell.text = NSLocalizedString(@"Circles avoided correctly", @"Statistics screen");
    circlesAvoidedWell.textColor = color;
    circlesAvoidedWell.backgroundColor = backgroundColor;
    circlesAvoidedWell.font = smallFont;
    [self.view addSubview:circlesAvoidedWell];
    
    // Result for "Circles well avoided"
    
    self.avoidedWellResult = [[UILabel alloc] initWithFrame:CGRectMake(x + width, y, 50.0f, height)];
    self.avoidedWellResult.textColor = color;
    self.avoidedWellResult.backgroundColor = backgroundColor;
    self.avoidedWellResult.font = smallFont;
    self.avoidedWellResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.avoidedWellResult];
    

    // "Circles badly touched"
    
    y += height + 5.0f;
    
    UILabel *circlesTouchedBadly = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    circlesTouchedBadly.text = NSLocalizedString(@"Circles touched incorrectly", @"Statistics screen");
    circlesTouchedBadly.textColor = color;
    circlesTouchedBadly.backgroundColor = backgroundColor;
    circlesTouchedBadly.font = smallFont;
    [self.view addSubview:circlesTouchedBadly];
    
    // Result for "Circles badly touched"
    
    self.touchedBadlyResult = [[UILabel alloc] initWithFrame:CGRectMake(x + width, y, 50.0f, height)];
    self.touchedBadlyResult.textColor = color;
    self.touchedBadlyResult.backgroundColor = backgroundColor;
    self.touchedBadlyResult.font = smallFont;
    self.touchedBadlyResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.touchedBadlyResult];
    
    // "Circles badly avoided"
    
    y += height + 5.0f;
    
    UILabel *circlesAvoidedBadly = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    circlesAvoidedBadly.text = NSLocalizedString(@"Circles avoided incorrectly", @"Statistics screen");
    circlesAvoidedBadly.textColor = color;
    circlesAvoidedBadly.backgroundColor = backgroundColor;
    circlesAvoidedBadly.font = smallFont;
    [self.view addSubview:circlesAvoidedBadly];
    
    // Result for "Circles badly avoided"
    
    self.avoidedBadlyResult = [[UILabel alloc] initWithFrame:CGRectMake(x + width, y, 50.0f, height)];
    self.avoidedBadlyResult.textColor = color;
    self.avoidedBadlyResult.backgroundColor = backgroundColor;
    self.avoidedBadlyResult.font = smallFont;
    self.avoidedBadlyResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.avoidedBadlyResult];
    
    // "Game over / Game paused / Start a new game!"
    
    y = PAGECONTROL_DOTS_Y - (IS_WIDESCREEN ? 100.0f : 70.0f);
    
    self.gameStatus = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, y, SCREEN_WIDTH, 50.0f)];
    self.gameStatus.textColor = color;
    self.gameStatus.backgroundColor = backgroundColor;
    self.gameStatus.font = bigFont;
    self.gameStatus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.gameStatus];
    
    // "Best score"
    
    y = PAGECONTROL_DOTS_Y + 45.0f;
    
    UILabel *bestScore = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    bestScore.text = NSLocalizedString(@"Your best score", @"Statistics screen");
    bestScore.textColor = color;
    bestScore.backgroundColor = backgroundColor;
    bestScore.font = middleFont;
    [self.view addSubview:bestScore];
    
    // Result for "Best score ever"
    
    UILabel *bestScoreResult = [[UILabel alloc] initWithFrame:CGRectMake(x + width, y, 50.0f, height)];
    bestScoreResult.text = @"9990"; // TEMP************************************************************************************************
    bestScoreResult.textColor = color;
    bestScoreResult.backgroundColor = backgroundColor;
    bestScoreResult.font = middleFont;
    bestScoreResult.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:bestScoreResult];
}

@end