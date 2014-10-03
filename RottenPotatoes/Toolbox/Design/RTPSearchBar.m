//
//  RTPSearchBar.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 11/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPSearchBar.h"

@implementation RTPSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barTintColor    = [UIColor grayWithRGB:245.f];
        self.tintColor       = [UIColor grayWithRGB:245.f];
        self.backgroundColor = [UIColor grayWithRGB:245.f];
        self.searchBarStyle  = UISearchBarStyleMinimal;
        self.clipsToBounds   = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    UITextField *txtSearchField = [self valueForKey:@"_searchField"];
    txtSearchField.tintColor       = [UIColor blackColor];
    for (UIView *view in [self subviews]) {
        for (id subview in [view subviews]) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = subview;
                [cancelButton setEnabled:YES];
                cancelButton.titleLabel.textColor = [UIColor RTPGrayStrong];
            }
        }
    }
    [super layoutSubviews];
}

@end
