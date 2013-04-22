//
//  AMGConstants.h
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

//
// App constants
//
#define APP_NAME      @"Circlestouch"
#define APP_VERSION   @"1.1"
#define APP_COPYRIGHT @"2013 Albert Mata"
#define APP_MAIN_FONT @"Heiti SC"
#define APP_EMAIL     @"hello@albertmata.net"
#define APP_WEB_URL   @"http://www.circlestouch.com"
#define APP_RATE_URL  @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=631303202"

//
// Macros
//
#define IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)

//
// User defaults keys
//
#define KEY_TIME_PLAYING          @"timePlaying"
#define KEY_LIVES_REMAINING       @"livesRemaining"
#define KEY_CIRCLES_TOUCHED_WELL  @"circlesTouchedWell"
#define KEY_CIRCLES_TOUCHED_BADLY @"circlesTouchedBadly"
#define KEY_CIRCLES_AVOIDED_WELL  @"circlesAvoidedWell"
#define KEY_CIRCLES_AVOIDED_BADLY @"circlesAvoidedBadly"
#define KEY_SOUND_ACTIVATED       @"soundActivated"
#define KEY_BEST_SCORE            @"bestScore"

//
// Possible game status
//
typedef enum {
    AMGGameStatusBeforeFirstGame,
    AMGGameStatusGamePaused,
    AMGGameStatusGameOver,
    AMGGameStatusGamePlaying,
    AMGGameStatusUndefined
} AMGGameStatus;

//
// Device dimensions
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//
// Game logic values
//
#define NUM_COLORS                         9
#define NUM_COLORS_TOUCH_INITIAL           5
#define MAX_LIVES                          100
#define MIN_LIVES                          0
#define INITIAL_LIVES                      10
#define LIVES_ADDED_WHEN_RIGHT_TOUCH       1
#define LIVES_SUBSTRACTED_WHEN_WRONG_TOUCH 4

//
// Main game area
//
#define BUTTON_SIZE            72
#define MARGIN_BUTTON          5
#define BACKGROUND_SQUARE_SIZE 11

//
// Screen's top & bottom areas
//
#define MARGIN_TOP         50
#define MARGIN_BOTTOM      58
#define PAGECONTROL_DOTS_Y (SCREEN_HEIGHT - MARGIN_BOTTOM - 100)

//
// Minicircles at the top area
//
#define MARGIN_TOPMOST        11
#define MARGIN_LEFTMOST       11
#define MARGIN_RIGHTMOST      14
#define MINICIRCLE_SEPARATION 4
#define MINICIRCLE_DIAMETER   25

//
// Durations for animations
//
#define VANISH_DURATION_RIGHT       0.4f
#define VANISH_DURATION_WRONG_STEP1 0.1f
#define VANISH_DURATION_WRONG_STEP2 0.7f
#define COLORS_CHANGING_ALERT       0.18f

//
// Time intervals
//
#define CHANGE_COLORS_INTERVAL_MAX          35.0f
#define CHANGE_COLORS_INTERVAL_MIN          18.0f
#define UPDATE_SCORE_INTERVAL               1
// Difference between MAX and MIN must be at least 0.5f
#define MAX_CIRCLE_CREATION_INTERVAL        2.0f
#define MIN_CIRCLE_CREATION_INTERVAL        0.2f
// Difference between MAX and MIN must be at least 1.1f
#define MAX_CIRCLE_LIFE                     4.0f
#define MIN_CIRCLE_LIFE                     1.2f
#define DECREASE_MAX_AND_MIN_INTERVAL_EVERY 12



