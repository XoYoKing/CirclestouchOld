//
//  AMPageControlController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMConstants.h"
#import "AMGameDelegate.h"
#import "AMInfoController.h"
#import "AMStatisticsController.h"
#import "AMAboutController.h"
#import "AMGrayButton.h"

@interface AMPageControlController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<AMGameDelegate> delegate;

@property (nonatomic, strong) AMInfoController *infoController;
@property (nonatomic, strong) AMStatisticsController *statisticsController;
@property (nonatomic, strong) AMAboutController *aboutController;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl * pageControl;
@property (nonatomic, weak) AMGrayButton *playButton;

@property (nonatomic) int pageToShow;

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGameDelegate>)delegate andPageToShow:(int)pageToShow;
- (void)someStatisticHasChanged;
- (void)animateArrowsInInfoController;

@end
