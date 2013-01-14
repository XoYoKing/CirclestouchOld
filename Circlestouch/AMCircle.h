//
//  AMCircle.h
//  Test01
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMCircle : NSObject

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic, strong) UIColor *color;

- (id)initWithX:(int)x andY:(int)y andColor:(UIColor *)color;

@end
