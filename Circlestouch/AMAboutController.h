//
//  AMAboutController.h
//  Circlestouch
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMGameDelegate.h"
#import "AMGrayButton.h"

@interface AMAboutController : UIViewController

@property (nonatomic, weak) AMGrayButton *soundButton;
@property (nonatomic, weak) id<AMGameDelegate> delegate;

- (id)initWithFrame:(CGRect)viewFrame andDelegate:(id<AMGameDelegate>)delegate;

@end