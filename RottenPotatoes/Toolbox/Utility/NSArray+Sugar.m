//
//  NSArray+Sugar.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 08/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "NSArray+Sugar.h"

@implementation NSArray (Sugar)

- (void)each:(EachArraySugarCompletionHandler)block
{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (NSArray *)map:(MapArraySugarCompletionHandler)block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id object in self) {
        id newObject = block(object);
        if (newObject) {
            [array addObject:newObject];
        }
    }
    return array;
}

@end
