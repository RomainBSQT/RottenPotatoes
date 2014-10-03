//
//  RTPMoreDetailMovieView.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 01/10/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPMoreDetailMovieView.h"
#import "Movie.h"

static CGFloat const kMargin     = 15.f;
static CGFloat const kButtonSize = 35.f;

@interface RTPMoreDetailMovieView ()
@property (strong, nonatomic) UILabel  *title;
@property (strong, nonatomic) UILabel  *synopsis;
@property (strong, nonatomic) UIButton *showLessDetails;
@property (weak, nonatomic) Movie *currentMovie;
@end

@implementation RTPMoreDetailMovieView

- (id)initWithFrame:(CGRect)frame movie:(Movie *)movie
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentMovie = movie;
        self.backgroundColor = [UIColor blackColor];
        [self p_setupBackButton];
        [self p_setupTitle];
        [self p_setupSynopsis];
    }
    return self;
}

- (void)p_setupBackButton
{
    UIImage *picture = [UIImage imageNamed:@"backButton"];
    UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, picture.size.width, picture.size.height)];
    pictureView.image = picture;
    _showLessDetails = [UIButton new];
    [_showLessDetails addSubview:pictureView];
    _showLessDetails.frame = CGRectMake(CGRectGetMidX(self.bounds) - picture.size.width/2, kMargin, kButtonSize*1.15, kButtonSize*1.15);
    [_showLessDetails addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_showLessDetails];
}

- (void)p_setupTitle
{
    NSString *titleStr  = _currentMovie.title;
    UIFont *currentFont = [UIFont RTPFontBold:15.f];
    CGSize sizeLabel    = [titleStr sizeWithAttributes:@{NSFontAttributeName:currentFont}];
    
    _title = [UILabel new];
    _title.frame     = CGRectMake(kMargin, kMargin*5, sizeLabel.width, sizeLabel.height);
    _title.text      = titleStr;
    _title.font      = currentFont;
    _title.textColor = [UIColor whiteColor];
    [self addSubview:_title];
}

- (void)p_setupSynopsis
{
    NSString *synopsis = (_currentMovie.synopsis.length) ? _currentMovie.synopsis : NSLocalizedString(@"No synopsis available for this movie.", nil);
    _synopsis = [UILabel new];
    _synopsis.font          = [UIFont RTPFontRegular:14.0f];
    _synopsis.textColor     = [UIColor whiteColor];
    _synopsis.textAlignment = NSTextAlignmentLeft;
    CGSize maxLabelSize = CGSizeMake(CGRectGetWidth(self.bounds) - kMargin*2, FLT_MAX);
    CGRect synRect = [synopsis boundingRectWithSize:maxLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_synopsis.font} context:nil];
    _synopsis.lineBreakMode = NSLineBreakByWordWrapping;
    _synopsis.numberOfLines = 0;
    _synopsis.text          = synopsis;
    _synopsis.frame = CGRectMake(kMargin, CGRectGetMaxY(_title.frame) + kMargin, CGRectGetWidth(synRect), CGRectGetHeight(synRect));
    [self addSubview:_synopsis];
}

- (void)backButton:(id)sender
{
    [self.delegate goBack:self];
}

- (void)showDetails:(id)sender
{
    [self.delegate goToDetails:self];
}


@end
