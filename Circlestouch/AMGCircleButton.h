//
//  AMGCircleButton.h
//  Circlestouch
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMGCircleButton;

@protocol AMGCircleButtonDelegate <NSObject>

@property (nonatomic) BOOL soundActivated;

- (void)circleDisappearedAsWellAvoided:(AMGCircleButton *)circleButton;
- (void)circleDisappearedAsWellTouched:(AMGCircleButton *)circleButton;
- (void)circleDisappearedAsBadlyAvoided:(AMGCircleButton *)circleButton;
- (void)circleDisappearedAsBadlyTouched:(AMGCircleButton *)circleButton;

@end

@interface AMGCircleButton : UIButton

@property (nonatomic) int x;
@property (nonatomic) int y;

- (id)initWithFrame:(CGRect)frame
              color:(UIColor *)color
          okToTouch:(BOOL)okToTouch
               life:(float)life
           delegate:(id<AMGCircleButtonDelegate>)delegate;

@end