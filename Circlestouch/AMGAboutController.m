//
//  AMGAboutController.m
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGAboutController.h"
#import "AMGPageControlController.h"

#define TURN_SOUND_ON NSLocalizedString(@"Turn sound on", @"Settings screen")
#define TURN_SOUND_OFF NSLocalizedString(@"Turn sound off", @"Settings screen")

@implementation AMGAboutController

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f) andDelegate:nil];
}

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGGameDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.view.frame = viewFrame;
        self.delegate = delegate;
    }
    [self drawUserInterface];
    return self;
}

- (void)drawUserInterface
{
    float buttonHeight = 55;

    // Button for turn sound on and off
    AMGBlackRectButton *sb = [[AMGBlackRectButton alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, buttonHeight)
                                                          andImageName:nil
                                                           andFontName:APP_MAIN_FONT
                                                               andText:nil];
    self.soundButton = sb;
    self.soundButton.whiteBorder = NO;
    if ([self.delegate soundActivated]) {
        self.soundButton.imageName = IMG_SOUND_ON;
        self.soundButton.text = TURN_SOUND_OFF;
    } else {
        self.soundButton.imageName = IMG_SOUND_OFF;
        self.soundButton.text = TURN_SOUND_ON;
    }
    [self.view addSubview:self.soundButton];
    [self.soundButton addTarget:self action:@selector(soundButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button for rating on AppStore
    AMGBlackRectButton *rateButton = [[AMGBlackRectButton alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, buttonHeight)
                                                                  andImageName:IMG_RATE
                                                                   andFontName:APP_MAIN_FONT
                                                                       andText:[NSString stringWithFormat:NSLocalizedString(@"Love %@? Rate it!", @"Settings screen"), APP_NAME]];
    rateButton.whiteBorder = NO;
    [self.view addSubview:rateButton];
    [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button for following on Twitter
    AMGBlackRectButton *twitterButton = [[AMGBlackRectButton alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, buttonHeight)
                                                                     andImageName:IMG_TWITTER
                                                                      andFontName:APP_MAIN_FONT
                                                                          andText:[NSString stringWithFormat:NSLocalizedString(@"Follow @%@ on Twitter", @"Settings screen"), APP_TWITTER]];
    twitterButton.whiteBorder = NO;
    [self.view addSubview:twitterButton];
    [twitterButton addTarget:self action:@selector(twitterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Credits at the bottom
    UILabel *about = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 85, self.view.frame.size.width, 85)];
    about.font = [UIFont fontWithName:APP_MAIN_FONT size:13.0f];
    about.numberOfLines = 0;
    about.text = [NSString stringWithFormat:NSLocalizedString(@"Version %@\nCopyright © %@\nAll rights reserved", @"Settings screen"), APP_VERSION, APP_COPYRIGHT];
    about.textAlignment = NSTextAlignmentCenter;
    about.backgroundColor = [UIColor clearColor];
    about.textColor = [UIColor whiteColor];
    [self.view addSubview:about];
}

- (void)soundButtonPressed:(id)sender
{
    if ([self.delegate soundActivated]) {
        self.soundButton.imageName = IMG_SOUND_OFF;
        self.soundButton.text = TURN_SOUND_ON;
        [self.delegate setSoundActivated:NO];
    } else {
        self.soundButton.imageName = IMG_SOUND_ON;
        self.soundButton.text = TURN_SOUND_OFF;
        [self.delegate setSoundActivated:YES];
    }
}

- (void)rateButtonPressed:(id)sender
{
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APP_ID_IN_APP_STORE];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)twitterButtonPressed:(id)sender
{
    NSString *str = [NSString stringWithFormat:@"twitter://user?screen_name=%@", APP_TWITTER];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark -
#pragma mark Memory management
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"AMGAboutController > didReceiveMemoryWarning");
}

@end
