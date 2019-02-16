//
//  UIView+CustomAnimation.h
//  syncplicity
//
//  Created by Navjot Singh on 4/13/14.
//  Copyright (c) 2014 Syncplicity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Custom)

+ (void)animateAcceleratedBounceEffectWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
- (void)roundLayerWithValue:(CGFloat)value;
- (void)shadowWithValue:(CGFloat)value;
- (UIImage *)capture;

@end
