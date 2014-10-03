//
//  RTPWebServiceDialogManager.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 17/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPUrlBuilder.h"

typedef void (^DialogCompletionHandler)(BOOL success, NSDictionary *reponse);
typedef void (^DownloadPictureCompletionHandler)(UIImage *picture, BOOL isFromCache);

@interface RTPWebServiceDialogManager : NSObject
+ (instancetype)sharedInstance;
- (void)GETWithUrlType:(RTPUrlType)urlType params:(id)params completion:(DialogCompletionHandler)completionHandler;
- (void)downloadPictureWithUrl:(NSURL *)url completionHandler:(DownloadPictureCompletionHandler)completionHandler;
@end
