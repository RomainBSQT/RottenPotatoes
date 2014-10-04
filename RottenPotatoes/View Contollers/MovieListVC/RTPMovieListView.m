//
//  RTPMovieListView.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 01/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPMovieListView.h"
#import "RTPMovieManager.h"
#import "RTPMovieCell.h"
#import "RTPSearchHeaderView.h"
#import "NSDictionary+TypeCheck.h"
#import "RTPWebServiceDialogManager.h"
#import "UIImageView+RTPDownloadImage.h"
#import "Movie.h"

static CGFloat const kInterItemSpacing = 2.f;
static CGFloat const kWidthCell        = (320.f - 3*kInterItemSpacing) / 2; //152.f;
static CGFloat const kHeightCell       = kWidthCell * 1.3333f;
static CGFloat const kHeightHeader     = 45.f;

@interface RTPMovieListView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UICollectionView          *collectionView;
@property (strong, nonatomic) UIRefreshControl          *refresh;
@property (strong, nonatomic) NSMutableArray            *movieArray;
@property (strong, nonatomic) NSArray                   *filteredArray;
@property (strong, nonatomic) UISearchDisplayController *searchBarController;
@property (strong, nonatomic) RTPSearchBar              *searchBar;
@property (weak, nonatomic) UIViewController            *controller;
@end

@implementation RTPMovieListView

- (id)initWithFrame:(CGRect)frame contentsController:(UIViewController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _controller = controller;
        _movieArray = [NSMutableArray new];
        [self p_setupCollectionView];
        [self p_setupSearchBarController];
        [self refreshCollection];
    }
    return self;
}

#pragma mark - Private methods

- (void)p_setupCollectionView
{
    //-- Collection view
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection         = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = kInterItemSpacing;
    flowLayout.minimumLineSpacing      = kInterItemSpacing;
    flowLayout.headerReferenceSize     = CGSizeMake(CGRectGetWidth(self.bounds), kHeightHeader);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kInterItemSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) collectionViewLayout:flowLayout];
    _collectionView.delaysContentTouches = NO;
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator   = NO;
    [self addSubview:_collectionView];
    
    //-- Refresh control
    _refresh = [UIRefreshControl new];
    [_refresh addTarget:self action:@selector(refreshCollection) forControlEvents:UIControlEventValueChanged];
    [_collectionView addSubview:_refresh];
    
    //-- Reuse ids
    [_collectionView registerClass:[RTPSearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[RTPSearchHeaderView reuseIdentifier]];
    [_collectionView registerClass:[RTPMovieCell class] forCellWithReuseIdentifier:[RTPMovieCell reuseIdentifier]];
}

- (void)p_setupSearchBarController
{
    _searchBar = [RTPSearchBar new];
    _searchBarController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:_controller];
    _searchBarController.delegate                = self;
    _searchBarController.searchResultsDataSource = self;
    _searchBarController.searchResultsDelegate   = self;
}

- (void)p_filterContentForText:(NSString *)text
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"title contains[c] %@", text];
    _filteredArray = [[_movieArray filteredArrayUsingPredicate:pred] copy];
}

#pragma mark - Public methods

- (void)refreshCollection
{
    [self.refresh beginRefreshing];
    [[RTPMovieManager sharedInstance] getBoxOffice:^(NSArray *results) {
        [self.refresh endRefreshing];
        if (results.count) {
            self.movieArray = [results copy];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        RTPSearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[RTPSearchHeaderView reuseIdentifier] forIndexPath:indexPath];
        [headerView setupSearchBar:_searchBar];
        reusableView = headerView;
    }
    return reusableView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _movieArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RTPMovieCell *cell = (RTPMovieCell *)[cv dequeueReusableCellWithReuseIdentifier:[RTPMovieCell reuseIdentifier] forIndexPath:indexPath];
    if (!cell) {
        cell = [[RTPMovieCell alloc] initWithFrame:CGRectMake(0, 0, kWidthCell, kHeightCell)];
    }
    [cell setMovie:_movieArray[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate itemSelected:_movieArray[indexPath.row]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kWidthCell, kHeightCell);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kInterItemSpacing, kInterItemSpacing, kInterItemSpacing, kInterItemSpacing);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _filteredArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const reuseId = @"SearchCellReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = [_filteredArray[indexPath.row] title];
    NSURL *urlPicture = [NSURL URLWithString:[[_filteredArray[indexPath.row] posters] extractDataAtKey:@"original" withExpectedType:[NSString class]]];
    [cell.imageView downloadImageWithUrl:urlPicture];
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate itemSelected:_filteredArray[indexPath.row]];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self p_filterContentForText:searchString];
    return YES;
}

@end
