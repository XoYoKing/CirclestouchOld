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

@property (nonatomic, weak) id<AMGGameDelegate> delegate;
@property (nonatomic) int pageToShow;

- (void)someStatisticHasChanged;
- (void)animateArrowsInInfoController;

@end
