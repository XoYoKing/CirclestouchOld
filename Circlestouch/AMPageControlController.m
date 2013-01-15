//
//  AMPageControlController.m
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMPageControlController.h"

#define NUM_PAGES_IN_PAGECONTROL 3

@implementation AMPageControlController

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f) andDelegate:nil andPageToShow:0];
}

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGameDelegate>)delegate andPageToShow:(int)pageToShow
{
    self = [super init];
    if (self) {
        self.view.frame = viewFrame;
        self.delegate = delegate;
        self.pageToShow = pageToShow;
    }
    [self drawUserInterface];
    return self;
}

- (void)drawUserInterface
{
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.85f;

    int pageControlOriginY = SCREEN_HEIGHT - MARGIN_BOTTOM - 100;
    int playButtonOriginY = pageControlOriginY - 65;
    
    // The three UIViewControllers
    self.infoController = [[AMInfoController alloc]
                           initWithFrame:CGRectMake(0,
                                                    0,
                                                    SCREEN_WIDTH,
                                                    SCREEN_HEIGHT - MARGIN_TOP - MARGIN_BOTTOM)
                           andAvailableHeightForMainText:playButtonOriginY - MARGIN_TOP];

    self.statisticsController = [[AMStatisticsController alloc]
                                 initWithFrame:CGRectMake(SCREEN_WIDTH,
                                                          0,
                                                          SCREEN_WIDTH,
                                                           SCREEN_HEIGHT - MARGIN_TOP - MARGIN_BOTTOM)];
    [self setTextForCirclesResults];
    [self setTextForGameStatusLabel];
    
    self.aboutController = [[AMAboutController alloc]
                            initWithFrame: CGRectMake(SCREEN_WIDTH * 2,
                                                      0,
                                                      SCREEN_WIDTH,
                                                      SCREEN_HEIGHT - MARGIN_TOP - MARGIN_BOTTOM)
                            andDelegate:self.delegate];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                      MARGIN_TOP,
                                                                      SCREEN_WIDTH,
                                                                      SCREEN_HEIGHT - MARGIN_TOP - MARGIN_BOTTOM)];
    self.scrollView = sv;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    CGSize scrollViewContentSize = CGSizeMake(SCREEN_WIDTH * NUM_PAGES_IN_PAGECONTROL,
                                              SCREEN_HEIGHT - MARGIN_TOP - MARGIN_BOTTOM);
    [self.scrollView setContentSize:scrollViewContentSize];
    [self.scrollView addSubview:self.infoController.view];
    [self.scrollView addSubview:self.statisticsController.view];
    [self.scrollView addSubview:self.aboutController.view];
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // PageControl (the three dots)
    int pageControlWidth = 100;
    int pageControlHeight = 30;
    UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - pageControlWidth / 2,
                                                                        SCREEN_HEIGHT - MARGIN_BOTTOM - 100,
                                                                        pageControlWidth,
                                                                        pageControlHeight)];
    self.pageControl = pc;
    self.pageControl.numberOfPages = NUM_PAGES_IN_PAGECONTROL;
    self.pageControl.currentPage = self.pageToShow;
    self.scrollView.contentOffset = CGPointMake(self.pageToShow * SCREEN_WIDTH, 0);
    self.pageControl.enabled = NO;
    [self.view addSubview:self.pageControl];
    
    // Button to start or resume game
    AMGrayButton *pb = [[AMGrayButton alloc] initWithFrame:CGRectMake(0, playButtonOriginY, self.view.frame.size.width, 60)
                                             andImageNamed:nil
                                                   andText:nil];
    self.playButton = pb;
    [self setTextForPlayButton];
    self.playButton.textAlignment = UIControlContentHorizontalAlignmentCenter;
    self.playButton.textAlpha = 1.0f;
    [self.playButton addTarget:self.delegate action:@selector(userPressedResumeOrNewGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
    [self drawTopAndBottomLines];
}

- (void)someStatisticHasChanged
{
    [self setTextForCirclesResults];
    [self setTextForGameStatusLabel];
    [self setTextForPlayButton];
}

- (void)setTextForCirclesResults
{
    self.statisticsController.touchedWellResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesTouchedWell]];
    self.statisticsController.avoidedWellResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesAvoidedWell]];
    self.statisticsController.touchedBadlyResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesTouchedBadly]];
    self.statisticsController.avoidedBadlyResult.text = [NSString stringWithFormat:@"%i",[self.delegate circlesAvoidedBadly]];
}

- (void)setTextForGameStatusLabel
{
    switch ([self.delegate gameStatus]) {
        case AMGameStatusBeforeFirstGame:
            self.statisticsController.gameStatus.text = NSLocalizedString(@"Start a new game!", @"Game status");
            break;
        case AMGameStatusGamePlaying:
        case AMGameStatusGamePaused:
            self.statisticsController.gameStatus.text = NSLocalizedString(@"Game paused", @"Game status");
            break;
        case AMGameStatusGameOver:
            self.statisticsController.gameStatus.text =
            [NSString stringWithFormat:NSLocalizedString(@"Final score: %i", @"Game status"), [self.delegate timePlaying]];
            [[AMGameCenterHelper sharedInstance] reportScore:[self.delegate timePlaying]];
            break;
        default:
            break;
    }
}

- (void)setTextForPlayButton
{
    if ([self.delegate gameStatus] == AMGameStatusGamePlaying || [self.delegate gameStatus] == AMGameStatusGamePaused) {
        self.playButton.text = NSLocalizedString(@"RESUME GAME", @"Play button");
    } else {
        self.playButton.text = NSLocalizedString(@"NEW GAME", @"Play button");
    }    
}

- (void)drawTopAndBottomLines
{
    UIColor *color = [UIColor whiteColor];
    float alpha = 0.7f;
    
    // White thick line below colors panel
    UIView *thickLineTop = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    MARGIN_TOP - 2,
                                                                    SCREEN_WIDTH,
                                                                    1)];
    thickLineTop.backgroundColor = color;
    thickLineTop.alpha = alpha;
    [self.view addSubview:thickLineTop];
    
    // White thick line above time and lives representation
    UIView *thickLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       SCREEN_HEIGHT - MARGIN_BOTTOM,
                                                                       SCREEN_WIDTH,
                                                                       1)];
    thickLineBottom.backgroundColor = color;
    thickLineBottom.alpha = alpha;
    [self.view addSubview:thickLineBottom];
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
#pragma mark Memory management
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"AMPageControlController > didReceiveMemoryWarning");
}

@end
