//
//  UIView+CustomAnimation.m
//  syncplicity
//
//  Created by Navjot Singh on 4/13/14.
//  Copyright (c) 2014 Syncplicity. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

+ (void)animateAcceleratedBounceEffectWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    if (([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)) {
        [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:dampingRatio initialSpringVelocity:velocity options:options animations:animations completion:completion];
    } else {
        [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:completion];
    }
}

- (void)roundLayerWithValue:(CGFloat)value
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8)
    {
        return;
    }
    
    [self.layer setCornerRadius:value];
    [self.layer setMasksToBounds:YES];
}

- (void)shadowWithValue:(CGFloat)value {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [self.layer setMasksToBounds:NO];
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [self.layer setShadowOpacity:3.0f];
    [self.layer setShadowRadius:value];
    [self.layer setShadowPath:shadowPath.CGPath];}

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
