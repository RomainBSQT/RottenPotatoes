//
//  NSDictionary+Sugar.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 08/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

typedef void (^EachDictSugarCompletionHandler)(id k, id value);
typedef id (^MapDictSugarCompletionHandler)(id k, id value);

@interface NSDictionary (Sugar)
- (void)each:(EachDictSugarCompletionHandler)block;
- (NSArray *)map:(MapDictSugarCompletionHandler)block;
@end