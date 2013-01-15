//
//  AMAboutController.m
//  Test01
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMAboutController.h"
#import "AMPageControlController.h"

#define TURN_SOUND_ON NSLocalizedString(@"Turn sound on", @"Settings screen")
#define TURN_SOUND_OFF NSLocalizedString(@"Turn sound off", @"Settings screen")

@implementation AMAboutController

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f) andDelegate:nil];
}

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGameDelegate>)delegate
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
    AMGrayButton *sb = [[AMGrayButton alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, buttonHeight)
                                             andImageNamed:nil
                                                   andText:nil];
    self.soundButton = sb;
    if ([self.delegate soundActivated]) {
        self.soundButton.imageNamed = IMG_SOUND_ON;
        self.soundButton.text = TURN_SOUND_OFF;
    } else {
        self.soundButton.imageNamed = IMG_SOUND_OFF;
        self.soundButton.text = TURN_SOUND_ON;
    }
    [self.view addSubview:self.soundButton];
    [self.soundButton addTarget:self action:@selector(soundButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button for rating on AppStore
    AMGrayButton *rateButton = [[AMGrayButton alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, buttonHeight)
                                                     andImageNamed:IMG_RATE
                                                           andText:[NSString stringWithFormat:NSLocalizedString(@"Love %@? Rate it!", @"Settings screen"), APP_NAME]];
    [self.view addSubview:rateButton];
    [rateButton addTarget:self action:@selector(rateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button for following on Twitter
    AMGrayButton *twitterButton = [[AMGrayButton alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, buttonHeight)
                                                        andImageNamed:IMG_TWITTER
                                                              andText:[NSString stringWithFormat:NSLocalizedString(@"Follow @%@ on Twitter", @"Settings screen"), APP_TWITTER]];
    [self.view addSubview:twitterButton];
    [twitterButton addTarget:self action:@selector(twitterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Credits at the bottom
    UILabel *about = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 85, self.view.frame.size.width, 85)];
    about.font = [UIFont fontWithName:APP_MAIN_FONT size:13.0f];
    about.numberOfLines = 0;
    about.text = [NSString stringWithFormat:NSLocalizedString(@"Version %@\nCopyright © %@.\nAll rights reserved.", @"Settings screen"), APP_VERSION, APP_COPYRIGHT];
    about.textAlignment = NSTextAlignmentCenter;
    about.backgroundColor = [UIColor clearColor];
    about.textColor = [UIColor whiteColor];
    [self.view addSubview:about];
}

- (void)soundButtonPressed:(id)sender
{
    if ([self.delegate soundActivated]) {
        self.soundButton.imageNamed = IMG_SOUND_OFF;
        self.soundButton.text = TURN_SOUND_ON;
        [self.delegate setSoundActivated:NO];
    } else {
        self.soundButton.imageNamed = IMG_SOUND_ON;
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
    NSLog(@"AMAboutController > didReceiveMemoryWarning");
}

@end
