//
//  AMGCircleButton.m
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGCircleButton.h"

@implementation AMGCircleButton

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andColor:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
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

@end
