//
//  AMGAboutController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGGameDelegate.h"
#import "AMGBlackRectButton.h"

@interface AMGAboutController : UIViewController

@property (nonatomic, weak) AMGBlackRectButton *soundButton;
@property (nonatomic, weak) id<AMGGameDelegate> delegate;

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGGameDelegate>)delegate;

@end