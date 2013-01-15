//
//  AMColorsPanel.h
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMColorsPanel : UIView

@property (nonatomic, strong) NSArray *colorsToTouch; // of UIColor
@property (nonatomic, strong) NSArray *colorsToAvoid; // of UIColor

- (id)initWithFrame:(CGRect)frame andColorsToTouch:(NSArray *)colorsToTouch andColorsToAvoid:(NSArray *)colorsToAvoid;

@end