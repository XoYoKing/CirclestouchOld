//
//  AMBackground.h
//  TestBackground
//
//  Created by Albert Mata on 09/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMBackground : UIView

@property (nonatomic, strong) UIColor *firstColor;
@property (nonatomic, strong) UIColor *secondColor;
@property (nonatomic) int squaresSize;

- (id)initWithFrame:(CGRect)frame
      andFirstColor:(UIColor *)firstColor
     andSecondColor:(UIColor *)secondColor
     andSquaresSize:(int)squaresSize;

@end
