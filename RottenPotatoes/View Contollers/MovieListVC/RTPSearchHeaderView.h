//
//  RTPSearchHeaderView.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 07/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTPSearchBar.h"

@interface RTPSearchHeaderView : UICollectionReusableView
- (void)setupSearchBar:(RTPSearchBar *)searchBar;
+ (NSString *)reuseIdentifier;
@end
