//
//  MutexDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "MutexDemo.h"

#import <pthread.h>
@interface MutexDemo ()

//互斥锁 休眠
@property(assign,nonatomic) pthread_mutex_t mutex;
@property(assign,nonatomic) pthread_cond_t cond;
@end

@implementation MutexDemo

-(void)initMutex:(pthread_mutex_t *)mutex
{
    //递归锁  ,允许重复解锁
    
    
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
   // PTHREAD_MUTEX_RECURSIVE  递归锁，可解决死锁
    //PTHREAD_MUTEX_DEFAULT
    //
    pthread_mutex_init(mutex, &attr);
   // pthread_mutex_init(mutex, NULL);
    //
    pthread_mutexattr_destroy(&attr);
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //
      //  pthread_mutex_t mutex_temp = PTHREAD_MUTEX_INITIALIZER;
        //
        [self initMutex:&_mutex];
        
        pthread_cond_init(&_cond, NULL);
        
    }
    return self;
}
- (void)saletocket
{
    pthread_mutex_lock(&_mutex);
    [super saletocket];
    
   // if (==0) {
        //等待
    //    pthread_cond_wait(&cons, &_mutex)
  //  }
    
    //有信号激活
  //  pthread_cond_signal(&cond)
  //  pthread_cond_broadcast(&_cond)
    
    
    pthread_mutex_unlock(&_mutex);
}

- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}

@end
