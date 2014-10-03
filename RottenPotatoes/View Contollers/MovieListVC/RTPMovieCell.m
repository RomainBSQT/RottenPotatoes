//
//  RTPMovieCell.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 03/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPMovieCell.h"
#import "UIImageView+RTPDownloadImage.h"
#import "NSDictionary+TypeCheck.h"
#import "Movie.h"

@interface RTPMovieCell ()
@property (strong, nonatomic) UIImageView *poster;
@end

@implementation RTPMovieCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor grayWithRGB:235.f];
        self.contentView.clipsToBounds = YES;
        [self p_setupPicture];
    }
    return self;
}

#pragma mark - Private methods

- (void)p_setupPicture
{
    _poster = [UIImageView new];
    _poster.frame = self.bounds;
    _poster.contentMode = UIViewContentModeScaleToFill;
    _poster.alpha = 0.f;
    [self.contentView addSubview:_poster];
}

#pragma mark - Public methods

- (void)setMovie:(Movie *)currentMovie
{
    self.poster.image = nil;
    NSURL *urlPicture = [NSURL URLWithString:[currentMovie.posters extractDataAtKey:@"original" withExpectedType:[NSString class]]];
    [self.poster downloadImageWithUrl:urlPicture fading:YES];
}

+ (NSString *)reuseIdentifier
{
    static NSString *const reuseId = @"RTPMovieCellReuseIdentifier";
    return reuseId;
}

@end
