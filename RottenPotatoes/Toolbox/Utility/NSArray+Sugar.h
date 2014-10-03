//
//  NSArray+Sugar.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 08/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EachArraySugarCompletionHandler)(id obj);
typedef id (^MapArraySugarCompletionHandler)(id obj);

@interface NSArray (Sugar)
- (void)each:(EachArraySugarCompletionHandler)block;
- (NSArray *)map:(MapArraySugarCompletionHandler)block;
@end
