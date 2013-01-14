//
//  AMConstants.h
//  Test01
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

//
// App constants
//
#define APP_NAME @"Nine Bubbles"
#define APP_ID_IN_APP_STORE @""
#define APP_VERSION @"1.0"
#define APP_COPYRIGHT @"Albert Mata 2012-2013"
#define APP_TWITTER @"almata"

//
// Possible game status
//
typedef enum {
    AMGameStatusBeforeFirstGame,
    AMGameStatusGamePaused,
    AMGameStatusGameOver,
    AMGameStatusUndefined
} AMGameStatus;

//
// Device dimensions
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//
// Game logic values
//
#define NUM_COLORS 9
#define NUM_COLORS_TOUCH_INITIAL 5
#define MAX_LIVES 100
#define MIN_LIVES 0
#define INITIAL_LIVES 10
#define LIVES_ADDED_WHEN_RIGHT_TOUCH 1
#define LIVES_SUBSTRACTED_WHEN_WRONG_TOUCH 4

//
// Main game area
//
#define BUTTON_SIZE 72
#define MARGIN_BUTTON 5
#define BACKGROUND_SQUARE_SIZE 11

//
// Screen's top & bottom areas
//
#define MARGIN_TOP 50
#define MARGIN_BOTTOM 58

//
// Minicircles at the top area
//
#define MARGIN_TOPMOST 11
#define MARGIN_LEFTMOST 11
#define MARGIN_RIGHTMOST 14
#define MINICIRCLE_SEPARATION 4
#define MINICIRCLE_DIAMETER 25

//
// Durations for animations
//
#define VANISH_DURATION_RIGHT 0.4f
#define VANISH_DURATION_WRONG_STEP1 0.1f
#define VANISH_DURATION_WRONG_STEP2 0.7f
#define COLORS_CHANGING_ALERT 0.18f

//
// Time intervals
//
#define CHANGE_COLORS_INTERVAL 20.0f
#define UPDATE_SCORE_INTERVAL 1
// Difference between MAX and MIN must be at least 0.5f
#define MAX_CIRCLE_CREATION_INTERVAL 1.3f
#define MIN_CIRCLE_CREATION_INTERVAL 0.2f
// Difference between MAX and MIN must be at least 1.1f
#define MAX_CIRCLE_LIFE 2.4f
#define MIN_CIRCLE_LIFE 0.9f
#define DECREASE_MAX_AND_MIN_INTERVAL_EVERY 10

//
// Images
//
#define IMG_ARROW_TOP_LEFT @"top_left"
#define IMG_ARROW_TOP_RIGHT @"top_right"
#define IMG_ARROW_BOTTOM_LEFT @"bottom_left"
#define IMG_ARROW_BOTTOM_RIGHT @"bottom_right"
#define IMG_SOUND_ON @"sound_on"
#define IMG_SOUND_OFF @"sound_off"
#define IMG_TWITTER @"twitter"
#define IMG_RATE @"rate" 

//
// TODOs
// ---------------------------------------------
//
// TODO: Afegir integració amb GameCenter.
// TODO: Publicar scores a Twitter i Facebook.
// TODO: Afegir link a la pàgina web dins de l'app.
// TODO: Canviar les Launch Screen per unes amb aM.
// TODO: Refer la icona principal (9 boles?).
// TODO: Fer la pàgina web de l'app (domini propi o xxx.albertmata.net).
// TODO: Enviar textos definitius als traductors (Mouni, JJ, Jeroen, Nicole, Toni, Pedro, (gallec), (euskera)).
// TODO: Afegir totes les traduccions i18n i comprovar que funcionin.
// TODO: Escriure un bon post tècnic explicant aspectes de l'app.

//
// TODOs (després de publicar la primera versió)
// ---------------------------------------------
//
// TODO: Preparar versió per iPad.
// TODO: Mirar com de fàcil/difícil seria fer versió per Windows8.
// TODO: Versió especial per kids.


