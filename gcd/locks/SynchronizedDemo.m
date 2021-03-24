//
//  SynchronizedDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "SynchronizedDemo.h"

@interface SynchronizedDemo ()


@end

@implementation SynchronizedDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        //
       
        
    }
    return self;
}

- (void)saletocket
{
  
    static NSObject *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc]init];
    });

    @synchronized (lock) {
        [super saletocket];
    }
    
   // @synchronized ([self class]) {
   //     [super saletocket];
   // }
  
}


@end
