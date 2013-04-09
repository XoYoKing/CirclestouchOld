//
//  AMGPageControlController.m
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMGPageControlController.h"
#import "AMGInfoController.h"
#import "AMGStatisticsController.h"
#import "AMGAboutController.h"

#define NUM_PAGES_IN_PAGECONTROL 3

@interface AMGPageControlController()
@property (nonatomic, weak) id<AMGGameDelegate> delegate;
@property (nonatomic, strong) AMGInfoController *infoController;
@property (nonatomic, strong) AMGStatisticsController *statisticsController;
@property (nonatomic, strong) AMGAboutController *aboutController;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;
@end

@implementation AMGPageControlController

#pragma mark - Drawing view

- (id)initWithDelegate:(id<AMGGameDelegate>)delegate
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _delegate = delegate;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.1f alpha:1.0f];
    self.view.alpha = 0.75f;
    
    // The three UIViewControllers in UIScrollView
    
    self.infoController = [AMGInfoController new];
    self.infoController.view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.infoController.gameDelegate = self.delegate;

    self.statisticsController = [AMGStatisticsController new];
    self.statisticsController.view.frame = CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.statisticsController.gameDelegate = self.delegate;
    
    self.aboutController = [[AMGAboutController alloc] initWithGameDelegate:self.delegate];
    self.aboutController.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.aboutController.emailDelegate = self;
    
    // The UIScrollView itself
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    CGSize scrollViewContentSize = CGSizeMake(SCREEN_WIDTH * NUM_PAGES_IN_PAGECONTROL, SCREEN_HEIGHT);
    [self.scrollView setContentSize:scrollViewContentSize];
    [self.scrollView addSubview:self.infoController.view];
    [self.scrollView addSubview:self.statisticsController.view];
    [self.scrollView addSubview:self.aboutController.view];
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // The UIPageControl (the three dots)
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 100.0f / 2, PAGECONTROL_DOTS_Y, 100.0f, 30.0f)];
    self.pageControl.numberOfPages = NUM_PAGES_IN_PAGECONTROL;
    self.pageControl.currentPage = self.pageToShow;
    self.scrollView.contentOffset = CGPointMake(self.pageToShow * SCREEN_WIDTH, 0);
    self.pageControl.enabled = NO;
    [self.view addSubview:self.pageControl];
    
    
    [self drawTopAndBottomLines];
    
    
    [self setTextForCirclesResults];
    [self setTextForGameStatusLabel];
    [self setTextForPlayButton];
}

- (void)drawTopAndBottomLines
{
    UIColor *color = [UIColor whiteColor];
    float alpha = 0.7f;
    
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0.0f, MARGIN_TOP - 2.0f, SCREEN_WIDTH, 1.0f)];
    top.backgroundColor = color;
    top.alpha = alpha;
    [self.view addSubview:top];
    
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - MARGIN_BOTTOM, SCREEN_WIDTH, 1.0f)];
    bottom.backgroundColor = color;
    bottom.alpha = alpha;
    [self.view addSubview:bottom];
}

- (void)setTextForPlayButton
{
    if ([self.delegate gameStatus] == AMGGameStatusGamePlaying || [self.delegate gameStatus] == AMGGameStatusGamePaused) {
        self.infoController.playButton.text = NSLocalizedString(@"RESUME GAME", @"Play button");
        self.statisticsController.playButton.text = NSLocalizedString(@"RESUME GAME", @"Play button");
    } else {
        self.infoController.playButton.text = NSLocalizedString(@"NEW GAME", @"Play button");        
        self.statisticsController.playButton.text = NSLocalizedString(@"NEW GAME", @"Play button");
        [self.statisticsController hidePlayButtonForSomeSeconds];
    }
}

- (void)setTextForGameStatusLabel
{
    switch ([self.delegate gameStatus]) {
        case AMGGameStatusBeforeFirstGame:
            self.statisticsController.gameStatus.text = NSLocalizedString(@"Start a new game!", @"Game status");
            break;
        case AMGGameStatusGamePlaying:
        case AMGGameStatusGamePaused:
            self.statisticsController.gameStatus.text = NSLocalizedString(@"Game paused", @"Game status");
            break;
        case AMGGameStatusGameOver:
            self.statisticsController.gameStatus.text =
            [NSString stringWithFormat:NSLocalizedString(@"Final score: %i", @"Statistics screen"), [self.delegate timePlaying]];
            //[[AMGGameCenterHelper sharedInstance] reportScore:[self.delegate timePlaying]];
            break;
        default:
            break;
    }
}

- (void)setTextForCirclesResults
{
    self.statisticsController.touchedWellResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesTouchedWell]];
    self.statisticsController.avoidedWellResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesAvoidedWell]];
    self.statisticsController.touchedBadlyResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesTouchedBadly]];
    self.statisticsController.avoidedBadlyResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesAvoidedBadly]];
}

#pragma mark - Accessors

- (void)setPageToShow:(int)pageToShow
{
    _pageToShow = pageToShow;
    self.pageControl.currentPage = pageToShow;
    self.scrollView.contentOffset = CGPointMake(pageToShow * SCREEN_WIDTH, 0);
}

#pragma mark - Public methods

- (void)someStatisticHasChanged
{
    [self setTextForCirclesResults];
    [self setTextForGameStatusLabel];
    [self setTextForPlayButton];
}

- (void)animateArrowsInInfoController
{
    [self.infoController animateArrows];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate
#pragma mark -

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if (result == MFMailComposeResultSent) {
        // The email couldn't be sent
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end