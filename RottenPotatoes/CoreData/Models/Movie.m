//
//  Movie.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 28/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "Movie.h"
#import "CastMember.h"
#import "NSDictionary+TypeCheck.h"
#import "NSString+SerializeToDate.h"

@implementation Movie

@dynamic abridgedDirectors;
@dynamic audienceRating;
@dynamic audienceScore;
@dynamic criticsConsensus;
@dynamic criticsRating;
@dynamic criticsScore;
@dynamic dateCreated;
@dynamic distantId;
@dynamic genre;
@dynamic imdbId;
@dynamic links;
@dynamic mpaaRating;
@dynamic posters;
@dynamic releaseDvd;
@dynamic releaseTheater;
@dynamic runtime;
@dynamic studio;
@dynamic synopsis;
@dynamic title;
@dynamic year;
@dynamic relationship;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
}

#pragma mark - Setters/Getters

- (RTPMpaaRating)mpaaRatingRaw
{
    return (RTPMpaaRating)[self.mpaaRating intValue];
}

- (void)setMpaaRatingRaw:(RTPMpaaRating)mpaaRating
{
    self.mpaaRating = @(mpaaRating);
}

#pragma mark - KVO update

+ (NSSet *)keyPathsForValuesAffectingMpaaRatingRaw
{
    return [NSSet setWithObject:@"mpaaRating"];
}

#pragma mark - Serialization

- (void)serializeWithDict:(NSDictionary *)dict
{
    self.abridgedDirectors = [dict extractDataAtKey:@"abridged_directors"           withExpectedType:[NSArray class]];
    self.audienceRating    = [dict[@"ratings"] extractDataAtKey:@"audience_rating"  withExpectedType:[NSString class]];
    self.audienceScore     = [dict[@"ratings"] extractDataAtKey:@"audience_score"   withExpectedType:[NSNumber class]];
    self.criticsConsensus  = [dict extractDataAtKey:@"critics_consensus"            withExpectedType:[NSString class]];
    self.criticsRating     = [dict[@"ratings"] extractDataAtKey:@"critics_rating"   withExpectedType:[NSString class]];
    self.criticsScore      = [dict[@"ratings"] extractDataAtKey:@"critics_score"    withExpectedType:[NSNumber class]];
    self.distantId         = [dict extractDataAtKey:@"id"                           withExpectedType:[NSString class]];
    self.genre             = [dict extractDataAtKey:@"genres"                       withExpectedType:[NSArray class]];
    self.imdbId            = @([[dict[@"alternate_ids"] extractDataAtKey:@"imdb"    withExpectedType:[NSString class]] intValue]);
    self.links             = [dict extractDataAtKey:@"links"                        withExpectedType:[NSDictionary class]];
    self.mpaaRating        = @([[dict extractDataAtKey:@"mpaa_rating"               withExpectedType:[NSString class]] intValue]);
    self.posters           = [dict extractDataAtKey:@"posters"                      withExpectedType:[NSDictionary class]];
    self.releaseDvd        = [[dict[@"release_dates"] extractDataAtKey:@"dvd"       withExpectedType:[NSDate class]] serializeToDate];
    self.releaseTheater    = [[dict[@"release_dates"] extractDataAtKey:@"theater"   withExpectedType:[NSString class]] serializeToDate];
    self.runtime           = [dict extractDataAtKey:@"runtime"                      withExpectedType:[NSNumber class]];
    self.studio            = [dict extractDataAtKey:@"studio"                       withExpectedType:[NSString class]];
    self.synopsis          = [dict extractDataAtKey:@"synopsis"                     withExpectedType:[NSString class]];
    self.title             = [dict extractDataAtKey:@"title"                        withExpectedType:[NSString class]];
    self.year              = [dict extractDataAtKey:@"year"                         withExpectedType:[NSNumber class]];
}

@end
