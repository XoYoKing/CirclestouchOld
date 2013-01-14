//
//  AMStatisticsController.h
//  Test01
//
//  Created by Albert Mata on 07/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMStatisticsController : UIViewController

@property (nonatomic, weak) UILabel *touchedWellResult;
@property (nonatomic, weak) UILabel *avoidedWellResult;
@property (nonatomic, weak) UILabel *touchedBadlyResult;
@property (nonatomic, weak) UILabel *avoidedBadlyResult;
@property (nonatomic, weak) UILabel *gameStatus;

- (id)initWithFrame:(CGRect)viewFrame;

@end