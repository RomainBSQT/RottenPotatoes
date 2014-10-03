//
//  UIImageView+RTPDownloadImage.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 19/09/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RTPDownloadImage)
- (void)downloadImageWithUrl:(NSURL *)url;
- (void)downloadImageWithUrl:(NSURL *)url fading:(BOOL)doFade;
@end
