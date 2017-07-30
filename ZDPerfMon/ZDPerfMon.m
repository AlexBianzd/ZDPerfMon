//
//  ZDPerfMon.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 25/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDPerfMon.h"
#import "ZDCPU.h"
#import "ZDMemory.h"
#import "ZDFPS.h"
#import "ZDPerfMonView.h"

@interface ZDPerfMon ()

@property (nonatomic, strong) NSMutableArray *itemArr;
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
#pragma mark - Init Methods
- (instancetype)init {
  
  self = [super init];
  if (self) {
    [self setupDisplayLink];
    [self setupPerfMonItems];
  }
  return self;
}

#pragma mark - Public Methods
- (void)startMonitoring {
  
  self.displayLink.paused = NO;
  self.monView.hidden = NO;
}

- (void)pauseMonitoring {
  
  self.displayLink.paused = YES;
  self.monView.hidden = YES;
}

- (void)stopMonitoring {
  
  self.displayLink.paused = YES;
  [self.displayLink invalidate];
  self.monView = nil;
}

- (ZDPerfMonView *)monView {
  
  if (!_monView) {
    _monView = [[ZDPerfMonView alloc] init];
  }
  return _monView;
}

#pragma mark - Private Methods

- (void)setupDisplayLink {
  
  self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
  [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setupPerfMonItems {
  
  self.itemArr = [NSMutableArray array];
  ZDPerfMonBase *cpu = [[ZDCPU alloc] init];
  cpu.frameInterval  = 60;
  cpu.dataBlock = ^(float value) {
    self.monView.cpuValue = value;
  };
  [self.itemArr addObject:cpu];
  ZDPerfMonBase *memory = [[ZDMemory alloc] init];
  memory.frameInterval  = 60;
  memory.dataBlock = ^(float value) {
    self.monView.memoryValue = value;
  };
  [self.itemArr addObject:memory];
  ZDPerfMonBase *fps = [[ZDFPS alloc] init];
  fps.frameInterval  = 1;
  fps.dataBlock = ^(float value) {
    self.monView.fpsValue = value;
  };
  [self.itemArr addObject:fps];
}

- (void)displayLinkAction:(CADisplayLink *)displayLink {
  
  for (ZDPerfMonBase *base in self.itemArr) {
    [base updateDataIfNeed];
  }
}

@end
