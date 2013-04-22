//
//  AMGCircleButton.h
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMGCircleButton : UIButton

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic, strong) UIColor *color;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color;

- (void)disappearAsSuccess:(BOOL)soundActivated;
- (void)disappearAsFailure:(BOOL)soundActivated;

@end