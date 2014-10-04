//
//  RTPMovieListViewController.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 17/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPMovieListViewController.h"
#import "RTPMovieDetailViewController.h"
#import "RTPDesignConsts.h"
#import "RTPMovieListView.h"
#import "Movie.h"

static NSString *const kSegueId = @"toDetailMovie";

@interface RTPMovieListViewController () <RTPMovieListDelegate>
@property (strong, nonatomic) RTPMovieListView *movieListView;
@property (weak, nonatomic) Movie *selectedMovie;
@end

@implementation RTPMovieListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self p_setupNavigationBar];
    
    _movieListView = [[RTPMovieListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kHeightNavStatusBar) contentsController:self];
    _movieListView.delegate = self;
    [self.view addSubview:_movieListView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)p_setupNavigationBar
{
    self.navigationController.navigationBar.translucent     = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor RTPGrayStrong];
    
    CGRect titleViewRect = CGRectMake(0, 0, 170, 30);
    UILabel *title = [UILabel new];
    title.frame         = titleViewRect;
    title.textColor     = [UIColor whiteColor];
    title.font          = [UIFont RTPFontBold:18.f];
    title.text          = NSLocalizedString(@"BOX OFFICE", nil);
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueId]) {
        RTPMovieDetailViewController *dvc = (RTPMovieDetailViewController *)[segue destinationViewController];
        dvc.currentMovie = _selectedMovie;
    }
}

#pragma mark - RTPMovieListDelegate

- (void)itemSelected:(id)item
{
    if ([item isKindOfClass:[Movie class]]) {
        self.selectedMovie = item;
        [self performSegueWithIdentifier:kSegueId sender:self];
    }
}

@end
