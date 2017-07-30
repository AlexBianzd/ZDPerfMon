//
//  ZDMemory.m
//  ZDPerfMonExample
//
//  Created by AlexBian on 28/06/2017.
//  Copyright © 2017 AlexBian. All rights reserved.
//

#import "ZDMemory.h"
#import <mach/mach.h>

@implementation ZDMemory

- (void)requestData {
  
  if (self.dataBlock) {
    self.dataBlock(usedMemory());
  }
}

vm_size_t usedMemory(void) {
  
  kern_return_t rval = 0;
  mach_port_t task = mach_task_self();
  
  struct task_basic_info info = {0};
  mach_msg_type_number_t tcnt = TASK_BASIC_INFO_COUNT;
  task_flavor_t flavor = TASK_BASIC_INFO;
  
  task_info_t tptr = (task_info_t) &info;
  
  if (tcnt > sizeof(info))
    return 0;
  
  rval = task_info(task, flavor, tptr, &tcnt);
  if (rval != KERN_SUCCESS) {
    return 0;
  }
  
  return info.resident_size;
}

vm_size_t freeMemory(void) {
  
  mach_port_t host_port = mach_host_self();
  mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
  vm_size_t pagesize;
  vm_statistics_data_t vm_stat;
  
  host_page_size(host_port, &pagesize);
  (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
  return vm_stat.free_count * pagesize;
}

@end
