//
//  NSObject_DebugMacro.h
//  RottenPotatoes
//
//  Created by Romain Bousquet on 05/08/2014.
//  Copyright (c) 2014 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

//-- Console debug
#ifdef DEBUG
    #define NCLog(s, ...) NSLog(@"<%@:%@:%d> %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
    #define NCLog(s, ...)
#endif