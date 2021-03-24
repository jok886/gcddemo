//
//  NSConditionLockDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo ()

//互斥锁 休眠

@property(strong,nonatomic) NSConditionLock *conditionlock;
@property(strong,nonatomic) NSMutableArray *data;
@end

@implementation NSConditionLockDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        //
      //  pthread_mutex_t mutex_temp = PTHREAD_MUTEX_INITIALIZER;
        //
        _conditionlock = [[NSConditionLock alloc]init];
      //  _conditionlock = [[NSConditionLock alloc]initWithCondition:1];
        _data = [NSMutableArray array];
        
    }
    return self;
}

- (void)otherTest
{
    [[[NSThread alloc]initWithTarget:self selector:@selector(remove) object:nil]start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(add) object:nil]start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(three) object:nil]start];
}
-(void)add
{
    [self.conditionlock lockWhenCondition:2];
    
    sleep(1);
    NSLog(@"two");
    
    [self.conditionlock unlockWithCondition:3];
}
-(void)remove
{
  //  [self.conditionlock lockWhenCondition:1];
    [self.conditionlock lockWhenCondition:0];
  //  [self.conditionlock lock];
    

    NSLog(@"one");
    
    [self.conditionlock unlockWithCondition:2];
    
}
-(void)three
{

    [self.conditionlock lockWhenCondition:3];
    

    NSLog(@"three");
    
    [self.conditionlock unlock];
    
}

- (void)dealloc
{

}

@end

