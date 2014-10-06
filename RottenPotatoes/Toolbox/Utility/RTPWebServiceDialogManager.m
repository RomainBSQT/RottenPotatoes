//
//  RTPWebServiceDialogManager.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 17/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPWebServiceDialogManager.h"

@interface RTPWebServiceDialogManager () <NSURLSessionDelegate>
@property (strong, nonatomic) NSURLSession     *currentSession;
@property (strong, nonatomic) NSOperationQueue *pictureDownloadQueue;
@property (strong, nonatomic) NSCache          *pictureCache;
@end

@implementation RTPWebServiceDialogManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static RTPWebServiceDialogManager *singleton = nil;
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
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept": @"application/json"};
        sessionConfiguration.timeoutIntervalForRequest  = 30.f;
        sessionConfiguration.timeoutIntervalForResource = 60.f;
        _currentSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
        _pictureDownloadQueue = [NSOperationQueue new];
        _pictureDownloadQueue.maxConcurrentOperationCount = 6;
        _pictureCache = [NSCache new];
    }
    return self;
}

- (void)GETWithUrlType:(RTPUrlType)urlType params:(id)params completion:(DialogCompletionHandler)completionHandler
{
    NSURL *currentUrl = [RTPUrlBuilder generateUrlWithType:urlType param:params];
    [self GETWithUrl:currentUrl completionHandler:completionHandler];
}

- (void)GETWithUrl:(NSURL *)url completionHandler:(DialogCompletionHandler)completionHandler
{
    NSURLSessionDataTask *dataTask = [_currentSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (completionHandler) {
                completionHandler(NO, nil);
            }
        }
        NSError *parseError = nil;
        id parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (parseError || ![parsedData isKindOfClass:[NSDictionary class]]) {
            if (completionHandler) {
                completionHandler(NO, nil);
            }
        }
        if (completionHandler) {
            completionHandler(YES, parsedData);
        }
    }];
    [dataTask resume];
}

- (void)downloadPictureWithUrl:(NSURL *)url completionHandler:(DownloadPictureCompletionHandler)completionHandler
{
    __block NSURL *currentUrl = [url copy];
    NSString *pictureUrlStr   = currentUrl.absoluteString;
    UIImage *pictureFromCache = [self.pictureCache objectForKey:pictureUrlStr];
    
    if (pictureFromCache) {
        if (completionHandler) {
            completionHandler(pictureFromCache, NO);
        }
    } else {
        [self.pictureDownloadQueue addOperationWithBlock:^{
            UIImage *picture = [UIImage imageWithData:[NSData dataWithContentsOfURL:currentUrl]];
            if (picture) {
                [self.pictureCache setObject:picture forKey:pictureUrlStr];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if (completionHandler) {
                        completionHandler(picture, YES);
                    }
                }];
            }
        }];
    }
}

@end
