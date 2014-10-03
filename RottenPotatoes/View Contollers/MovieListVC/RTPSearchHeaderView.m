//
//  RTPSearchHeaderView.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 07/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPSearchHeaderView.h"

static CGFloat const kHeightSearchBar = 30.f;

@implementation RTPSearchHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayWithRGB:245.f];
    }
    return self;
}

#pragma mark = Public methods

- (void)setupSearchBar:(RTPSearchBar *)searchBar
{
    searchBar.translucent = NO;
    searchBar.placeholder = NSLocalizedString(@"Search movie", nil);
    searchBar.frame       = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds) - (kHeightSearchBar/2), CGRectGetWidth(self.bounds), kHeightSearchBar);
    [self addSubview:searchBar];
}

+ (NSString *)reuseIdentifier
{
    static NSString *const reuseId = @"RTPSearchHeaderViewReuseIdentifier";
    return reuseId;
}

@end
