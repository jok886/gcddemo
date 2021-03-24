//
//  NSConditionDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo ()

//互斥锁 休眠

@property(strong,nonatomic) NSCondition *condition;
@property(strong,nonatomic) NSMutableArray *data;
@end

@implementation NSConditionDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        //
      //  pthread_mutex_t mutex_temp = PTHREAD_MUTEX_INITIALIZER;
        //

        _condition = [[NSCondition alloc]init];
        _data = [NSMutableArray array];
        
    }
    return self;
}

- (void)otherTest
{
    [[[NSThread alloc]initWithTarget:self selector:@selector(remove) object:nil]start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(add) object:nil]start];
    
}
-(void)add
{
    [self.condition lock];
    
    sleep(1);
    [self.data addObject:@"test"];
    NSLog(@"add了元素");
    
    //信号
    [self.condition signal];
   // [self.condition broadcast];
    
    sleep(2);
    
    [self.condition unlock];
}
-(void)remove
{
    NSLog(@"remove---begin");
    [self.condition lock];
    
    
    if (self.data.count == 0) {
        //等待
        [self.condition wait];
    }
    [self.data removeLastObject];
    NSLog(@"删除了元素");
    
    [self.condition unlock];
    
}

- (void)dealloc
{

}

@end
