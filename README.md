# gcddemo

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
