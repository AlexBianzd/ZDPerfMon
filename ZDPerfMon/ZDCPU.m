//
//  ZDCPU.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 28/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDCPU.h"
#import <mach/mach.h>

@implementation ZDCPU

- (void)requestData {
  
  if (self.dataBlock) {
    self.dataBlock(usedCPU());
  }
}

float usedCPU(void) {
  
  kern_return_t kern;
  
  thread_array_t threadList;
  mach_msg_type_number_t threadCount;
  
  thread_info_data_t threadInfo;
  mach_msg_type_number_t threadInfoCount;
  
  thread_basic_info_t threadBasicInfo;
  uint32_t threadStatistic = 0;
  
  kern = task_threads(mach_task_self(), &threadList, &threadCount);
  if (kern != KERN_SUCCESS) {
    return 0;
  }
  if (threadCount > 0) {
    threadStatistic += threadCount;
  }
  
  float totalUsageOfCPU = 0;
  
  for (int i = 0; i < threadCount; i++) {
    threadInfoCount = THREAD_INFO_MAX;
    kern = thread_info(threadList[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount);
    if (kern != KERN_SUCCESS) {
      return 0;
    }
    
    threadBasicInfo = (thread_basic_info_t)threadInfo;
    
    if (!(threadBasicInfo -> flags & TH_FLAGS_IDLE)) {
      totalUsageOfCPU = totalUsageOfCPU + threadBasicInfo -> cpu_usage / (float)TH_USAGE_SCALE * 100.0f;
    }
  }
  
  kern = vm_deallocate(mach_task_self(), (vm_offset_t)threadList, threadCount * sizeof(thread_t));
  return totalUsageOfCPU;
}

@end
