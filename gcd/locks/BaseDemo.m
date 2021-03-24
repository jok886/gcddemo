//
//  BaseDemo.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "BaseDemo.h"




@interface BaseDemo ()
@property(assign,nonatomic) int count;
//自璇锁忙等   占用CPU
//@property(assign,nonatomic) OSSpinLock lock;


@end


@implementation BaseDemo


-(void)saleTickets
{
    

    
  //  for(int i= 0;i < 10;i++)
  //  {
       // [[[NSThread alloc] initWithTarget:self selector:@selector(saletocket) object:nil]start];
  //  }
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_async(queue, ^{
        for (int i=0; i < 10; i++) {
          [self saletocket];
        }
    });
    dispatch_async(queue, ^{
        for (int i=0; i < 10; i++) {
          [self saletocket];
        }
    });
    dispatch_async(queue, ^{
        for (int i=0; i < 10; i++) {
          [self saletocket];
        }
    });
}


/*
 //OSSpinLockLock  自旋锁 忙等，占用cpu  ,优先级翻转
 
 
 */
-(void)saletocket
{
   //加锁


    
    
    int old = self.count;
    sleep(.2);
    old--;
    if(old<=0) return;
    self.count = old;
    NSLog(@"还剩----%d张票--%@",self.count,[NSThread currentThread]);
    
    

}





@end
