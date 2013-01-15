//
//  AMLivesRepresentation.h
//  Circlestouch
//
//  Created by Albert Mata on 04/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMLivesRepresentation : UIView

@property (nonatomic) int livesRemaining;

@property (nonatomic, weak) UIView *colorView;
@property (nonatomic, weak) UIView *whiteView;

- (id)initWithFrame:(CGRect)frame andLivesRemaining:(int)livesRemaining;

@end