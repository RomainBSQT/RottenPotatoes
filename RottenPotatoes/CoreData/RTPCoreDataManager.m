//
//  RTPCoreDataManager.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 06/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPCoreDataManager.h"
#import "RTPStoreManager.h"

@interface RTPCoreDataManager ()
@property (weak, nonatomic, readonly) NSManagedObjectContext *context;
@end

@implementation RTPCoreDataManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static RTPCoreDataManager *singleton = nil;
    static dispatch_once_t    onceToken;
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
        _context = [[RTPStoreManager sharedInstance] managedObjectContext];
    }
    return self;
}

@end