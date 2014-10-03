//
//  RTPUrlBuilder.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 18/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(char, RTPUrlType) {
    RTPUrlTypeBoxOffice,
    RTPUrlTypeMovieInfo,
    RTPUrlTypeCast,
    RTPUrlTypeClips,
    RTPUrlTypeSimilar,
    RTPUrlTypeReviews
};

@interface RTPUrlBuilder : NSObject
+ (NSURL *)generateUrlWithType:(RTPUrlType)urlType;
+ (NSURL *)generateUrlWithType:(RTPUrlType)urlType param:(id)param;
@end
