//
//  RTPStoreManager.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 05/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RTPStoreManager : NSObject
@property (strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (copy, nonatomic) NSString *databaseName;
@property (copy, nonatomic) NSString *modelName;
+ (instancetype)sharedInstance;
- (BOOL)saveChanges;
@end