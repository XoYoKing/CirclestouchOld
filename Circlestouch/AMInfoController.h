//
//  AMInfoController.h
//  Circlestouch
//
//  Created by Albert Mata on 05/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMInfoController : UIViewController

@property (nonatomic, weak) UIImageView *topLeftArrow;
@property (nonatomic, weak) UIImageView *topRightArrow;
@property (nonatomic, weak) UIImageView *bottomLeftArrow;
@property (nonatomic, weak) UIImageView *bottomRightArrow;

@property (nonatomic) int availableHeightForMainText;

- (id)initWithFrame:(CGRect)viewFrame andAvailableHeightForMainText:(int)availableHeightForMainText;
- (void)animateArrows;

@end