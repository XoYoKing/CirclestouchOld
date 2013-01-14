//
//  AMLivesRepresentation.m
//  Test01
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMLivesRepresentation.h"

@implementation AMLivesRepresentation

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andLivesRemaining:0];
}

- (id)initWithFrame:(CGRect)frame andLivesRemaining:(int)livesRemaining
{
    self = [super initWithFrame:frame];
    if (self) {
        _livesRemaining = livesRemaining;
        
        UIView *cv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.colorView = cv;
        [self addSubview:self.colorView];
        [self redrawColorView];
        
        float x = ((float)self.livesRemaining / MAX_LIVES) * frame.size.width;
        UIView *wv = [[UIView alloc] initWithFrame:CGRectMake(x, 0, frame.size.width - x, frame.size.height)];
        self.whiteView = wv;
        self.whiteView.backgroundColor = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:0.77f];
        [self addSubview:self.whiteView];
    }
    return self;
}

- (void)setLivesRemaining:(int)livesRemaining
{
    _livesRemaining = livesRemaining;
    [self redrawWhiteView];
    [self redrawColorView];
}

- (void)redrawWhiteView
{
    float x = ((float)self.livesRemaining / MAX_LIVES) * self.frame.size.width;
    [UIView animateWithDuration:0.2f animations:^() {
        self.whiteView.frame = CGRectMake(x, 0, self.frame.size.width - x, self.frame.size.height);
    }];
}

- (void)redrawColorView
{
    float red, green, blue, alpha;
    if ((self.livesRemaining <= 50)) {
        red = 1.0f;
        green = self.livesRemaining * ((0.8f - 0.0f) / 50);
    } else {
        red = (100 - self.livesRemaining) * ((1.0f - 0.0f) / 50);
        green = 0.8f;
    }
    blue = 0.0f;
    alpha = 1.0f;
    [UIView animateWithDuration:0.2f animations:^() {
        self.colorView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }];
}

@end