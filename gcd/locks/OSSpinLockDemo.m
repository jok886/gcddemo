//
//  OSSpinLockDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "OSSpinLockDemo.h"

#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo ()

//自璇锁忙等   占用CPU
@property(assign,nonatomic) OSSpinLock lock;


@end
@implementation OSSpinLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = OS_SPINLOCK_INIT;
    }
    return self;
}
- (void)saletocket
{
    
    static OSSpinLock ticketLock = OS_SPINLOCK_INIT;
    
    OSSpinLockLock(&_lock );
    
    [super saletocket];
    
    //减锁
    OSSpinLockUnlock(&_lock );
    
    
}
@end
