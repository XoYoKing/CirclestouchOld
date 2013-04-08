//
//  AMGCircle.m
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGCircle.h"

@implementation AMGCircle

- (id)init
{
    return [self initWithX:0 andY:0 andColor:[UIColor whiteColor]];
}

- (id)initWithX:(int)x andY:(int)y andColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
        self.color = color;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    AMGCircle *other = (AMGCircle *)object;
    return (self.x == other.x && self.y == other.y);
}

- (NSUInteger)hash
{
    return 10000 * self.x + self.y;
}

@end