//
//  Movie.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 28/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(char, RTPMpaaRating) {
    NotSet = -1,
    G,      //-- General audiences
    PG,     //-- Parental guidance suggested
    PG_13,  //-- Parents strongly cautioned
    R,      //-- Restricted
    NC_17   //-- No One 17 and under admitted
};

@class CastMember;

@interface Movie : NSManagedObject

@property (nonatomic, retain) id abridgedDirectors;
@property (nonatomic, retain) NSString * audienceRating;
@property (nonatomic, retain) NSNumber * audienceScore;
@property (nonatomic, retain) NSString * criticsConsensus;
@property (nonatomic, retain) NSString * criticsRating;
@property (nonatomic, retain) NSNumber * criticsScore;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * distantId;
@property (nonatomic, retain) id genre;
@property (nonatomic, retain) NSNumber * imdbId;
@property (nonatomic, retain) id links;
@property (nonatomic, retain) NSNumber * mpaaRating;
@property (nonatomic, retain) id posters;
@property (nonatomic, retain) NSDate * releaseDvd;
@property (nonatomic, retain) NSDate * releaseTheater;
@property (nonatomic, retain) NSNumber * runtime;
@property (nonatomic, retain) NSString * studio;
@property (nonatomic, retain) NSString * synopsis;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *relationship;

- (RTPMpaaRating)mpaaRatingRaw;
- (void)setMpaaRatingRaw:(RTPMpaaRating)mpaaRating;
- (void)serializeWithDict:(NSDictionary *)dict;

@end

@interface Movie (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(CastMember *)value;
- (void)removeRelationshipObject:(CastMember *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
