//
//  RTPUrlBuilder.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 18/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "RTPUrlBuilder.h"

//-- Webservice url components
const static NSString *baseUrl   = @"http://xebiamobiletest.herokuapp.com/api/public/v1.0/";
const static NSString *boxOffice = @"lists/movies/box_office.json";
const static NSString *movieInfo = @"movies/%@.json";
const static NSString *cast      = @"movies/%@/cast.json";
const static NSString *clips     = @"movies/%@/clips.json";
const static NSString *similar   = @"movies/%@/similar.json";
const static NSString *reviews   = @"movies/%@/reviews.json";

//-- Utils declaration
NSString* NSStringFormatFromUrlType(RTPUrlType urlType);

@implementation RTPUrlBuilder

#pragma mark - Public methods

+ (NSURL *)generateUrlWithType:(RTPUrlType)urlType
{
    return [[self class] generateUrlWithType:urlType param:nil];
}

+ (NSURL *)generateUrlWithType:(RTPUrlType)urlType param:(id)param
{
    if (!param && urlType != RTPUrlTypeBoxOffice) {
        NCLog(@"ERROR::This url need a param to work, url:[%@]", NSStringFormatFromUrlType(urlType));
        return nil;
    }
    if (param && ![param isKindOfClass:[NSString class]] && ![param isKindOfClass:[NSNumber class]]) {
        NCLog(@"ERROR::Wrong format for param on url:[%@]", NSStringFormatFromUrlType(urlType));
        return nil;
    }
    NSString *formatedUrlStr;
    if (!param) {
        formatedUrlStr = NSStringFormatFromUrlType(urlType);
    } else {
        formatedUrlStr = [NSString stringWithFormat:NSStringFormatFromUrlType(urlType), param];
    }
    return [NSURL URLWithString:formatedUrlStr];
}

@end

#pragma mark - Utils

NSString* NSStringFormatFromUrlType(RTPUrlType urlType) {
    NSString *completeUrl = [baseUrl copy];
    NSString *varUrl = @"";
    switch (urlType) {
        case RTPUrlTypeBoxOffice: varUrl = [boxOffice copy]; break;
        case RTPUrlTypeMovieInfo: varUrl = [movieInfo copy]; break;
        case RTPUrlTypeCast:      varUrl = [cast copy]; break;
        case RTPUrlTypeClips:     varUrl = [clips copy]; break;
        case RTPUrlTypeSimilar:   varUrl = [similar copy]; break;
        case RTPUrlTypeReviews:   varUrl = [reviews copy]; break;
    }
    completeUrl = [completeUrl stringByAppendingString:varUrl];
    return completeUrl;
}