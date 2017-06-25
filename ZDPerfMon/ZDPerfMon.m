//
//  ZDPerfMon.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 25/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDPerfMon.h"
#import "ZDPerfMonView.h"

@interface ZDPerfMon ()

@property (nonatomic, strong) ZDPerfMonView *monView;

@end

@implementation ZDPerfMon

+ (instancetype)sharedInstance {
  static id instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^ {
    instance =  [[self alloc] init];
  });
  return instance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (ZDPerfMonView *)monView {
  if (!_monView) {
    _monView = [[ZDPerfMonView alloc] init];
  }
  return _monView;
}

- (void)startMonitoring {
  self.monView.hidden = NO;
}

- (void)pauseMonitoring {
  self.monView.hidden = YES;
}

- (void)stopMonitoring {
  self.monView = nil;
}

@end
