//
//  UIFont+RTPFonts.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 07/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (RTPFonts)
+ (UIFont *)RTPFontBold:(CGFloat)size;
+ (UIFont *)RTPFontBoldIt:(CGFloat)size;
+ (UIFont *)RTPFontRegularIt:(CGFloat)size;
+ (UIFont *)RTPFontRegular:(CGFloat)size;
@end