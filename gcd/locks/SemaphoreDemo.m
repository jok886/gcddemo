//
//  SemaphoreDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()
@property(strong,nonatomic) dispatch_semaphore_t semaphore;
@property(strong,nonatomic) dispatch_semaphore_t ticketSemaphore;

@end

@implementation SemaphoreDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        // 5个并发
        self.semaphore = dispatch_semaphore_create(5);
        //
        self.ticketSemaphore = dispatch_semaphore_create(1);
        
    }
    return self;
}

-(void)otherTest
{
    for (int i = 0; i < 20; i++) {
        [[[NSThread alloc]initWithTarget:self selector:@selector(test) object:nil] start];
    }
}
-(void)test
{
    //信号量 > 0 ,就让信号量减1 ，继续执行
    //信号量 <=0  ,就会休眠等待，直到信号量值>0 就让信号量减1 ，继续执行
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    sleep(1);
    NSLog(@"------%@",[NSThread currentThread]);
    //信号量值+1 
    dispatch_semaphore_signal(self.semaphore);
    
}

- (void)saletocket
{
  
    dispatch_semaphore_wait(self.ticketSemaphore, DISPATCH_TIME_FOREVER);
    
    [super saletocket];
    
    dispatch_semaphore_signal(self.ticketSemaphore);

    
    
}


@end
