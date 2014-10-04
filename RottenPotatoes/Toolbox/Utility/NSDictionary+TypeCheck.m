//
//  NSDictionary+TypeCheck.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 28/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "NSDictionary+TypeCheck.h"

@implementation NSDictionary (TypeCheck)

- (id)extractDataAtKey:(NSString *)key withExpectedType:(Class)dataType
{
    if (self[key] && self[key] != [NSNull null]) {
        return [self[key] isKindOfClass:dataType] ? self[key] : nil;
    }
    return nil;
}

@end