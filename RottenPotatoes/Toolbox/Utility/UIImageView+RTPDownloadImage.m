//
//  UIImageView+RTPDownloadImage.m
//  RottenPotatoes
//
//  Created by Romain Bousquet on 19/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import "UIImageView+RTPDownloadImage.h"
#import "RTPWebServiceDialogManager.h"

@implementation UIImageView (RTPDownloadImage)

- (void)downloadImageWithUrl:(NSURL *)url
{
    [self downloadImageWithUrl:url fading:NO];
}

- (void)downloadImageWithUrl:(NSURL *)url fading:(BOOL)doFade
{
    [[RTPWebServiceDialogManager sharedInstance] downloadPictureWithUrl:url completionHandler:^(UIImage *picture, BOOL isFromCache) {
        if (doFade && isFromCache) {
            self.alpha = 0.f;
            self.image = picture;
            [UIView animateWithDuration:0.2 animations:^{
                self.alpha = 1.f;
            }];
        } else {
            self.alpha = 1.f;
            self.image = picture;
        }
    }];
}

@end
