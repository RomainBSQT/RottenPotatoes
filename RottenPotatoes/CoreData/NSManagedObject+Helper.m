//
//  NSManagedObject+Helper.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 07/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "NSManagedObject+Helper.h"
#import "RTPStoreManager.h"
#import "NSDictionary+Sugar.h"

@implementation NSManagedObjectContext (Helper)

+ (NSManagedObjectContext *)defaultContext
{
    return [[RTPStoreManager sharedInstance] managedObjectContext];
}

@end

@implementation NSManagedObject (Helper)

#pragma mark - Public methods

- (BOOL)save
{
    return [self p_saveContext];
}

+ (NSUInteger)count
{
    NSFetchRequest *request = [[self class] p_createFetchRequestInContext:[NSManagedObjectContext defaultContext]];
    request.includesSubentities = NO;
    NSError *error = nil;
    NSUInteger count = [[NSManagedObjectContext defaultContext] countForFetchRequest:request error:&error];
    if (count == NSNotFound || error) {
        return 0;
    }
    return count;
}

- (void)deleteEntry
{
    [self.managedObjectContext deleteObject:self];
}

+ (void)deleteAll
{
    [self deleteAllInContext:[NSManagedObjectContext defaultContext]];
}

+ (id)create
{
    return [self p_createInContext:[NSManagedObjectContext defaultContext]];
}

+ (id)createInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self p_entityName] inManagedObjectContext:context];
}

+ (NSArray *)all
{
    return [self p_allInContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)applyPredicate:(NSPredicate *)predicate
{
    return [self where:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)where:(id)condition, ...
{
    va_list va_arguments;
    va_start(va_arguments, condition);
    NSPredicate *predicate = [self p_predicateFromObject:condition arguments:va_arguments];
    va_end(va_arguments);

    return [self where:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)where:(id)condition order:(id)order
{
    return [self where:condition inContext:[NSManagedObjectContext defaultContext] order:order limit:nil];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context
{
    return [self where:condition inContext:context order:nil limit:nil];
}

+ (NSArray *)where:(id)condition inContext:(NSManagedObjectContext *)context order:(id)order limit:(NSNumber *)limit
{
    return [self p_fetchWithCondition:condition inContext:context withOrder:order fetchLimit:limit];
}

#pragma mark - Private methods

+ (NSArray *)p_allInContext:(NSManagedObjectContext *)context
{
    return [self p_allInContext:context order:nil];
}

+ (NSArray *)p_allInContext:(NSManagedObjectContext *)context order:(id)order
{
    return [self p_fetchWithCondition:nil inContext:context withOrder:order fetchLimit:nil];
}

+ (id)p_createInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self p_entityName] inManagedObjectContext:context];
}

+ (NSString *)p_entityName
{
    return NSStringFromClass(self);
}

+ (void)deleteAllInContext:(NSManagedObjectContext *)context
{
    [((NSArray *)[self p_allInContext:context]) each:^(id obj) {
        [obj deleteEntry];
    }];
}

+ (NSFetchRequest *)p_createFetchRequestInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self p_entityName] inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}

+ (NSPredicate *)p_predicateFromObject:(id)condition
{
    return [self p_predicateFromObject:condition arguments:NULL];
}

+ (NSPredicate *)p_predicateFromObject:(id)condition arguments:(va_list)arguments {
    if ([condition isKindOfClass:[NSPredicate class]]) {
        return condition;
    }
    if ([condition isKindOfClass:[NSString class]]) {
        return [NSPredicate predicateWithFormat:condition arguments:arguments];
    }
    if ([condition isKindOfClass:[NSDictionary class]]) {
        return [self p_predicateFromDictionary:condition];
    }
    return nil;
}

+ (NSPredicate *)p_predicateFromDictionary:(NSDictionary *)dict
{
    NSArray *subPredicates = [dict map:^(id k, id value) {
        return [NSPredicate predicateWithFormat:@"%K = %@", k, value];
    }];
    return [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
}

+ (NSArray *)p_fetchWithCondition:(id)condition inContext:(NSManagedObjectContext *)context withOrder:(id)order fetchLimit:(NSNumber *)fetchLimit
{
    NSFetchRequest *request = [self p_createFetchRequestInContext:context];
    if (condition) {
        [request setPredicate:[self p_predicateFromObject:condition]];
    }
    if (order) {
        [request setSortDescriptors:[self p_sortDescriptorsFromObject:order]];
    }
    if (fetchLimit) {
        [request setFetchLimit:[fetchLimit integerValue]];
    }
    return [context executeFetchRequest:request error:nil];
}

+ (NSSortDescriptor *)p_sortDescriptorFromDictionary:(NSDictionary *)dict
{
    BOOL isAscending = ![[[dict.allValues firstObject] uppercaseString] isEqualToString:@"DESC"];
    return [NSSortDescriptor sortDescriptorWithKey:[dict.allKeys firstObject] ascending:isAscending];
}

+ (NSSortDescriptor *)p_sortDescriptorFromString:(NSString *)order
{
    NSArray *components = [order componentsSeparatedByString:order];
    NSString *key       = [components firstObject];
    NSString *value     = [components count] > 1 ? components[1] : @"ASC";

    return [self p_sortDescriptorFromDictionary:@{key: value}];

}

+ (NSSortDescriptor *)p_sortDescriptorFromObject:(id)order
{
    if ([order isKindOfClass:[NSSortDescriptor class]])
        return order;
    if ([order isKindOfClass:[NSString class]])
        return [self p_sortDescriptorFromString:order];
    if ([order isKindOfClass:[NSDictionary class]])
        return [self p_sortDescriptorFromDictionary:order];
    return nil;
}

+ (NSArray *)p_sortDescriptorsFromObject:(id)order
{
    if ([order isKindOfClass:[NSString class]]) {
        order = [order componentsSeparatedByString:@","];
    }
    if ([order isKindOfClass:[NSArray class]]) {
        return [((NSArray *)order) map:^id (id object) {
            return [self p_sortDescriptorFromObject:object];
        }];
    }
    return @[[self p_sortDescriptorFromObject:order]];
}

- (BOOL)p_saveContext
{
    if (self.managedObjectContext == nil || ![self.managedObjectContext hasChanges]) {
        return YES;
    }
    NSError *error = nil;
    BOOL save = [self.managedObjectContext save:&error];
    if (!save || error) {
        NCLog(@"Error occured while saving context in entity:%@\nError: %@", self, error);
        return NO;
    }
    return YES;
}

@end
