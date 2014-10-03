//
//  RTPTransformer.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 06/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPTransformer.h"

@implementation RTPTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}

@end