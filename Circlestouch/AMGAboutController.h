//
//  AMGAboutController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AMGGameDelegate.h"

@interface AMGAboutController : UIViewController

@property (nonatomic, weak) id<AMGGameDelegate> gameDelegate;
@property (nonatomic, weak) id<MFMailComposeViewControllerDelegate> emailDelegate;

@end