//
//  AMGMainController.m
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//
//  This game uses this sound from freesound:
//  Double zap by chipfork (http://www.freesound.org/people/chipfork/)


#import <AudioToolbox/AudioToolbox.h>
#import "AMGMainController.h"
#import "AMGCircle.h"
#import "AMGCircleButton.h"

@implementation AMGMainController

@synthesize soundActivated; // required as it's a property defined in a protocol

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.soundActivated = YES;
    self.gameManager = [[AMGGameManager alloc] init];
    
    // Add background
    self.view.backgroundColor = [UIColor colorWithRed:0.925f green:0.9222f blue:0.906f alpha:1.0f];
    
    // Add top bar
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, MARGIN_TOP)];
    topBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topBar];

    // Add bottom bar
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - MARGIN_BOTTOM + 1, SCREEN_WIDTH, MARGIN_BOTTOM)];
    bottomBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomBar];
    
    // Add view for colors to touch and avoid
    self.colorsPanel = [[AMGColorsPanel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, MARGIN_TOP)
                                            andColorsToTouch:self.gameManager.colorsToTouch
                                            andColorsToAvoid:self.gameManager.colorsToAvoid];
    self.colorsPanel.backgroundColor = [UIColor clearColor];
    self.colorsPanel.alpha = 0.8f;
    [self.view addSubview:self.colorsPanel];

    // Add timePlayingButton (10, 10, 90 and 40 are correct absolute values for position and size)
    self.timePlayingButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, SCREEN_HEIGHT - MARGIN_BOTTOM + 12.0f, 90.0f, 40.0f)];
    [self.timePlayingButton setTitle:[NSString stringWithFormat:@"%i", self.gameManager.timePlaying] forState:UIControlStateNormal];
    [self.timePlayingButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.timePlayingButton.titleLabel.frame = self.timePlayingButton.frame;
    self.timePlayingButton.titleLabel.font = [UIFont fontWithName:APP_MAIN_FONT size:32.0];
    [self.timePlayingButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.timePlayingButton addTarget:self action:@selector(showPageControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timePlayingButton];
    
    // Add livesRepresentation (10, 19, 14 and 23 are correct absolute values for position and size)
    int x = 10.0f + self.timePlayingButton.frame.origin.x + self.timePlayingButton.frame.size.width;
    self.livesRepresentation = [[AMGLivesRepresentation alloc] initWithFrame:CGRectMake(x, SCREEN_HEIGHT - MARGIN_BOTTOM + 19.0f,
                                                                                        SCREEN_WIDTH - x - 14.0f, 23.0f)
                                                           andLivesRemaining:self.gameManager.livesRemaining];
    self.livesRepresentation.alpha = 0.9f;
    [self.view addSubview:self.livesRepresentation];
}

- (void)circleTouched:(AMGCircleButton *)sender
{
    if ([self.gameManager isItOkToTouchColor:sender.color]) {
        [self increaseCirclesTouchedWell];
        [self vanishRightCircle:sender];
    } else {
        [self increaseCirclesTouchedBadly];
        [self vanishWrongCircle:sender];
    }    
}

- (void)circleExpired:(AMGCircleButton *)sender
{
    if (![self.gameManager isItOkToTouchColor:sender.color]) {
        [self increaseCirclesAvoidedWell];
        [self vanishRightCircle:sender];
    } else {
        [self increaseCirclesAvoidedBadly];
        [self vanishWrongCircle:sender];
    }    
}

- (void)vanishRightCircle:(AMGCircleButton *)sender
{
    [sender removeTarget:self action:@selector(circleTouched:) forControlEvents:UIControlEventTouchUpInside];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(circleExpired:) object:sender];
    [sender disappearAsSuccess:self.soundActivated];
    [self.gameManager.circles performSelector:@selector(removeObject:)
                                   withObject:[[AMGCircle alloc] initWithX:sender.x y:sender.y color:nil]
                                   afterDelay:VANISH_DURATION_RIGHT];
}

- (void)vanishWrongCircle:(AMGCircleButton *)sender
{
    [sender removeTarget:self action:@selector(circleTouched:) forControlEvents:UIControlEventTouchUpInside];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(circleExpired:) object:sender];
    [sender disappearAsFailure:self.soundActivated];
    [self.gameManager.circles performSelector:@selector(removeObject:)
                                   withObject:[[AMGCircle alloc] initWithX:sender.x y:sender.y color:nil]
                                   afterDelay:VANISH_DURATION_WRONG_STEP1 + VANISH_DURATION_WRONG_STEP2];
}

- (void)showPageControl
{
    if (self.pageControlController) {
        [self.pageControlController animateArrowsInInfoController];
        return;
    }
    
    [self inactivateTimePlayingTimer];
    [self inactivateCircleCreationTimer];

    self.pageControlController = [[AMGPageControlController alloc] initWithDelegate:self];
    [self.pageControlController setTextForPlayButton];
    [self.pageControlController setTextForGameStatusLabel];
    [self.pageControlController setPageToShow];
    [self.view addSubview:self.pageControlController.view];
}

- (void)changeColors
{
    // Inactivating timers
    [self inactivateCircleCreationTimer];
    [self inactivateColorsChangingTimer];
    
    // Waiting until GameManager contains no circles
    if ([self.gameManager.circles count] != 0) {
        [self performSelector:@selector(changeColors) withObject:nil afterDelay:0.05f];
        return;
    }
    
    if (self.soundActivated) {
        // Sound to show that some colors to touch and avoid are going to change
        NSURL *sndurl = [[NSBundle mainBundle] URLForResource:@"changing" withExtension:@"wav"];
        SystemSoundID snd;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)sndurl, &snd);
        AudioServicesAddSystemSoundCompletion(snd, NULL, NULL, &SoundFinished, NULL);
        AudioServicesPlaySystemSound(snd);        
    }
    
    // Animation to show that some colors to touch and avoid are going to change
    UIView __block *v1 = [[UIView alloc] initWithFrame:CGRectMake(-5, MARGIN_TOP - 7, 8, 2)];
    if ([self gameStatus] == AMGGameStatusGamePlaying) {
        v1.backgroundColor = [UIColor blackColor];
    } else {
        v1.backgroundColor = [UIColor whiteColor];
    }
    v1.alpha = 0.75f;
    [self.view addSubview:v1];
    UIView __block *v2 = [[UIView alloc] initWithFrame:CGRectMake(-80, MARGIN_TOP - 7, 8, 2)];
    v2.backgroundColor = v1.backgroundColor;
    v2.alpha = 0.75f;
    [self.view addSubview:v2];
    [UIView animateWithDuration:COLORS_CHANGING_ALERT delay:0.0f
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAutoreverse)
                     animations:^() {
                         [UIView setAnimationRepeatCount:2];
                         v1.frame = CGRectMake(SCREEN_WIDTH, MARGIN_TOP - 7, 8, 2);
                         v2.frame = CGRectMake(SCREEN_WIDTH, MARGIN_TOP - 7, 8, 2);
                     }
                     completion:^(BOOL finished) {
                         [v1 removeFromSuperview];
                         [v2 removeFromSuperview];
                         // Changing colors
                         [self.gameManager makeSomeChangesInArraysWithColorsToTouchAndAvoid];
                         self.colorsPanel.colorsToTouch = self.gameManager.colorsToTouch;
                         self.colorsPanel.colorsToAvoid = self.gameManager.colorsToAvoid;
                         // Reactivating timers
                         if (!self.pageControlController) {
                             [self activateCircleCreationTimer:[self.gameManager nextCircleIntervalCreation]];
                         }
                         [self activateColorsChangingTimer];
                     }];
}

- (void)createNewCircle
{
    // Invalidating timer
    [self inactivateCircleCreationTimer];
    
    // Setting circle characteristics
    int x, y;
    // If it can't find a location in 10 tries, return NO and we'll try again later. This way
    // the GameManager will have the chance to remove some circles. Without this, when it can't
    // find a location it tries forever, as it blocks the app and no circles are ever removed
    // from GameManager, so no location can be ever found.
    if (![self.gameManager nextCirclePositionX:&x y:&y]) {
        [self activateCircleCreationTimer:0.1f];
        return;
    }
    UIColor *color = [self.gameManager nextCircleColor];

    // Creating AMGCircleButton and adding to main view
    AMGCircleButton *buttonCircle = [[AMGCircleButton alloc] initWithFrame:CGRectMake(x, y, BUTTON_SIZE, BUTTON_SIZE) color:color];
    buttonCircle.alpha = 0.85f;
    [self.view addSubview:buttonCircle];
    [buttonCircle addTarget:self action:@selector(circleTouched:) forControlEvents:UIControlEventTouchDown];
    
    // Creating AMGCircle and adding to GameManager
    [self.gameManager.circles addObject:[[AMGCircle alloc] initWithX:x y:y color:color]];
    
    [UIView animateWithDuration:0.7f delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                     animations:^() {
                         buttonCircle.alpha = 0.80f;
                         buttonCircle.transform = CGAffineTransformMakeScale(0.93f, 0.93f);
                     }
                     completion:nil];
    
    // Removing AMGCircleButton (from main view) and AMGCircle (from GameManager) after it expires
    [self performSelector:@selector(circleExpired:) withObject:buttonCircle afterDelay:[self.gameManager nextCircleLife]];
    
    // Reactivating timer
    [self activateCircleCreationTimer:[self.gameManager nextCircleIntervalCreation]];
    
    // Activating timePlayingTimer (it must be here to be sure a user cannot pause-resume-pause-
    // resume-... endlessly to add seconds without any circle being created)
    [self activateTimePlayingTimer];
}

#pragma mark -
#pragma mark NSTimers
#pragma mark -

- (void)activateTimePlayingTimer
{
    if (!self.timePlayingTimer) {
        self.timePlayingTimer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_SCORE_INTERVAL
                                                                 target:self
                                                               selector:@selector(increaseTimePlaying)
                                                               userInfo:nil
                                                                repeats:YES];
    }
}

- (void)activateColorsChangingTimer
{
    if (!self.colorsChangingTimer) {
        self.colorsChangingTimer = [NSTimer scheduledTimerWithTimeInterval:[self.gameManager nextColorsChangeInterval]
                                                                    target:self
                                                                  selector:@selector(changeColors)
                                                                  userInfo:nil
                                                                   repeats:YES];
    }
}

- (void)activateCircleCreationTimer:(float)interval
{
    if (!self.circleCreationTimer) {
        self.circleCreationTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                                    target:self
                                                                  selector:@selector(createNewCircle)
                                                                  userInfo:nil
                                                                   repeats:NO];
    }
}

- (void)inactivateTimePlayingTimer
{
    [self.timePlayingTimer invalidate];
    self.timePlayingTimer = nil;
}

- (void)inactivateColorsChangingTimer
{
    [self.colorsChangingTimer invalidate];
    self.colorsChangingTimer = nil;
}

- (void)inactivateCircleCreationTimer
{
    [self.circleCreationTimer invalidate];
    self.circleCreationTimer = nil;
}

#pragma mark -
#pragma mark AMGGameDelegate
#pragma mark -

- (void)userPressedResumeOrNewGame:(id)sender
{
    [self.pageControlController.view removeFromSuperview];
    self.pageControlController = nil;
    
    if ([self gameStatus] == AMGGameStatusGameOver) {
        self.gameManager = [[AMGGameManager alloc] init];
        self.colorsPanel.colorsToTouch = self.gameManager.colorsToTouch;
        self.colorsPanel.colorsToAvoid = self.gameManager.colorsToAvoid;
        [self.timePlayingButton setTitle:[NSString stringWithFormat:@"%i", self.gameManager.timePlaying] forState:UIControlStateNormal];
        self.livesRepresentation.livesRemaining = self.gameManager.livesRemaining;
    }
    
    [self activateCircleCreationTimer:[self.gameManager nextCircleIntervalCreation]];
}

- (int)circlesTouchedWell
{
    return self.gameManager.circlesTouchedWell;
}

- (int)circlesTouchedBadly
{
    return self.gameManager.circlesTouchedBadly;
}

- (int)circlesAvoidedWell
{
    return self.gameManager.circlesAvoidedWell;
}

- (int)circlesAvoidedBadly
{
    return self.gameManager.circlesAvoidedBadly;
}

- (int)timePlaying
{
    return self.gameManager.timePlaying;
}

- (int)livesRemaining
{
    return self.gameManager.livesRemaining;
}

- (AMGGameStatus)gameStatus
{
    if (!self.pageControlController && self.gameManager.livesRemaining > 0)
        return AMGGameStatusGamePlaying;
    
    if (self.gameManager.livesRemaining > 0 &&
        self.gameManager.timePlaying == 0 &&
        self.gameManager.circlesAvoidedBadly == 0 &&
        self.gameManager.circlesAvoidedWell == 0 &&
        self.gameManager.circlesTouchedBadly == 0 &&
        self.gameManager.circlesTouchedWell == 0)
        return AMGGameStatusBeforeFirstGame;
    
    if (self.gameManager.livesRemaining > 0)
        return AMGGameStatusGamePaused;
    
    if (self.gameManager.livesRemaining == 0)
        return AMGGameStatusGameOver;
    
    return AMGGameStatusUndefined;
}

#pragma mark -
#pragma mark Changes to Model properties with implications for the View part
#pragma mark -

- (void)increaseLivesRemaining
{
    if ([self gameStatus] == AMGGameStatusGameOver) return;
    
    // Model
    self.gameManager.livesRemaining += LIVES_ADDED_WHEN_RIGHT_TOUCH;
    
    // View
    self.livesRepresentation.livesRemaining = self.gameManager.livesRemaining;
}

- (void)decreaseLivesRemaining
{
    // Model
    self.gameManager.livesRemaining -= LIVES_SUBSTRACTED_WHEN_WRONG_TOUCH;
    
    // View
    self.livesRepresentation.livesRemaining = self.gameManager.livesRemaining;
    if (self.pageControlController) {
        [self.pageControlController someStatisticHasChanged];
    }
    
    // Controller
    if ([self gameStatus] == AMGGameStatusGameOver) {
        [self inactivateCircleCreationTimer];
        [self inactivateTimePlayingTimer];
        if (self.gameManager.timePlaying > [[NSUserDefaults standardUserDefaults] integerForKey:KEY_BEST_SCORE]) {
            [[NSUserDefaults standardUserDefaults] setInteger:self.gameManager.timePlaying forKey:KEY_BEST_SCORE];
        }
        // Checking AMGPageControlController isn't shown, as game can finish while paused
        if (!self.pageControlController) [self showPageControl];
    }
}

- (void)increaseTimePlaying
{
    // Model
    self.gameManager.timePlaying += UPDATE_SCORE_INTERVAL;
    
    // View
    [self.timePlayingButton setTitle:[NSString stringWithFormat:@"%i", self.gameManager.timePlaying]
                            forState:UIControlStateNormal];
}

- (void)increaseCirclesTouchedWell
{
    // Model
    self.gameManager.circlesTouchedWell++;
    
    // View
    if (self.pageControlController) {
        [self.pageControlController someStatisticHasChanged];
    }
    
    // Controller
    [self increaseLivesRemaining];
}

- (void)increaseCirclesTouchedBadly
{
    // Model
    self.gameManager.circlesTouchedBadly++;

    // View
    if (self.pageControlController) {
        [self.pageControlController someStatisticHasChanged];
    }
    
    // Controller
    [self decreaseLivesRemaining];
}

- (void)increaseCirclesAvoidedWell
{
    // Model
    self.gameManager.circlesAvoidedWell++;
    
    // View
    if (self.pageControlController) {
        [self.pageControlController someStatisticHasChanged];
    }
    
    // Controller
    [self increaseLivesRemaining];
}

- (void)increaseCirclesAvoidedBadly
{
    // Model
    self.gameManager.circlesAvoidedBadly++;

    // View
    if (self.pageControlController) {
        [self.pageControlController someStatisticHasChanged];
    }

    // Controller
    [self decreaseLivesRemaining];
}

#pragma mark -
#pragma mark Saving & loading game
#pragma mark -

- (void)saveGame
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.gameManager.timePlaying forKey:KEY_TIME_PLAYING];
    [userDefaults setInteger:self.gameManager.livesRemaining forKey:KEY_LIVES_REMAINING];
    [userDefaults setInteger:self.gameManager.circlesTouchedWell forKey:KEY_CIRCLES_TOUCHED_WELL];
    [userDefaults setInteger:self.gameManager.circlesTouchedBadly forKey:KEY_CIRCLES_TOUCHED_BADLY];
    [userDefaults setInteger:self.gameManager.circlesAvoidedWell forKey:KEY_CIRCLES_AVOIDED_WELL];
    [userDefaults setInteger:self.gameManager.circlesAvoidedBadly forKey:KEY_CIRCLES_AVOIDED_BADLY];
    [userDefaults setBool:self.soundActivated forKey:KEY_SOUND_ACTIVATED];
    [userDefaults synchronize];
}

- (void)loadGame
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    // Model
    if ([userDefaults integerForKey:KEY_TIME_PLAYING] != 0 || [userDefaults integerForKey:KEY_LIVES_REMAINING] != 0) {
        self.gameManager.timePlaying = [userDefaults integerForKey:KEY_TIME_PLAYING];
        self.gameManager.livesRemaining = [userDefaults integerForKey:KEY_LIVES_REMAINING];
        self.gameManager.circlesTouchedWell = [userDefaults integerForKey:KEY_CIRCLES_TOUCHED_WELL];
        self.gameManager.circlesTouchedBadly = [userDefaults integerForKey:KEY_CIRCLES_TOUCHED_BADLY];
        self.gameManager.circlesAvoidedWell = [userDefaults integerForKey:KEY_CIRCLES_AVOIDED_WELL];
        self.gameManager.circlesAvoidedBadly = [userDefaults integerForKey:KEY_CIRCLES_AVOIDED_BADLY];
        self.soundActivated = [userDefaults boolForKey:KEY_SOUND_ACTIVATED];
    }
    
    // View
    [self.timePlayingButton setTitle:[NSString stringWithFormat:@"%i", self.gameManager.timePlaying] forState:UIControlStateNormal];
    self.livesRepresentation.livesRemaining = self.gameManager.livesRemaining;
}

#pragma mark -
#pragma mark Auxiliary C functions
#pragma mark -

void SoundFinished (SystemSoundID snd, void* context)
{
    AudioServicesRemoveSystemSoundCompletion(snd);
    AudioServicesDisposeSystemSoundID(snd);
}

@end