//
//  ViewController.m
//  Dome1 NSLock
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//存的钱
@property (nonatomic) NSInteger num;
//线程锁
@property (nonatomic,strong) NSLock *lock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //假如在银行存了50块钱
    self.num = 50;
    
    //[self test0];
    [self test1];
}


//正常情况下取钱
-(void)test0{
    for (int i = 0; i<50; i++) {
        
        [self fetchMoney];
    }
}
//异步去取钱 也就是开启一个子线程去取钱
-(void)test1{
    //枷锁之后 只能等解锁之后 这个代码块才会被被再执行（同一时间只能执行一次 要想再执行 必须要等到解锁之后才可以）
    _lock = [[NSLock alloc]init];
    for (int i = 0; i<50; i++) {
        ///GCD  创建一个子线程
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            //加锁 然后就可以去取钱了
//            [_lock lock];
//            [self fetchMoney];
//            //去完之后 还要解锁 要不然别人取不了钱
//            [_lock unlock];
            
            
            //线程锁的第二种方式
            @synchronized(self) {
                //加锁的代码块
                [self fetchMoney];
            }
            
        });
    }
}

//在银行取钱的方法 每次取一块钱
-(void)fetchMoney {
    if (_num > 0) {
        //sleep(1);
        //[NSThread sleepForTimeInterval:1];
        self.num -- ;
        NSLog(@"取了一块钱 还剩下%ld块大洋",_num);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end








































