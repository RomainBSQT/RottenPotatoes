//
//  CastMember.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 28/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "CastMember.h"
#import "Movie.h"


@implementation CastMember

@dynamic characters;
@dynamic dateCreated;
@dynamic distantId;
@dynamic name;
@dynamic relationship;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
}

@end
