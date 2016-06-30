//
//  AMGAboutController.m
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGAboutController.h"
#import "AMGPageControlController.h"
#import "AMGUIControls/AMGPlainRectButton.h"

#define TURN_SOUND_ON NSLocalizedString(@"Turn sound on", @"Settings screen")
#define TURN_SOUND_OFF NSLocalizedString(@"Turn sound off", @"Settings screen")

@interface AMGAboutController()
@property (nonatomic, weak) id<AMGGameDelegate> gameDelegate;
@property (nonatomic, strong) AMGPlainRectButton *soundButton;
@end

@implementation AMGAboutController

#pragma mark - Drawing view

- (id)initWithGameDelegate:(id<AMGGameDelegate>)gameDelegate
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _gameDelegate = gameDelegate;
        [self setup];
    }
    return self;
}

- (void)setup
{
    float availableHeight = PAGECONTROL_DOTS_Y - MARGIN_TOP;
    float spaceHeight = (availableHeight - 4 * 55.0f) / 5;
    float y = MARGIN_TOP + spaceHeight;
    
    // Sound button
    
    self.soundButton = [[AMGPlainRectButton alloc] initWithFrame:CGRectMake(0.0f, y, 320.0f, 55.0f)
                                                 backgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.1f alpha:1.0f]
                                                       imageName:nil
                                                        fontName:APP_MAIN_FONT
                                                            text:nil];
    self.soundButton.whiteBorder = NO;
    self.soundButton.imageName = ([self.gameDelegate soundActivated]) ? @"sound_on" : @"sound_off";
    self.soundButton.text = ([self.gameDelegate soundActivated]) ? TURN_SOUND_OFF : TURN_SOUND_ON;
    y += 55.0f + spaceHeight;
    
    // Web button
    
    /*
    AMGPlainRectButton *webButton = [[AMGPlainRectButton alloc] initWithFrame:CGRectMake(0.0f, y, 320.0f, 55.0f)
                                                              backgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.1f alpha:1.0f]
                                                                    imageName:@"web"
                                                                     fontName:APP_MAIN_FONT
                                                                         text:[NSString stringWithFormat:NSLocalizedString(@"Visit %@'s website", @"Settings screen"), APP_NAME]];
    webButton.whiteBorder = NO;
    y += 55.0f + spaceHeight;
    */
    
    // Email button
    
    AMGPlainRectButton *emailButton = [[AMGPlainRectButton alloc] initWithFrame:CGRectMake(0.0f, y, 320.0f, 55.0f)
                                                                backgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.1f alpha:1.0f]
                                                                      imageName:@"email"
                                                                       fontName:APP_MAIN_FONT
                                                                           text:[NSString stringWithFormat:NSLocalizedString(@"Send me an email", @"Settings screen")]];
    emailButton.whiteBorder = NO;
    y += 55.0f + spaceHeight;
    
    // Rate button
    
    AMGPlainRectButton *rateButton = [[AMGPlainRectButton alloc] initWithFrame:CGRectMake(0.0f, y, 320.0f, 55.0f)
                                                               backgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.1f alpha:1.0f]
                                                                     imageName:@"rate"
                                                                      fontName:APP_MAIN_FONT
                                                                          text:[NSString stringWithFormat:NSLocalizedString(@"Love %@? Rate it! :)", @"Settings screen"), APP_NAME]];
    rateButton.whiteBorder = NO;
    
    // Adding buttons to view and setting target actions.
    
    [self.view addSubview:self.soundButton];
    //[self.view addSubview:webButton];
    [self.view addSubview:emailButton];
    [self.view addSubview:rateButton];
    
    [self.soundButton addTarget:self action:@selector(changeSound) forControlEvents:UIControlEventTouchUpInside];
    //[webButton addTarget:self action:@selector(openWeb) forControlEvents:UIControlEventTouchUpInside];
    [emailButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [rateButton addTarget:self action:@selector(rateApp) forControlEvents:UIControlEventTouchUpInside];
    
    // Credits at the bottom
    
    UILabel *credits1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, PAGECONTROL_DOTS_Y + 25.0f, 320.0f, 20.0f)];
    credits1.font = [UIFont fontWithName:APP_MAIN_FONT size:13.0f];
    credits1.text = [NSString stringWithFormat:APP_NAME];
    credits1.textAlignment = NSTextAlignmentCenter;
    credits1.backgroundColor = [UIColor clearColor];
    credits1.textColor = [UIColor whiteColor];
    [self.view addSubview:credits1];
    
    UILabel *credits2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, PAGECONTROL_DOTS_Y + 45.0f, 320.0f, 20.0f)];
    credits2.font = [UIFont fontWithName:APP_MAIN_FONT size:13.0f];
    credits2.text = [NSString stringWithFormat:NSLocalizedString(@"Version %@", @"Settings screen"), APP_VERSION];
    credits2.textAlignment = NSTextAlignmentCenter;
    credits2.backgroundColor = [UIColor clearColor];
    credits2.textColor = [UIColor whiteColor];
    [self.view addSubview:credits2];

    
    UILabel *credits3 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, PAGECONTROL_DOTS_Y + 65.0f, 320.0f, 20.0f)];
    credits3.font = [UIFont fontWithName:APP_MAIN_FONT size:13.0f];
    credits3.text = [NSString stringWithFormat:NSLocalizedString(@"© %@", @"Settings screen"), APP_COPYRIGHT];
    credits3.textAlignment = NSTextAlignmentCenter;
    credits3.backgroundColor = [UIColor clearColor];
    credits3.textColor = [UIColor whiteColor];
    [self.view addSubview:credits3];
}

#pragma mark - Button's target actions

- (void)changeSound
{
    if (self.gameDelegate.soundActivated) {
        self.soundButton.imageName = @"sound_off";
        self.soundButton.text = TURN_SOUND_ON;
        self.gameDelegate.soundActivated = NO;
    } else {
        self.soundButton.imageName = @"sound_on";
        self.soundButton.text = TURN_SOUND_OFF;
        self.gameDelegate.soundActivated = YES;
    }
}

- (void)sendEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self.emailDelegate;
        [controller setToRecipients:@[APP_EMAIL]];
        [controller setSubject:[NSString stringWithFormat:@"%@ %@", APP_NAME, APP_VERSION]];
        [controller setMessageBody:@"" isHTML:NO];
        if (controller) [(UIViewController *)self.emailDelegate presentViewController:controller animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@", APP_NAME, APP_VERSION]
                                    message:NSLocalizedString(@"No email message", @"Settings screen")
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"Settings screen")
                          otherButtonTitles: nil] show];
    }
}

- (void)openWeb
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_WEB_URL]];
}

- (void)rateApp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_RATE_URL]];
}

@end