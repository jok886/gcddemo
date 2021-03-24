//
//  SerialQueue.m
//  gcd
//
//  Created by macliu on 2021/3/22.
//

#import "SerialQueue.h"





@interface SerialQueue ()

//串行队列  ，按顺序执行
@property(strong,nonatomic) dispatch_queue_t tickQueue;

@end

@implementation SerialQueue


- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        self.tickQueue = dispatch_queue_create("tickQueue", DISPATCH_QUEUE_SERIAL);
        
    }
    return self;
}


- (void)saletocket
{
    

    dispatch_sync(self.tickQueue, ^{
        [super saletocket];
    });

    
}
- (void)dealloc
{

}

@end
