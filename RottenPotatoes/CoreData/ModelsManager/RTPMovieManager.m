//
//  RTPMovieManager.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 18/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPMovieManager.h"
#import "RTPWebServiceDialogManager.h"
#import "Movie.h"
#import "NSManagedObject+Helper.h"
#import "NSDictionary+TypeCheck.h"

static CGFloat const kTimeRefresh = 3600.f * 24.f; //- one day

@interface RTPMovieManager ()
@end

@implementation RTPMovieManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static RTPMovieManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self class] new];
    });
    return singleton;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)getBoxOffice:(MovieRequestCompletionHandler)completionHandler
{
    NSTimeInterval currentTimeStamp = [[NSDate date] timeIntervalSince1970];
    if (currentTimeStamp - kTimeRefresh > [self.lastUpdate timeIntervalSince1970]) {
        [self p_requestMovies:completionHandler];
    } else {
        [self p_getLocalMovies:completionHandler];
    }
}

#pragma mark - Private methods

- (void)p_getLocalMovies:(MovieRequestCompletionHandler)completionHandler
{
    if (completionHandler) {
        completionHandler([Movie all]);
    }
}

- (void)p_requestMovies:(MovieRequestCompletionHandler)completionHandler
{
    [[RTPWebServiceDialogManager sharedInstance] GETWithUrlType:RTPUrlTypeBoxOffice params:nil completion:^(BOOL success, NSDictionary *reponse) {
        if (success) {
            [((NSArray *)reponse[@"movies"]) each:^(id obj) {
                [self p_serializeObject:obj];
            }];
            self.lastUpdate = [NSDate date];
            [self p_getLocalMovies:completionHandler];
        } else {
            if (completionHandler) {
                completionHandler(nil);
            }
        }
    }];
}

- (void)p_serializeObject:(NSDictionary *)dict
{
    NSString *currentId = [dict extractDataAtKey:@"id" withExpectedType:[NSString class]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"distantId == %@", currentId];
    NSArray *results = [Movie applyPredicate:pred];
    if (results.count) {
        return;
    }
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    Movie *newMovie = [Movie create];
    [newMovie serializeWithDict:dict];
    [newMovie save];
}

@end