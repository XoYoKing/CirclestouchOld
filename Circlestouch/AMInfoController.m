//
//  AMInfoController.m
//  Test01
//
//  Created by Albert Mata on 05/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMInfoController.h"

@implementation AMInfoController

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f) andAvailableHeightForMainText:0];
}

- (id)initWithFrame:(CGRect)viewFrame andAvailableHeightForMainText:(int)availableHeightForMainText
{
    self = [super init];
    if (self) {
        self.view.frame = viewFrame;
        self.availableHeightForMainText = availableHeightForMainText;
    }
    [self drawUserInterface];
    return self;
}

- (void)drawUserInterface
{
    // Images for little arrows
    [self addImages];
    [self animateArrows];
    
    UIColor *color = [UIColor whiteColor];
    UIColor *backgroundColor = [UIColor clearColor];
    float alpha = 0.7f;
    UIFont *font = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:14.0f];
    UIFont *mainFont = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:19.0f];
    float viewHeight;
    float viewVerticalMargin;
    
    // "Colors to touch"
    viewHeight = 30;
    viewVerticalMargin = 25;
    UILabel *colorsTouch = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                     viewVerticalMargin,
                                                                     self.view.frame.size.width / 2 - 20,
                                                                     viewHeight)];
    colorsTouch.text = NSLocalizedString(@"Colors to touch", @"Info screen");
    colorsTouch.textColor = color;
    colorsTouch.backgroundColor = backgroundColor;
    colorsTouch.alpha = alpha;
    colorsTouch.font = font;
    [self.view addSubview:colorsTouch];
    
    // "Colors to avoid"
    viewHeight = 30;
    viewVerticalMargin = 25;
    UILabel *colorsAvoid = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 + 10,
                                                                     viewVerticalMargin,
                                                                     self.view.frame.size.width / 2 - 20,
                                                                     viewHeight)];
    colorsAvoid.text = NSLocalizedString(@"Colors to avoid", @"Info screen");
    colorsAvoid.textAlignment = NSTextAlignmentRight;
    colorsAvoid.textColor = color;
    colorsAvoid.backgroundColor = backgroundColor;
    colorsAvoid.alpha = alpha;
    colorsAvoid.font = font;
    [self.view addSubview:colorsAvoid];

    // "Current score - (tap to pause)"
    viewHeight = 50;
    viewVerticalMargin = 28;
    UILabel *currentScore = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                     self.view.frame.size.height - viewHeight - viewVerticalMargin,
                                                                     self.view.frame.size.width / 2 - 20,
                                                                     viewHeight)];
    currentScore.text = NSLocalizedString(@"Current score\n(tap to pause)", @"Info screen");
    currentScore.numberOfLines = 0;
    currentScore.textColor = color;
    currentScore.backgroundColor = backgroundColor;
    currentScore.alpha = alpha;
    currentScore.font = font;
    [self.view addSubview:currentScore];
    
    // "Remaining lives"
    viewHeight = 30;
    viewVerticalMargin = 28;
    UILabel *power = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 + 10,
                                                               self.view.frame.size.height - viewHeight - viewVerticalMargin,
                                                               self.view.frame.size.width / 2 - 20,
                                                               viewHeight)];
    power.text = NSLocalizedString(@"Remaining lives", @"Info screen");
    power.textAlignment = NSTextAlignmentRight;
    power.textColor = color;
    power.backgroundColor = backgroundColor;
    power.alpha = alpha;
    power.font = font;
    [self.view addSubview:power];
    
    // Main game explanation in the middle of the screen
    int y = colorsTouch.frame.origin.y + colorsTouch.frame.size.height;
    UILabel *main = [[UILabel alloc] initWithFrame:CGRectMake(30,
                                                              y,
                                                              self.view.frame.size.width - 60,
                                                              self.availableHeightForMainText - y)];
    main.text = NSLocalizedString(@"Touch the right colors before they turn black to achieve the highest score! Black circles indicate mistakes!", @"Info screen");
    main.numberOfLines = 0;
    main.textAlignment = NSTextAlignmentCenter;
    main.textColor = [UIColor whiteColor];
    main.backgroundColor = backgroundColor;
    main.font = mainFont;
    [self.view addSubview:main];
}

- (void)addImages
{
    float imageSize = 24.0f;
    float horizontalMargin = 40.0f;
    float verticalMargin = 6.0f;
    
    // Top left
    UIImageView *tla = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_TOP_LEFT]];
    self.topLeftArrow = tla;
    self.topLeftArrow.frame = CGRectMake(horizontalMargin,
                                         verticalMargin,
                                         imageSize,
                                         imageSize);
    [self.view addSubview:self.topLeftArrow];
    
    // Top right
    UIImageView *tra = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_TOP_RIGHT]];
    self.topRightArrow = tra;
    self.topRightArrow.frame = CGRectMake(self.view.frame.size.width - horizontalMargin - imageSize,
                                          verticalMargin,
                                          imageSize,
                                          imageSize);
    [self.view addSubview:self.topRightArrow];
    
    // Bottom left
    UIImageView *bla = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_BOTTOM_LEFT]];
    self.bottomLeftArrow = bla;
    self.bottomLeftArrow.frame = CGRectMake(horizontalMargin,
                                            self.view.frame.size.height - imageSize - verticalMargin,
                                            imageSize,
                                            imageSize);
    [self.view addSubview:self.bottomLeftArrow];
    
    // Bottom right
    UIImageView *bra = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ARROW_BOTTOM_RIGHT]];
    self.bottomRightArrow = bra;
    self.bottomRightArrow.frame = CGRectMake(self.view.frame.size.width - horizontalMargin - imageSize,
                                             self.view.frame.size.height - imageSize - verticalMargin,
                                             imageSize,
                                             imageSize);
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

#pragma mark -
#pragma mark Memory management
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"AMInfoController > didReceiveMemoryWarning");
}

@end
