//
//  RTPModelManager.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 21/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPModelManager.h"

static NSString *const kArchivePath = @"/models";

@implementation RTPModelManager

- (id)init
{
    self = [super init];
    if (self) {
        NCLog(@"%@", NSStringFromClass([self class]));
    }
    return self;
}

- (void)archivingDate
{
    if ([NSKeyedArchiver archiveRootObject:self.lastUpdate toFile:[self path]]) {
        NCLog(@"Archieving %@ SUCCESS", NSStringFromClass([self class]));
    } else {
        NCLog(@"Archieving %@ ERROR", NSStringFromClass([self class]));
    }
}

- (id)unarchieveDate
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
}

- (NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    NSString *completePath = [NSString stringWithFormat:@"%@%@.%@", path, kArchivePath, NSStringFromClass([self class])];
    return completePath;
}

@end
