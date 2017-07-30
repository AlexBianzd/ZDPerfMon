//
//  ZDPerfMon.h
//  ZDPerfMonExample
//
//  Created by AlexBian on 25/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CADisplayLink.h>

@interface ZDPerfMon : NSObject

@property (nonatomic, strong) CADisplayLink *displayLink;

+ (instancetype)sharedInstance;

- (void)startMonitoring;

- (void)pauseMonitoring;

- (void)stopMonitoring;

@end
