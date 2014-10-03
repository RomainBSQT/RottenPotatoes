//
//  RTPMovieManager.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 18/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPModelManager.h"

typedef void (^MovieRequestCompletionHandler)(NSArray *results);

@interface RTPMovieManager : RTPModelManager
+ (instancetype)sharedInstance;
- (void)getBoxOffice:(MovieRequestCompletionHandler)completionHandler;
@end
