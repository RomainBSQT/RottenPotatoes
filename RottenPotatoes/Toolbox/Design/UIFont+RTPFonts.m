//
//  UIFont+RTPFonts.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 07/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "UIFont+RTPFonts.h"

@implementation UIFont (RTPFonts)

+ (UIFont *)RTPFontBold:(CGFloat)size
{
    return [UIFont fontWithName:@"Casper-Bold" size:size];
}

+ (UIFont *)RTPFontBoldIt:(CGFloat)size
{
    return [UIFont fontWithName:@"Casper-BoldItalic" size:size];
}

+ (UIFont *)RTPFontRegularIt:(CGFloat)size
{
    return [UIFont fontWithName:@"Casper-Italic" size:size];
}

+ (UIFont *)RTPFontRegular:(CGFloat)size
{
    return [UIFont fontWithName:@"Casper" size:size];
}

@end
