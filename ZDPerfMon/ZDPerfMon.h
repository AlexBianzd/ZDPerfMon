//
//  ZDPerfMon.h
//  ZDPerfMonExample
//
//  Created by AlexBian on 25/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDPerfMon : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitoring;

- (void)pauseMonitoring;

- (void)stopMonitoring;

@end
