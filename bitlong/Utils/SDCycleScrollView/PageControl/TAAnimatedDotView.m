//
//  TAAnimatedDotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation TAAnimatedDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    self.backgroundColor = dotColor;
}

- (void)setCurrentDotColor:(UIColor *)currentDotColor
{
    _currentDotColor = currentDotColor;
}

- (void)initialization
{
    _dotColor = [UIColor colorWithWhite:1 alpha:0.4];
    _currentDotColor = [UIColor whiteColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToDeactiveState];
    }
}


- (void)animateToActiveState
{
//    self.layer.cornerRadius = 1.5;
//    [UIView animateWithDuration:kAnimateDuration delay:0.2 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.backgroundColor = self->_currentDotColor;
//        self.transform = CGAffineTransformMakeScale(1.8, 1.0);
//    } completion:nil];
    
    __weak typeof(self)weakSelf = self;
    self.layer.cornerRadius = 2.5;
    [UIView animateWithDuration:kAnimateDuration delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.backgroundColor = weakSelf.currentDotColor;
        weakSelf.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)animateToDeactiveState{
    __weak typeof(self)weakSelf = self;
    self.layer.cornerRadius = 2.5;
    [UIView animateWithDuration:kAnimateDuration delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.backgroundColor = weakSelf.dotColor;
        weakSelf.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
