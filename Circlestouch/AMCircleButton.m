//
//  AMButton.m
//  Test01
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMCircleButton.h"

@implementation AMCircleButton

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andColor:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = color;
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
    
    // Versió amb volum i llums
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    CGContextClearRect(context, rect);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    const CGFloat* components = CGColorGetComponents(self.color.CGColor);
    CGFloat colors[] =
    {
        components[0] + 0.1, components[1] + 0.1, components[2] + 0.1, 0.6f,
        components[0], components[1], components[2], 0.8f,
        components[0] - 0.05, components[1] - 0.05, components[2] - 0.05, 1.0f
    };
    CGGradientRef glossGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 3);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    CGContextClip(context);
    CGPoint topCenter = CGPointMake(rect.size.width / 4, rect.size.height / 4);
    CGPoint midCenter = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGContextDrawRadialGradient(context, glossGradient, topCenter, 0, midCenter, rect.size.width / 2, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(glossGradient);
    
    // Versió més simple feta per mi en primer lloc
    // CGContextSetFillColorWithColor(context, self.color.CGColor);
    // CGContextFillEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
}

@end
