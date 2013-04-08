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

#define KEY_TIME_PLAYING @"timePlaying"
#define KEY_LIVES_REMAINING @"livesRemaining"
#define KEY_CIRCLES_TOUCHED_WELL @"circlesTouchedWell"
#define KEY_CIRCLES_TOUCHED_BADLY @"circlesTouchedBadly"
#define KEY_CIRCLES_AVOIDED_WELL @"circlesAvoidedWell"
#define KEY_CIRCLES_AVOIDED_BADLY @"circlesAvoidedBadly"
#define KEY_SOUND_ACTIVATED @"soundActivated"

@implementation AMGMainController

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
    AMGColorsPanel *cp = [[AMGColorsPanel alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        SCREEN_WIDTH,
                                                                        MARGIN_TOP)
                                            andColorsToTouch:self.gameManager.colorsToTouch
                                            andColorsToAvoid:self.gameManager.colorsToAvoid];
    self.colorsPanel = cp;
    self.colorsPanel.backgroundColor = [UIColor clearColor];
    self.colorsPanel.alpha = 0.8f;
    [self.view addSubview:self.colorsPanel];

    // Add timePlayingButton (10, 10, 90 and 40 are correct absolute values for position and size)
    UIButton *tpb = [[UIButton alloc] initWithFrame:CGRectMake(10,
                                                               SCREEN_HEIGHT - MARGIN_BOTTOM + 12,
                                                               90,
                                                               40)];
    self.timePlayingButton = tpb;
    [self.timePlayingButton setTitle:[NSString stringWithFormat:@"%i", self.gameManager.timePlaying] forState:UIControlStateNormal];
    [self.timePlayingButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.timePlayingButton.titleLabel.frame = self.timePlayingButton.frame;
    self.timePlayingButton.titleLabel.font = [UIFont fontWithName:APP_MAIN_FONT size:32.0];
    [self.timePlayingButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.timePlayingButton addTarget:self action:@selector(showPageControl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timePlayingButton];
    
    // Add livesRepresentation (10, 19, 14 and 23 are correct absolute values for position and size)
    int x = 10 + self.timePlayingButton.frame.origin.x + self.timePlayingButton.frame.size.width;
    AMGLivesRepresentation *lr = [[AMGLivesRepresentation alloc] initWithFrame:CGRectMake(x,
                                                                                        SCREEN_HEIGHT - MARGIN_BOTTOM + 19,
                                                                                        SCREEN_WIDTH - x - 14,
                                                                                        23)
                                                           andLivesRemaining:self.gameManager.livesRemaining];
    self.livesRepresentation = lr;
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

void SoundFinished (SystemSoundID snd, void* context)
{
    AudioServicesRemoveSystemSoundCompletion(snd);
    AudioServicesDisposeSystemSoundID(snd);
}

- (void)vanishRightCircle:(AMGCircleButton *)sender
{
    [sender removeTarget:self action:@selector(circleTouched:) forControlEvents:UIControlEventTouchUpInside];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(circleExpired:) object:sender];
    
    if (self.soundActivated) {
        NSURL *sndurl = [[NSBundle mainBundle] URLForResource:@"right" withExtension:@"aif"];
        SystemSoundID snd;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)sndurl, &snd);
        AudioServicesAddSystemSoundCompletion(snd, NULL, NULL, &SoundFinished, NULL);
        AudioServicesPlaySystemSound(snd);        
    }
    
    [UIView animateWithDuration:VANISH_DURATION_RIGHT
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^() {
                         sender.frame = CGRectMake(sender.frame.origin.x + sender.frame.size.width / 2,
                                                   sender.frame.origin.y + sender.frame.size.height / 2,
                                                   0, 0);
                         sender.alpha = 0.2f;
                     }
                     completion:^(BOOL finished) {
                         [sender removeFromSuperview];
                     }];
    
    [self.gameManager.circles performSelector:@selector(removeObject:)
                                   withObject:[[AMGCircle alloc] initWithX:sender.frame.origin.x - BUTTON_SIZE / 2
                                                                     andY:sender.frame.origin.y - BUTTON_SIZE / 2
                                                                 andColor:nil]
                                   afterDelay:VANISH_DURATION_RIGHT];
}

- (void)vanishWrongCircle:(AMGCircleButton *)sender
{
    [sender removeTarget:self action:@selector(circleTouched:) forControlEvents:UIControlEventTouchUpInside];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(circleExpired:) object:sender];
    
    if (self.soundActivated) {
        NSURL *sndurl = [[NSBundle mainBundle] URLForResource:@"wrong" withExtension:@"aif"];
        SystemSoundID snd;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)sndurl, &snd);
        AudioServicesAddSystemSoundCompletion(snd, NULL, NULL, &SoundFinished, NULL);
        AudioServicesPlaySystemSound(snd);
    }
    
    sender.color = [UIColor colorWithRed:0.01f green:0.01f blue:0.01f alpha:1.0f];
    sender.alpha = 0.85f;
    
    // Delay execution of my block for VANISH_DURATION_WRONG_STEP1 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, VANISH_DURATION_WRONG_STEP1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [UIView animateWithDuration:VANISH_DURATION_WRONG_STEP2
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^() {
                             sender.frame = CGRectMake(sender.frame.origin.x + sender.frame.size.width / 2,
                                                       sender.frame.origin.y + sender.frame.size.height / 2,
                                                       0, 0);
                             sender.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [sender removeFromSuperview];
                         }];
        [self.gameManager.circles performSelector:@selector(removeObject:)
                                       withObject:[[AMGCircle alloc] initWithX:sender.frame.origin.x - BUTTON_SIZE / 2
                                                                         andY:sender.frame.origin.y - BUTTON_SIZE / 2
                                                                     andColor:nil]
                                       afterDelay:VANISH_DURATION_WRONG_STEP2];
    });
}

- (void)showPageControl:(id)sender
{
    if (self.pageControlController) {
        [self.pageControlController animateArrowsInInfoController];
        return;
    }
    
    [self inactivateTimePlayingTimer];
    [self inactivateCircleCreationTimer];
    
    int page = ([self gameStatus] == AMGGameStatusGamePlaying ||
                [self gameStatus] == AMGGameStatusGamePaused ||
                [self gameStatus] == AMGGameStatusGameOver) ? 1 : 0;
    self.pageControlController = [[AMGPageControlController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                    andDelegate:self
                                                                  andPageToShow:page];
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
                             [self activateCircleCreationTimer:[self nextIntervalForCircleCreation]];
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
    int tries = 0;
    do {
        // If it can't find a location in 10 tries, try it again after 0.1 second, so the GameManager can remove some circles.
        // Without this, when it can't find a location it tries forever, as it blocks the app and so no circles are removed
        // from GameManager, so no location can be ever found.
        if (tries++ > 10) {
            [self activateCircleCreationTimer:0.1f];
            return;
        }
        x = MARGIN_BUTTON + (arc4random() % ((int)SCREEN_WIDTH - BUTTON_SIZE - MARGIN_BUTTON * 2));
        y = MARGIN_TOP + MARGIN_BUTTON + (arc4random() % ((int)SCREEN_HEIGHT - BUTTON_SIZE - MARGIN_TOP - MARGIN_BOTTOM - MARGIN_BUTTON * 2));

    } while (![self.gameManager isItOkToPutACircleInPositionWithX:x andY:y]);
    UIColor *color = [self.gameManager randomColor];

    // Creating AMGCircleButton and adding to main view
    AMGCircleButton *buttonCircle = [[AMGCircleButton alloc] initWithFrame:CGRectMake(x, y, BUTTON_SIZE, BUTTON_SIZE) andColor:color];
    buttonCircle.alpha = 0.85f;
    [self.view addSubview:buttonCircle];
    [buttonCircle addTarget:self action:@selector(circleTouched:) forControlEvents:UIControlEventTouchDown];
    
    // Creating AMGCircle and adding to GameManager
    AMGCircle *circle = [[AMGCircle alloc] initWithX:buttonCircle.frame.origin.x
                                              andY:buttonCircle.frame.origin.y
                                          andColor:buttonCircle.color];
    [self.gameManager.circles addObject:circle];
    
    [UIView animateWithDuration:0.7f delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                     animations:^() {
                         buttonCircle.alpha = 0.80f;//0.65f;
                         buttonCircle.transform = CGAffineTransformMakeScale(0.93f, 0.93f);
                     }
                     completion:nil];
    
    // Removing AMGCircleButton (from main view) and AMGCircle (from GameManager) after it expires
    float circleLife = [self nextCircleLife];
    [self performSelector:@selector(circleExpired:) withObject:buttonCircle afterDelay:circleLife];
    
    // Reactivating timer
    [self activateCircleCreationTimer:[self nextIntervalForCircleCreation]];
    
    // Activating timePlayingTimer (it must be here to be sure a user cannot pause-resume-pause-
    // resume-... endlessly to add seconds without any circle being created)
    [self activateTimePlayingTimer];
}

- (float)nextIntervalForCircleCreation
{
    int min = 10.0f * MAX(MIN_CIRCLE_CREATION_INTERVAL + 0.4f - (0.1f * self.gameManager.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_CREATION_INTERVAL);
    int max = 10.0f * MAX(MAX_CIRCLE_CREATION_INTERVAL - (0.1f * self.gameManager.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_CREATION_INTERVAL + 0.3f);
    float temp = (min + (arc4random() % (max - min))) / 10.0f;
    // NSLog(@"nextIntervalForCircleCreation > time = %i - min = %i - max = %i - val = %.1f", self.gameManager.timePlaying, min, max, temp);
    return temp;
}

- (float)nextCircleLife
{
    int min = 10.0f * MAX(MIN_CIRCLE_LIFE + 1.0f - (0.1f * self.gameManager.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_LIFE);
    int max = 10.0f * MAX(MAX_CIRCLE_LIFE - (0.1f * self.gameManager.timePlaying / DECREASE_MAX_AND_MIN_INTERVAL_EVERY), MIN_CIRCLE_LIFE + 0.5f); 
    float temp = (min + (arc4random() % (max - min))) / 10.0f;
    // NSLog(@"nextCircleLife > time = %i - min = %i - max = %i - val = %.1f", self.gameManager.timePlaying, min, max, temp);
    return temp;
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
        self.colorsChangingTimer = [NSTimer scheduledTimerWithTimeInterval:CHANGE_COLORS_INTERVAL
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
    
    [self activateCircleCreationTimer:[self nextIntervalForCircleCreation]];
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
        // Checking AMGPageControlController isn't shown, as game can finish while paused
        if (!self.pageControlController) [self showPageControl:nil];
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
#pragma mark Memory management
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"AMGMainController > didReceiveMemoryWarning");
}

@end