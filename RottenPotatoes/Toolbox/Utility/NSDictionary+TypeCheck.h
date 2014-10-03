//
//  NSDictionary+TypeCheck.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 28/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TypeCheck)
- (id)extractDataAtKey:(NSString *)key withExpectedType:(Class)dataType;
@end
