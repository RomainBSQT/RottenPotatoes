//
//  NSString+SerializeToDate.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 30/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "NSString+SerializeToDate.h"

@implementation NSString (SerializeToDate)

- (NSDate *)serializeToDate
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateFromString = [NSDate new];
    dateFromString = [dateFormatter dateFromString:self];
    return dateFromString;
}

@end
