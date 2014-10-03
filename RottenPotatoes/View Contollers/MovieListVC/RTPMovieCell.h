//
//  RTPMovieCell.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 03/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface RTPMovieCell : UICollectionViewCell
- (void)setMovie:(Movie *)currentMovie;
+ (NSString *)reuseIdentifier;
@end
