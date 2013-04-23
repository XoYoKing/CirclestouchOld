//
//  AMGColorsPanel.m
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AMGColorsPanel.h"

@interface AMGColorsPanel()
@property (nonatomic, strong) NSArray *colorsToTouch; // of UIColor
@property (nonatomic, strong) NSArray *colorsToAvoid; // of UIColor
@property (nonatomic, weak) id<AMGColorsPanelDelegate> delegate;
@end

@implementation AMGColorsPanel

- (id)initWithFrame:(CGRect)frame 
{
    return [self initWithFrame:frame colorsToTouch:nil colorsToAvoid:nil delegate:nil];
}

- (id)initWithFrame:(CGRect)frame
        colorsToTouch:(NSArray *)colorsToTouch
        colorsToAvoid:(NSArray *)colorsToAvoid
             delegate:(id<AMGColorsPanelDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _colorsToTouch = colorsToTouch;
        _colorsToAvoid = colorsToAvoid;
        _delegate = delegate;
    }
    return self;
}

void SoundFinished (SystemSoundID snd, void* context);

- (void)changeColorsToTouch:(NSArray *)colorsToTouch
              colorsToAvoid:(NSArray *)colorsToAvoid
        usingAnimationColor:(UIColor *)animationColor
{
    if (self.delegate.soundActivated) {
        // Sound to show that some colors to touch and avoid are going to change
        NSURL *sndurl = [[NSBundle mainBundle] URLForResource:@"changing" withExtension:@"wav"];
        SystemSoundID snd;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)sndurl, &snd);
        AudioServicesAddSystemSoundCompletion(snd, NULL, NULL, &SoundFinished, NULL);
        AudioServicesPlaySystemSound(snd);
    }
    
    // Animation to show that some colors to touch and avoid are going to change
    UIView __block *v1 = [[UIView alloc] initWithFrame:CGRectMake(-5, MARGIN_TOP - 7, 8, 2)];
    UIView __block *v2 = [[UIView alloc] initWithFrame:CGRectMake(-80, MARGIN_TOP - 7, 8, 2)];
    v1.backgroundColor = v2.backgroundColor = animationColor;
    v1.alpha = v2.alpha = 0.75f;
    [self.superview addSubview:v1];
    [self.superview addSubview:v2];
    
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

                         _colorsToTouch = colorsToTouch;
                         _colorsToAvoid = colorsToAvoid;
                         [self setNeedsDisplay];

                         [self.delegate didFinishChangingColors];
                     }];
}

- (void)drawRect:(CGRect)rect
{
    int centralSeparation = SCREEN_WIDTH
                            - MARGIN_LEFTMOST
                            - MARGIN_RIGHTMOST
                            - NUM_COLORS * MINICIRCLE_DIAMETER
                            - (NUM_COLORS - 2) * MINICIRCLE_SEPARATION;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    int x = MARGIN_LEFTMOST;
    
    // Drawing colors to touch
    for (int i = 0; i < [self.colorsToTouch count]; i++) {
        UIColor *color = [self.colorsToTouch objectAtIndex:i];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(x, MARGIN_TOPMOST, MINICIRCLE_DIAMETER, MINICIRCLE_DIAMETER));
        x += MINICIRCLE_DIAMETER + MINICIRCLE_SEPARATION;
    }
    
    x += centralSeparation;
    
    // Drawing colors to avoid
    for (int i = 0; i < [self.colorsToAvoid count]; i++) {
        UIColor *color = [self.colorsToAvoid objectAtIndex:i];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(x, MARGIN_TOPMOST, MINICIRCLE_DIAMETER, MINICIRCLE_DIAMETER));
        x += MINICIRCLE_DIAMETER + MINICIRCLE_SEPARATION;
    }
}

@end