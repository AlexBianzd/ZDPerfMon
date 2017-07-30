//
//  ZDFPS.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 28/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDFPS.h"
#import "ZDPerfMon.h"

@interface ZDFPS ()

@property (nonatomic) int screenUpdatesCount;
@property (nonatomic) CFTimeInterval screenUpdatesBeginTime;
@property (nonatomic) CFTimeInterval averageScreenUpdatesTime;

@end

@implementation ZDFPS

- (instancetype)init {
  
  self = [super init];
  if (self) {
    self.screenUpdatesCount = 0;
    self.screenUpdatesBeginTime = 0.0f;
    self.averageScreenUpdatesTime = self.frameInterval / 60.f;
  }
  return self;
}

- (void)requestData {
  
  if (self.screenUpdatesBeginTime == 0.0f) {
    self.screenUpdatesBeginTime = [ZDPerfMon sharedInstance].displayLink.timestamp;
  } else {
    self.screenUpdatesCount += 1;
    
    CFTimeInterval screenUpdatesTime = [ZDPerfMon sharedInstance].displayLink.timestamp - self.screenUpdatesBeginTime;
    
    if (screenUpdatesTime >= 1.0) {
      CFTimeInterval updatesOverSecond = screenUpdatesTime - 1.0f;
      int framesOverSecond = updatesOverSecond / self.averageScreenUpdatesTime;
      
      self.screenUpdatesCount -= framesOverSecond;
      if (self.screenUpdatesCount < 0) {
        self.screenUpdatesCount = 0;
      }
      
      if (self.dataBlock) {
        int fps = self.screenUpdatesCount;
        self.screenUpdatesCount = 0;
        self.screenUpdatesBeginTime = 0.0f;
        self.dataBlock(fps);
      }
    }
  }
}

@end
