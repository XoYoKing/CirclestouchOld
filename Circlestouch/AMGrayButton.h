//
//  AMGrayButton.h
//  Circlestouch
//
//  Created by Albert Mata on 12/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMGrayButton : UIButton

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imageNamed;
@property (nonatomic) UIControlContentHorizontalAlignment textAlignment;
@property (nonatomic) float textAlpha;

- (id)initWithFrame:(CGRect)frame andImageNamed:(NSString *)imageNamed andText:(NSString *)text;

@end