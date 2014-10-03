//
//  RTPMovieDetailViewController.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 18/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface RTPMovieDetailViewController : UIViewController
@property (strong, nonatomic) Movie *currentMovie;
@end