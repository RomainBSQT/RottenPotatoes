//
//  NSManagedObject+Helper.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 07/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Helper)
+ (NSManagedObjectContext *)defaultContext;
@end

@interface NSManagedObject (Helper)

- (BOOL)save;
+ (id)create;
+ (NSArray *)all;
+ (NSUInteger)count;
- (void)deleteEntry;
+ (NSArray *)applyPredicate:(NSPredicate *)predicate;
+ (NSArray *)where:(id)condition, ...;
+ (NSArray *)where:(id)condition order:(id)order;

@end
