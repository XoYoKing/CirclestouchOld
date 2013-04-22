//
//  AMGCircleButton.m
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AMGCircleButton.h"

@implementation AMGCircleButton

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame color:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        _x = frame.origin.x;
        _y = frame.origin.y;
        _color = color;
    }
    return self;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
}

#pragma mark - Methods to visually vanish circles

void SoundFinished (SystemSoundID snd, void* context);

- (void)disappearAsSuccess:(BOOL)soundActivated
{
    if (soundActivated) {
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
                         self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width / 2,
                                                 self.frame.origin.y + self.frame.size.height / 2,
                                                 0.0f, 0.0f);
                         self.alpha = 0.2f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)disappearAsFailure:(BOOL)soundActivated
{
    if (soundActivated) {
        NSURL *sndurl = [[NSBundle mainBundle] URLForResource:@"wrong" withExtension:@"aif"];
        SystemSoundID snd;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)sndurl, &snd);
        AudioServicesAddSystemSoundCompletion(snd, NULL, NULL, &SoundFinished, NULL);
        AudioServicesPlaySystemSound(snd);
    }
    
    self.color = [UIColor colorWithRed:0.01f green:0.01f blue:0.01f alpha:1.0f];
    self.alpha = 0.85f;
    
    // Delay execution of my block for VANISH_DURATION_WRONG_STEP1 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, VANISH_DURATION_WRONG_STEP1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:VANISH_DURATION_WRONG_STEP2
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^() {
                             self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width / 2,
                                                     self.frame.origin.y + self.frame.size.height / 2,
                                                     0.0f, 0.0f);
                             self.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    });
}

@end