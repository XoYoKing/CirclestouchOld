//
//  AMGInfoController.m
//  Circlestouch
//
//  Created by Albert Mata on 05/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGInfoController.h"

@interface AMGInfoController()
@property (nonatomic, strong) UIImageView *topLeftArrow;
@property (nonatomic, strong) UIImageView *topRightArrow;
@property (nonatomic, strong) UIImageView *bottomLeftArrow;
@property (nonatomic, strong) UIImageView *bottomRightArrow;
@end

@implementation AMGInfoController

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
    [self addArrows];
    [self animateArrows];
    
    UIColor *color = [UIColor whiteColor];
    UIColor *backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont fontWithName:APP_MAIN_FONT size:14.0f];
    UIFont *mainFont = [UIFont fontWithName:APP_MAIN_FONT size:19.0f];
    float alpha = 0.7f;
    
    float y, height;
    
    // "Colors to touch"
    
    height = 30.0f;
    y = MARGIN_TOP + 25.0f;
    UILabel *colorsTouch = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, y, SCREEN_WIDTH / 2 - 20.0f, height)];
    colorsTouch.text = NSLocalizedString(@"Colors to touch", @"Info screen");
    colorsTouch.textColor = color;
    colorsTouch.backgroundColor = backgroundColor;
    colorsTouch.alpha = alpha;
    colorsTouch.font = font;
    [self.view addSubview:colorsTouch];
    
    // "Colors to avoid"
    
    height = 30.0f;
    y = MARGIN_TOP + 25.0f;
    UILabel *colorsAvoid = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 10.0f, y, SCREEN_WIDTH / 2 - 20.0f, height)];
    colorsAvoid.text = NSLocalizedString(@"Colors to avoid", @"Info screen");
    colorsAvoid.textAlignment = NSTextAlignmentRight;
    colorsAvoid.textColor = color;
    colorsAvoid.backgroundColor = backgroundColor;
    colorsAvoid.alpha = alpha;
    colorsAvoid.font = font;
    [self.view addSubview:colorsAvoid];

    // "Current score - (tap to pause)"
    
    height = 50.0f;
    y = SCREEN_HEIGHT - MARGIN_BOTTOM - height - 25.0f;
    UILabel *currentScore = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, y, SCREEN_WIDTH / 2 - 20.0f, height)];
    currentScore.text = NSLocalizedString(@"Current score\n(tap to pause)", @"Info screen");
    currentScore.numberOfLines = 0;
    currentScore.textColor = color;
    currentScore.backgroundColor = backgroundColor;
    currentScore.alpha = alpha;
    currentScore.font = font;
    [self.view addSubview:currentScore];
    
    // "Remaining lives"
    
    height = 30.0f;
    y = SCREEN_HEIGHT - MARGIN_BOTTOM - height - 25.0f;
    UILabel *power = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 10.0f, y, SCREEN_WIDTH / 2 - 20.0f, height)];
    power.text = NSLocalizedString(@"Remaining lives", @"Info screen");
    power.textAlignment = NSTextAlignmentRight;
    power.textColor = color;
    power.backgroundColor = backgroundColor;
    power.alpha = alpha;
    power.font = font;
    [self.view addSubview:power];
    
    // Button to start or resume game
    
    self.playButton = [[AMGBlackRectButton alloc] initWithFrame:CGRectMake(0.0f, PAGECONTROL_DOTS_Y - 70.0f, SCREEN_WIDTH, 60.0f)
                                                   andImageName:nil
                                                    andFontName:APP_MAIN_FONT
                                                        andText:nil];
    self.playButton.whiteBorder = NO;
    self.playButton.textHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[self.playButton addTarget:self.delegate action:@selector(userPressedResumeOrNewGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
    // Main game explanation in the middle of the screen
    
    y = MARGIN_TOP + (IS_WIDESCREEN ? 90.0f : 50.0f);
    UILabel *main = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, y, SCREEN_WIDTH - 60.0f, 150.0f)];
    main.text = NSLocalizedString(@"Touch the right circles before they turn black to achieve the highest score! "
                                  "Black circles indicate mistakes!", @"Info screen");
    main.numberOfLines = 0;
    main.textAlignment = NSTextAlignmentCenter;
    main.textColor = [UIColor whiteColor];
    main.backgroundColor = backgroundColor;
    main.font = mainFont;
    [self.view addSubview:main];
}

- (void)addArrows
{
    float size = 24.0f;
    float x = 40.0f;
    float y = MARGIN_TOP + 6.0f;
    
    // Top left
    self.topLeftArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_TOP_LEFT]];
    self.topLeftArrow.frame = CGRectMake(x, y, size, size);
    [self.view addSubview:self.topLeftArrow];
    
    // Top right
    self.topRightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_TOP_RIGHT]];
    self.topRightArrow.frame = CGRectMake(SCREEN_WIDTH - x - size, y, size, size);
    [self.view addSubview:self.topRightArrow];
    
    y = SCREEN_HEIGHT - MARGIN_BOTTOM - size - 6.0f;
    
    // Bottom left
    self.bottomLeftArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_BOTTOM_LEFT]];
    self.bottomLeftArrow.frame = CGRectMake(x, y, size, size);
    [self.view addSubview:self.bottomLeftArrow];
    
    // Bottom right
    self.bottomRightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_BOTTOM_RIGHT]];
    self.bottomRightArrow.frame = CGRectMake(SCREEN_WIDTH - x - size, y, size, size);
    [self.view addSubview:self.bottomRightArrow];
}

- (void)animateArrows
{
    self.topLeftArrow.transform = CGAffineTransformIdentity;
    self.topRightArrow.transform = CGAffineTransformIdentity;
    self.bottomLeftArrow.transform = CGAffineTransformIdentity;
    self.bottomRightArrow.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:1.0f delay:0.0f
                        options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                     animations:^() {
                         self.topLeftArrow.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
                         self.topRightArrow.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
                         self.bottomLeftArrow.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
                         self.bottomRightArrow.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
                     }
                     completion:nil];    
}

@end