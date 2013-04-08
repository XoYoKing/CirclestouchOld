//
//  AMGBlackRectButton.m
//  AMGUserInterfaceControls
//
//  Created by Albert Mata on March 15th, 2013.
//  Copyright (c) Albert Mata. All rights reserved. FreeBSD License.
//  Please send comments/corrections to hello@albertmata.net or @almata on Twitter.
//  Download latest version from https://github.com/almata/AMGUserInterfaceControls
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
//

#import "AMGBlackRectButton.h"
#import <QuartzCore/QuartzCore.h>

#define IMAGE_SIZE          24.0f
#define IMAGE_MARGIN_LEFT   20.0f
#define FONT_SIZE           16.0f
#define INSET_TOP           3.0f
#define INSET_LEFT_IMAGE    60.0f
#define INSET_LEFT_NO_IMAGE 10.0f

@interface AMGBlackRectButton()
@property (nonatomic, strong) UIImageView *image;
@end

@implementation AMGBlackRectButton

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andImageName:nil andFontName:nil andText:nil];
}

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName
                                   andFontName:(NSString *)fontName
                                       andText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        _whiteBorder = YES;
        _textHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _imageName = [imageName copy];
        _text = [text copy];
        
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        self.titleLabel.font = [UIFont fontWithName:fontName size:FONT_SIZE];
        
        [self setupImage:imageName];
        [self setupBorder];
    }
    return self;
}

#pragma mark - Accessors

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    [self setupImage:imageName];
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    [self setupTitle:text];
}

- (void)setWhiteBorder:(BOOL)whiteBorder
{
    _whiteBorder = whiteBorder;
    [self setupBorder];
}

- (void)setTextHorizontalAlignment:(UIControlContentHorizontalAlignment)textHorizontalAlignment
{
    _textHorizontalAlignment = textHorizontalAlignment;
    [self setupTitle:self.text];
}

#pragma mark - Private methods

- (void)setupImage:(NSString *)imageName
{
    if (self.image) {
        [self.image removeFromSuperview];
        self.image = nil;
    }
    
    if (imageName) {
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        self.image.frame = CGRectMake(IMAGE_MARGIN_LEFT,
                                      self.bounds.size.height / 2 - IMAGE_SIZE / 2,
                                      IMAGE_SIZE,
                                      IMAGE_SIZE);
        [self addSubview:self.image];
    }
    
    [self setupTitle:self.text];
}

- (void)setupTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    
    float insetLeft = 0.0f;
    if (self.textHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
        insetLeft = (self.image) ? INSET_LEFT_IMAGE : INSET_LEFT_NO_IMAGE;
    }
    
    self.contentEdgeInsets = UIEdgeInsetsMake(INSET_TOP, insetLeft, 0.0f, 0.0f);
    self.contentHorizontalAlignment = self.textHorizontalAlignment;
}

- (void)setupBorder
{
    CALayer *layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:0.0f];

    if (self.whiteBorder) {
        [layer setBorderWidth:1.0f];
        [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    } else {
        [layer setBorderWidth:0.0f];
    }
}

@end