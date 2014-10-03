//
//  NSDictionary+Sugar.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 08/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "NSDictionary+Sugar.h"

@implementation NSDictionary (Sugar)

- (void)each:(EachDictSugarCompletionHandler)block
{
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (NSArray *)map:(MapDictSugarCompletionHandler)block
{
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id object = block(key, obj);
        if (object) {
            [array addObject:object];
        }
    }];

    return array;
}

@end
