//
//  AMBackground.m
//  TestBackground
//
//  Created by Albert Mata on 09/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMBackground.h"

@implementation AMBackground

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame
                 andFirstColor:[UIColor whiteColor]
                andSecondColor:[UIColor whiteColor]
                andSquaresSize:frame.size.width];
}

- (id)initWithFrame:(CGRect)frame
      andFirstColor:(UIColor *)firstColor
     andSecondColor:(UIColor *)secondColor
     andSquaresSize:(int)squaresSize
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = firstColor;
        self.secondColor = secondColor;
        self.squaresSize = squaresSize;
    }
    return self;
}

- (void)setFirstColor:(UIColor *)firstColor
{
    _firstColor = firstColor;
    self.backgroundColor = firstColor;
}

- (void)setSecondColor:(UIColor *)secondColor
{
    _secondColor = secondColor;
    [self setNeedsDisplay];
}

- (void)setSquaresSize:(int)squaresSize
{
    _squaresSize = squaresSize;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.secondColor.CGColor);
    for (int y = 0; y < rect.size.height; y += self.squaresSize) {
        for (int x = 0 + (y % (self.squaresSize * 2)); x < rect.size.width; x += self.squaresSize * 2) {
            CGContextFillRect(context, CGRectMake(x, y, self.squaresSize, self.squaresSize));
        }        
    }
}

@end