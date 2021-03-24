//
//  OSUnfairLockDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@interface OSUnfairLockDemo ()

//
@property(assign,nonatomic) os_unfair_lock lock;


@end

//互斥锁 ，休眠/
//
//
@implementation OSUnfairLockDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}


//os_unfair_lock 会处于休眠状态不是忙等
- (void)saletocket
{
   // static os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    
   // os_unfair_lock_trylock(&lock);
    
    os_unfair_lock_lock(&_lock);
    
    [super saletocket];
    
    os_unfair_lock_unlock(&_lock);
    
    
}
@end
