//
//  UIColor+RTPColors.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 01/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "UIColor+RTPColors.h"

@implementation UIColor (RTPColors)

+ (UIColor *)grayWithRGB:(CGFloat)white
{
    return [UIColor colorWithRed:(white/255.f) green:(white/255.f) blue:(white/255.f) alpha:1.0];
}

+ (UIColor *)RTPRed
{
    return [UIColor colorWithRed:1 green:(102.f/255.f) blue:(51.f/255.f) alpha:1];
}

+ (UIColor *)RTPGreen
{
    return [UIColor colorWithRed:0 green:(204.f/255.f) blue:(102.f/255.f) alpha:1];
}

+ (UIColor *)RTPYellow
{
    return [UIColor colorWithRed:1 green:(204.f/255.f) blue:(51.f/255.f) alpha:1];
}

+ (UIColor *)RTPGrayLight
{
    return [self grayWithRGB:153.f];
}

+ (UIColor *)RTPGray
{
    return [self grayWithRGB:74.f];
}

+ (UIColor *)RTPGrayStrong
{
    return [self grayWithRGB:44.f];
}

@end
