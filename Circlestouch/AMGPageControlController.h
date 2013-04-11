//
//  AMGPageControlController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AMGGameDelegate.h"

@interface AMGPageControlController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>

- (id)initWithDelegate:(id<AMGGameDelegate>)delegate;

- (void)someStatisticHasChanged;
- (void)animateArrowsInInfoController;
- (void)setTextForPlayButton;
- (void)setTextForGameStatusLabel;
- (void)setPageToShow;

@end
