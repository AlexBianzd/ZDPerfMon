//
//  ZDPerfMonBase.h
//  ZDPerfMonExample
//
//  Created by AlexBian on 28/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZDPerfMonBaseBlock) (float value);

@interface ZDPerfMonBase : NSObject

@property (nonatomic) ZDPerfMonBaseBlock dataBlock;
@property (nonatomic) NSInteger frameInterval;

- (void)updateDataIfNeed;

- (void)requestData;

@end
