//
//  CastMember.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 28/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Movie;

@interface CastMember : NSManagedObject

@property (nonatomic, retain) id characters;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSNumber * distantId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Movie *relationship;

@end
