//
//  ZDPerfMonBase.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 28/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDPerfMonBase.h"

@interface ZDPerfMonBase ()

@property (nonatomic) NSInteger updateCounter;

@end

@implementation ZDPerfMonBase

- (instancetype)init {
  
  self = [super init];
  if (self) {
    self.updateCounter = 0;
    self.frameInterval = 1;
  }
  return self;
}

- (void)updateDataIfNeed {
  
  self.updateCounter += 1;
  if (self.updateCounter >= self.frameInterval) {
    self.updateCounter = 0;
    [self requestData];
  }
}

- (void)requestData {
  
}

@end
