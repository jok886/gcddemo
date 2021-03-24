//
//  ViewController.m
//  gcd
//
//  Created by macliu on 2021/3/20.
//


//xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m


//xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-9.0.0 main.m

//https://opensource.apple.com/tarballs/   objc4-723.tar


//http://www.gnustep.org/resources/downloads.php  gnustep-base-1.26.0




/*

一 什么情况使用自旋锁比较划算
。预计线程等待锁的时间很短
 。加锁的代码（临界区）经常被调用，但竞争情况很少发生
 、cpu资源不紧张
 。多核处理器

二 什么情况使用互斥锁比较换算
、预计线程等待时间比较长
 、单核处理器
 、临界区有IO操作
 、临界区代码复杂或者循环量大
 临界区竞争非常激烈



*/


#import "ViewController.h"
#import <libkern/OSAtomic.h>

#import "BaseDemo.h"
#import "OSSpinLockDemo.h"

@interface ViewController ()

@property(strong,nonatomic) OSSpinLockDemo *basedemo;

@property(assign,nonatomic) int count;

//自璇锁忙等   占用CPU
@property(assign,nonatomic) OSSpinLock lock;





@end

@implementation ViewController




/*
 dispatch_sync    dispatch_async 异步， 是否具备开启新线程能力
 
 //串行 并行  ---
 、、1.主队列串行
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = 10;
    
    _lock = OS_SPINLOCK_INIT;
    
   // [self saleTickets];
    

    
    self.basedemo = [[OSSpinLockDemo alloc]init];
    [self.basedemo saleTickets];
    
}
-(void)test2
{
    static dispatch_semaphore_t semphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semphore = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
    //.......
    
    
    
    
    
    dispatch_semaphore_signal(semphore);
    
}

-(void)qq
{
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_queue_t queue = dispatch_queue_create("4243243", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_async(group, queue, ^{
        for (int i=0; i < 10; i++) {
            NSLog(@"任务1 --%@",[NSThread currentThread]);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i=0; i < 10; i++) {
            NSLog(@"任务2 --%@",[NSThread currentThread]);
        }
    });
    dispatch_group_notify(group, queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0; i < 10; i++) {
                NSLog(@"任务3 --%@",[NSThread currentThread]);
            }
        });
    });
    dispatch_group_notify(group, queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0; i < 10; i++) {
                NSLog(@"任务3 --%@",[NSThread currentThread]);
            }
        });
    });
}
-(void)ww
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_async(queue, ^{
        NSLog(@"1");
        //0 没执行--子线程没runloop
        [self performSelector:@selector(one) withObject:nil afterDelay:.0];
        NSLog(@"3");
        
       // [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
       // [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    });
}
-(void)one
{
    NSLog(@"2");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSThread *thread = [[NSThread alloc]initWithBlock:^{
        NSLog(@"1");
        
        // [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
        // [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
         
        
    }];
    [thread start];
    
    [self performSelector:@selector(one) onThread:thread withObject:nil waitUntilDone:YES];
    
}




-(void)test
{
    // dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    // dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
     dispatch_async(queue, ^{
         for (int i=0; i < 10; i++) {
             NSLog(@"任务1 --%@",[NSThread currentThread]);
         }
     });
     
     dispatch_async(queue, ^{
         for (int i=0; i < 10; i++) {
             NSLog(@"任务2 --%@",[NSThread currentThread]);
         }
     });
     
     
     dispatch_async(dispatch_get_main_queue(), ^{
         
         //
         
     });
}

@end
