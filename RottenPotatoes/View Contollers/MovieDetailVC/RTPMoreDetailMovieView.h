//
//  RTPMoreDetailMovieView.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 01/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@protocol RTPMoreDetailMovieDelegate <NSObject>
- (void)goBack:(id)sender;
- (void)goToDetails:(id)sender;
@end

@interface RTPMoreDetailMovieView : UIView
@property (weak, nonatomic) id<RTPMoreDetailMovieDelegate> delegate;
- (id)initWithFrame:(CGRect)frame movie:(Movie *)movie;
@end