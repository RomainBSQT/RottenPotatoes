//
//  RTPMovieListView.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 01/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTPMovieListDelegate <NSObject>
- (void)itemSelected:(id)item;
@end

@interface RTPMovieListView : UIView
@property (weak, nonatomic) id<RTPMovieListDelegate> delegate;
- (id)initWithFrame:(CGRect)frame contentsController:(UIViewController *)controller;
@end