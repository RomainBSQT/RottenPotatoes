//
//  RTPDetailMovieView.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 19/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RTPDetailMovieView.h"
#import "UIImageView+RTPDownloadImage.h"
#import "NSDictionary+TypeCheck.h"
#import "Movie.h"

static CGFloat const kHeightPicture  = 425.6f; // 320*133/100
static CGFloat const kHeightGradient = 70.f;   // 320*133/100
static CGFloat const kButtonSize     = 35.f;
static CGFloat const kMargin         = 15.f;
static NSString *const kUrlImdb      = @"http://www.imdb.com/title/tt";

@interface RTPDetailMovieView () {
    UIView          *gradientView;
    CAGradientLayer *maskLayer;
}
@property (strong, nonatomic) UIImageView *picture;
@property (strong, nonatomic) UILabel     *rating;
@property (strong, nonatomic) UILabel     *title;
@property (strong, nonatomic) UILabel     *synopsisLabel;
@property (strong, nonatomic) UIButton    *imdbPageLink;
@property (strong, nonatomic) UIButton    *showMoreDetails;
@property (weak, nonatomic) Movie *currentMovie;
@end

@implementation RTPDetailMovieView

- (id)initWithFrame:(CGRect)frame movie:(Movie *)movie
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentMovie = movie;
        [self p_setupPicture];
        [self p_setupGradient];
        [self p_setupBackButton];
        [self p_setupRating];
        [self p_setupTitle];
        [self p_setupImdbLink];
        [self p_setupMoreDetailsButton];
    }
    return self;
}

#pragma mark - Private methods

- (void)p_setupPicture
{
    _picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kHeightPicture)];
    _picture.contentMode = UIViewContentModeScaleToFill;
    NSURL *urlPicture = [NSURL URLWithString:[_currentMovie.posters extractDataAtKey:@"original" withExpectedType:[NSString class]]];
    [_picture downloadImageWithUrl:urlPicture];
    [self addSubview:_picture];
}

- (void)p_setupGradient
{
    gradientView = [UIView new];
    gradientView.backgroundColor = [UIColor blackColor];
    gradientView.frame           = CGRectMake(0, kHeightPicture - kHeightGradient, CGRectGetWidth(self.bounds), kHeightGradient);
    [self addSubview:gradientView];
    if (!maskLayer) {
        maskLayer = [CAGradientLayer layer];
        CGColorRef outerColor = [UIColor colorWithWhite:1 alpha:0.f].CGColor;
        CGColorRef innerColor = [UIColor colorWithWhite:1 alpha:1.f].CGColor;
        maskLayer.colors      = @[(__bridge id)outerColor, (__bridge id)innerColor];
        maskLayer.startPoint  = CGPointMake(0, 0);
        maskLayer.endPoint    = CGPointMake(0, 1);
        maskLayer.bounds      = gradientView.bounds;
        maskLayer.anchorPoint = CGPointZero;
        gradientView.layer.mask = maskLayer;
    }
}

- (void)p_setupBackButton
{
    UIButton *backButton      = [UIButton new];
    UIImage *picture          = [UIImage imageNamed:@"closePicture"];
    UIImageView *closePicture = [UIImageView new];
    UIView *bgView            = [UIView new];
    bgView.userInteractionEnabled = NO;
    bgView.backgroundColor        = [UIColor blackColor];
    bgView.alpha                  = 0.5f;
    backButton.frame              = CGRectMake(kMargin, kMargin, kButtonSize, kButtonSize);
    closePicture.frame            = CGRectMake(CGRectGetMidX(backButton.bounds) - (picture.size.width/2), CGRectGetMidY(backButton.bounds) - (picture.size.height/2), picture.size.width, picture.size.height);
    closePicture.image            = picture;
    bgView.frame                  = backButton.bounds;
    [backButton addSubview:bgView];
    [backButton addSubview:closePicture];
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
}

- (void)p_setupRating
{
    CGFloat rating      = ([_currentMovie.audienceScore floatValue] + [_currentMovie.criticsScore floatValue])/2;
    NSString *ratingStr = [NSString stringWithFormat:@"%.0f%%", rating];
    UIFont *currentFont = [UIFont RTPFontRegular:35.f];
    NSDictionary *attr  = @{NSFontAttributeName:currentFont};
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:ratingStr attributes:attr];
    NSRange percentRange = [ratingStr rangeOfString:@"%"];
    [attrText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:currentFont.fontName size:20.f]} range:percentRange];
    CGSize sizeLabel = [ratingStr sizeWithAttributes:@{NSFontAttributeName:currentFont}];
    
    _rating = [UILabel new];
    _rating.frame          = CGRectMake(CGRectGetWidth(self.bounds) - kMargin - sizeLabel.width, CGRectGetHeight(self.bounds) - kMargin - sizeLabel.height, sizeLabel.width, sizeLabel.height);
    _rating.attributedText = attrText;
    _rating.textColor      = [UIColor whiteColor];
    [self addSubview:_rating];
}

- (void)p_setupTitle
{
    NSString *titleStr  = _currentMovie.title;
    UIFont *currentFont = [UIFont RTPFontRegular:15.f];
    CGSize sizeLabel    = [titleStr sizeWithAttributes:@{NSFontAttributeName:currentFont}];
    
    _title = [UILabel new];
    _title.frame     = CGRectMake(kMargin, CGRectGetHeight(self.bounds) - (kMargin*1.5) - sizeLabel.height, sizeLabel.width, sizeLabel.height);
    _title.text      = titleStr;
    _title.font      = currentFont;
    _title.textColor = [UIColor whiteColor];
    [self addSubview:_title];
}

- (void)p_setupImdbLink
{
    UIImage *picture = [UIImage imageNamed:@"IMDb"];
    _imdbPageLink = [UIButton new];
    _imdbPageLink.frame = CGRectMake(CGRectGetWidth(self.bounds) - kMargin - picture.size.width,kMargin, kButtonSize*1.15, kButtonSize*1.15);
    [_imdbPageLink setImage:picture forState:UIControlStateNormal];
    [_imdbPageLink addTarget:self action:@selector(openImdbPage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imdbPageLink];
}

- (void)p_setupMoreDetailsButton
{
    UIImage *picture = [UIImage imageNamed:@"backButton"];
    UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, picture.size.width, picture.size.height)];
    pictureView.transform = CGAffineTransformMakeRotation(M_PI);
    _showMoreDetails = [UIButton new];
    pictureView.image = picture;
    _showMoreDetails.frame = CGRectMake(CGRectGetMidX(self.bounds) - picture.size.width/2, CGRectGetMaxY(_picture.frame) - kMargin*1.5f - picture.size.height, kButtonSize*1.15, kButtonSize*1.15);
    [_showMoreDetails addSubview:pictureView];
    [_showMoreDetails addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_showMoreDetails];
    
    NSString *synopsisStr = NSLocalizedString(@"Synopsis", nil);
    UIFont *currentFont   = [UIFont RTPFontRegular:10.f];
    CGSize sizeLabel      = [synopsisStr sizeWithAttributes:@{NSFontAttributeName:currentFont}];
    _synopsisLabel = [UILabel new];
    _synopsisLabel.frame     = CGRectMake(CGRectGetMidX(self.bounds) - sizeLabel.width/2, CGRectGetMinY(_showMoreDetails.frame) - sizeLabel.height - kMargin/2, sizeLabel.width, sizeLabel.height);
    _synopsisLabel.text      = synopsisStr;
    _synopsisLabel.font      = currentFont;
    _synopsisLabel.textColor = [UIColor whiteColor];
    [self addSubview:_synopsisLabel];
}

#pragma mark - User interactions

- (void)openImdbPage:(id)sender
{
    //-- Composing imdb's url
    NSUInteger currentId   = [_currentMovie.imdbId unsignedIntegerValue];
    NSString *currentIdStr = [_currentMovie.imdbId stringValue];
    if (currentId < 1000000) {
        NSInteger lengthZerosNum = [@"1000000" length] - currentIdStr.length;
        for (NSUInteger i = 0; i < lengthZerosNum; i++) {
            currentIdStr = [NSString stringWithFormat:@"0%@", currentIdStr];
        }
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/", kUrlImdb, currentIdStr]];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NCLog(@"%@%@",@"Failed to open url:", [url description]);
    }
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