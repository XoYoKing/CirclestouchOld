//
//  AMGColorsPanel.h
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMGColorsPanelDelegate <NSObject>

@property (nonatomic) BOOL soundActivated;

- (void)didFinishChangingColors;

@end

@interface AMGColorsPanel : UIView

- (id)initWithFrame:(CGRect)frame
      colorsToTouch:(NSArray *)colorsToTouch
      colorsToAvoid:(NSArray *)colorsToAvoid
           delegate:(id<AMGColorsPanelDelegate>)delegate;

- (void)changeColorsToTouch:(NSArray *)colorsToTouch
              colorsToAvoid:(NSArray *)colorsToAvoid
        usingAnimationColor:(UIColor *)animationColor;

@end