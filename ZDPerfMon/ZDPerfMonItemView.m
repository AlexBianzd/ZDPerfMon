//
//  ZDPerfMonItemView.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 25/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDPerfMonItemView.h"

@implementation ZDPerfMonItemView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.textColor = [UIColor redColor];
    [self addSubview:self.textLabel];
  }
  return self;
}

@end
