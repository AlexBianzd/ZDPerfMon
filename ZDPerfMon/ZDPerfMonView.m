//
//  ZDPerfMonView.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 25/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDPerfMonView.h"
#import "ZDViewController.h"
#import "ZDPerfMonItemView.h"

@interface ZDPerfMonView ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic) int screenUpdateCount;
@property (nonatomic) CFTimeInterval screenUpdateBeginTime;
@property (nonatomic) CFTimeInterval averageScreenUpdateTime;

@property (nonatomic, strong) ZDPerfMonItemView *fpsView;

@end

@implementation ZDPerfMonView

#pragma mark - Init Methods

- (instancetype)init {
  self = [super initWithFrame:CGRectMake(0, 0, 200, 100)];
  if (self) {
    [self setupConfig];
    [self setupUI];
    [self setupDisplayLink];
  }
  return self;
}

#pragma mark - Default Setups

- (void)setupConfig {
  self.screenUpdateCount = 0;
  self.screenUpdateBeginTime = 0.0f;
  self.averageScreenUpdateTime = 1.f / 60.f;
}

- (void)setupUI {
  self.rootViewController = [[ZDViewController alloc] init];
  self.windowLevel        = UIWindowLevelStatusBar + 1.0f;
  self.backgroundColor    = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
  self.clipsToBounds      = YES;
  
  self.fpsView = [[ZDPerfMonItemView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
  [self addSubview:self.fpsView];
}

- (void)setupDisplayLink {
  self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
  [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Monitoring

- (void)displayLinkAction:(CADisplayLink *)displayLink {
  if (self.screenUpdateBeginTime == 0.0f) {
    self.screenUpdateBeginTime = displayLink.timestamp;
  } else {
    self.screenUpdateCount += 1;
    
    CFTimeInterval screenUpdateTime = self.displayLink.timestamp - self.screenUpdateBeginTime;
    
    if (screenUpdateTime >= 1.0) {
      CFTimeInterval updateOverSecond = screenUpdateTime - 1.0f;
      int frameOverSecond = updateOverSecond / self.averageScreenUpdateTime;
      
      self.screenUpdateCount -= frameOverSecond;
      if (self.screenUpdateCount < 0) {
        self.screenUpdateCount = 0;
      }
      
      [self readParameters];
    }
  }
}

- (void)readParameters  {
  int fps = self.screenUpdateCount;
  
  self.screenUpdateCount = 0;
  self.screenUpdateBeginTime = 0.0f;
  
  [self updateMonitoringWithFPS:fps];
}

- (void)updateMonitoringWithFPS:(int)fpsValue {
  self.fpsView.textLabel.text = [NSString stringWithFormat:@"FPS : %d", fpsValue];
}

@end
