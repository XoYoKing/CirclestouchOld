//
//  AMGPageControlController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGGameCenterHelper.h"
#import "AMGGameDelegate.h"
#import "AMGInfoController.h"
#import "AMGStatisticsController.h"
#import "AMGAboutController.h"
#import "AMGBlackRectButton.h"

@interface AMGPageControlController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<AMGGameDelegate> delegate;

@property (nonatomic, strong) AMGInfoController *infoController;
@property (nonatomic, strong) AMGStatisticsController *statisticsController;
@property (nonatomic, strong) AMGAboutController *aboutController;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl * pageControl;
@property (nonatomic, weak) AMGBlackRectButton *playButton;

@property (nonatomic) int pageToShow;

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGGameDelegate>)delegate andPageToShow:(int)pageToShow;
- (void)someStatisticHasChanged;
- (void)animateArrowsInInfoController;

@end
