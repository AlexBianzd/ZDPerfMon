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
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blueColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.titleLabel];
    self.valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.textColor = [UIColor redColor];
    self.valueLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.valueLabel];
  }
  return self;
}

@end
