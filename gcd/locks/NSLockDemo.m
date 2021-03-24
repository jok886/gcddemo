//
//  NSLockDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

//互斥锁 休眠
@property(strong,nonatomic) NSLock *lock;

@end

@implementation NSLockDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        //
      //  pthread_mutex_t mutex_temp = PTHREAD_MUTEX_INITIALIZER;
        //
        _lock = [[NSLock alloc]init];
        
    }
    return self;
}
- (void)saletocket
{
  //
    [_lock lock];
    [super saletocket];
    [_lock unlock];
  
}

- (void)dealloc
{

}

@end
