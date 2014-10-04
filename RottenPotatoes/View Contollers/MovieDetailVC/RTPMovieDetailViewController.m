//
//  RTPMovieDetailViewController.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 18/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPMovieDetailViewController.h"
#import "RTPDetailMovieView.h"
#import "RTPMoreDetailMovieView.h"

@interface RTPMovieDetailViewController () <RTPDetailMovieDelegate, RTPMoreDetailMovieDelegate> {
    CGRect detailsFrame;
    CGRect moreDetailsFrame;
}
@property (strong, nonatomic) UIView                 *tankView;
@property (strong, nonatomic) RTPDetailMovieView     *detailMovieView;
@property (strong, nonatomic) RTPMoreDetailMovieView *moreDetailsMovieView;
@end

@implementation RTPMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor blackColor];
    
    detailsFrame     = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)*2);
    moreDetailsFrame = CGRectMake(0, -CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)*2);
    
    self.tankView = [UIView new];
    self.tankView.frame           = detailsFrame;
    self.tankView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tankView];
    
    self.detailMovieView = [[RTPDetailMovieView alloc] initWithFrame:self.view.bounds movie:_currentMovie];
    self.detailMovieView.delegate = self;
    [self.tankView addSubview:_detailMovieView];
    
    self.moreDetailsMovieView = [[RTPMoreDetailMovieView alloc] initWithFrame:CGRectOffset(self.view.bounds, 0, CGRectGetHeight(self.view.bounds)) movie:_currentMovie];
    self.moreDetailsMovieView.delegate = self;
    [self.tankView addSubview:_moreDetailsMovieView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Animations

- (void)toDetails
{
    [UIView animateWithDuration:0.4f delay:0.1f usingSpringWithDamping:0.6f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tankView.frame = detailsFrame;
    } completion:nil];
}

- (void)toMoreDetails
{
    [UIView animateWithDuration:0.4f delay:0.1f usingSpringWithDamping:0.6f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tankView.frame = moreDetailsFrame;
    } completion:nil];
}

#pragma mark - RTPDetailMovieDelegate

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToDetails:(id)sender
{
    (sender == _detailMovieView) ? [self toMoreDetails] : [self toDetails];
}

@end
