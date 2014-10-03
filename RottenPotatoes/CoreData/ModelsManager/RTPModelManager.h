//
//  RTPModelManager.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 21/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPModelManager : NSObject
@property (strong, nonatomic) NSDate *lastUpdate;
- (void)archivingDate;
- (id)unarchieveDate;
@end
