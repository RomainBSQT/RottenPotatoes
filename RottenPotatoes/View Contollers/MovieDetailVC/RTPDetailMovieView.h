//
//  RTPDetailMovieView.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 19/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@protocol RTPDetailMovieDelegate <NSObject>
- (void)goBack:(id)sender;
- (void)goToDetails:(id)sender;
@end

@interface RTPDetailMovieView : UIView
@property (weak, nonatomic) id<RTPDetailMovieDelegate> delegate;
- (id)initWithFrame:(CGRect)frame movie:(Movie *)movie;
@end
