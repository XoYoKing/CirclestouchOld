//
//  AMGrayButton.m
//  Circlestouch
//
//  Created by Albert Mata on 12/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMConstants.h"
#import "AMGrayButton.h"

@interface AMGrayButton ()
{
    UIImageView *image;
    int imageSize;
    int imageMarginLeft;
}
@end

@implementation AMGrayButton

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andImageNamed:nil andText:nil];
}

- (id)initWithFrame:(CGRect)frame andImageNamed:(NSString *)imageNamed andText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self->imageSize = 24;
        self->imageMarginLeft = 20;
        
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
        if (imageNamed) {
            self->image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
            self->image.frame = CGRectMake(self->imageMarginLeft,
                                           frame.size.height / 2 - self->imageSize / 2,
                                           self->imageSize,
                                           self->imageSize);
            [self addSubview:self->image];            
        }
        [self setTitle:text forState:UIControlStateNormal];
        //self.titleLabel.font = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:16.0f];
        self.titleLabel.font = [UIFont fontWithName:APP_MAIN_FONT size:16.0f];
        self.titleLabel.alpha = 0.7f;
        self.contentEdgeInsets = UIEdgeInsetsMake(0, (imageNamed) ? 70 : 0, 0, 0);
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self setTitle:self.text forState:UIControlStateNormal];
}

- (void)setImageNamed:(NSString *)imageNamed
{
    _imageNamed = imageNamed;
    [self->image removeFromSuperview];
    if (imageNamed) {
        self->image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        self->image.frame = CGRectMake(self->imageMarginLeft, self.frame.size.height / 2 - self->imageSize / 2, self->imageSize, self->imageSize);
        [self addSubview:self->image];
    }
    self.contentEdgeInsets = UIEdgeInsetsMake(0, (imageNamed) ? 70 : 0, 0, 0);
}

- (void)setTextAlignment:(UIControlContentHorizontalAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.contentHorizontalAlignment = self.textAlignment;
}

- (void)setTextAlpha:(float)textAlpha
{
    _textAlpha = textAlpha;
    self.titleLabel.alpha = self.textAlpha;
}

@end
