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

@property (nonatomic, strong) ZDPerfMonItemView *cpuView;
@property (nonatomic, strong) ZDPerfMonItemView *memoryView;
@property (nonatomic, strong) ZDPerfMonItemView *fpsView;

@end

@implementation ZDPerfMonView

- (instancetype)init {
  
  self = [super initWithFrame:CGRectMake(0, 20, 160, 60)];
  if (self) {
    [self setupUI];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, 1.0);
  CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1.0);
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, 5, 20);
  CGContextAddLineToPoint(context, 155, 20);
  CGContextMoveToPoint(context, 5, 40);
  CGContextAddLineToPoint(context, 155, 40);
  CGContextStrokePath(context);
}

- (void)setupUI {
  
  self.userInteractionEnabled = NO;
  self.rootViewController = [[ZDViewController alloc] init];
  self.windowLevel        = UIWindowLevelStatusBar + 1.0f;
  self.backgroundColor    = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
  self.clipsToBounds      = YES;
  
  self.cpuView = [[ZDPerfMonItemView alloc] initWithFrame:CGRectMake(5, 0, 150, 20)];
  self.cpuView.titleLabel.text = @"CPU";
  [self addSubview:self.cpuView];
  self.memoryView = [[ZDPerfMonItemView alloc] initWithFrame:CGRectMake(5, 20, 150, 20)];
  self.memoryView.titleLabel.text = @"Memory";
  [self addSubview:self.memoryView];
  self.fpsView = [[ZDPerfMonItemView alloc] initWithFrame:CGRectMake(5, 40, 150, 20)];
  self.fpsView.titleLabel.text = @"FPS";
  [self addSubview:self.fpsView];
}

- (void)setCpuValue:(float)cpuValue {
  
  _cpuValue = cpuValue;
  _cpuView.valueLabel.text = [NSString  stringWithFormat:@"%.1f%%", cpuValue];
}

- (void)setMemoryValue:(float)memoryValue {
  
  _memoryValue = memoryValue;
  _memoryView.valueLabel.text = [NSString  stringWithFormat:@"%.1fMB", memoryValue / 1024 / 1024];
}

- (void)setFpsValue:(float)fpsValue {
  
  _fpsValue = fpsValue;
  _fpsView.valueLabel.text = [NSString  stringWithFormat:@"%.0f", fpsValue];
}

@end
