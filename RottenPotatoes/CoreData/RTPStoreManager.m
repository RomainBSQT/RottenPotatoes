//
//  RTPStoreManager.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 05/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPStoreManager.h"

@implementation RTPStoreManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static RTPStoreManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self class] new];
    });
    return singleton;
}

#pragma mark - Private methods

- (NSString *)p_appName
{
    return [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleName"];
}

#pragma mark - Public methods

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    if (self.persistentStoreCoordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle bundleForClass:[self class]] URLForResource:[self modelName] withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [self p_persistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:[self p_sqliteStoreURL]];
    return _persistentStoreCoordinator;
}

- (BOOL)saveChanges
{
    NSError *error = nil;
    BOOL successful = [[self managedObjectContext] save:&error];
    if (!successful) {
        NCLog(@"Error while saving: %@", error.localizedDescription);
    }
    return successful;
}

#pragma mark - SQLite file directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)applicationSupportDirectory
{
    return [[[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[self p_appName]];
}

- (NSString *)databaseName
{
    if (_databaseName) {
        return _databaseName;
    }
    self.databaseName = [[[self p_appName] stringByAppendingString:@".sqlite"] copy];
    return _databaseName;
}

- (NSString *)p_modelName
{
    if (_modelName) {
        return _modelName;
    }
    self.modelName = [[self p_appName] copy];
    return _modelName;
}

#pragma mark - Private

- (NSPersistentStoreCoordinator *)p_persistentStoreCoordinatorWithStoreType:(NSString *const)storeType storeURL:(NSURL *)storeURL
{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES};
    NSError *error = nil;
    if (![coordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
        @throw [NSException exceptionWithName:@"Open Failure" reason:error.localizedDescription userInfo:nil];
    }
    return coordinator;
}

- (NSURL *)p_sqliteStoreURL
{
    NSURL *directory   = self.applicationDocumentsDirectory;
    NSURL *databaseDir = [directory URLByAppendingPathComponent:[self databaseName]];
    [self p_createApplicationSupportDirIfNeeded:directory];
    return databaseDir;
}

- (void)p_createApplicationSupportDirIfNeeded:(NSURL *)url
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:url.absoluteString]) {
        return;
    }
    [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:nil];
}

@end