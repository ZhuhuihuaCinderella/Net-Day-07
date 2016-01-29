//
//  ViewController.m
//  rewriteDome
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
@interface ViewController ()
@property (nonatomic,strong) FMDatabase *dataBase;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [library stringByAppendingPathComponent:@"mySqlite.sqlite"];
    _dataBase = [[FMDatabase alloc]initWithPath:path];
    if ([_dataBase open]) {
        NSLog(@"打开成功");
    }else {
        NSLog(@"打开失败");
    }
    NSLog(@"%@",NSHomeDirectory());
}

- (IBAction)create:(id)sender {
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS T_Student(s_id TEXT PRIMARY KEY NOT NULL,s_name TEXT,s_age INTERGER)";
    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"创建成功");
    }else {
        NSLog(@"创建失败");
    }
}
- (IBAction)insert:(id)sender {
    
    NSInteger randomID = arc4random() %100+1;
    NSString *randomIDStr = [NSString stringWithFormat:@"%ld",randomID];
    
//   NSString *sql = @"INSERT INTO T_Student(s_id,s_name,s_age) VALUES (?,'aaa',3)";
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO T_Student(s_id,s_name,s_age) VALUES (?,'aaa',3)"];
    if ([self.dataBase executeUpdate:sql,randomIDStr]) {
        NSLog(@"添加成功");
    }else {
        NSLog(@"添加失败");
    }
}
- (IBAction)delete:(id)sender {
    NSString *sql = @"DELETE FROM T_Student WHERE (s_id ='123')";
    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}

- (IBAction)update:(id)sender {
    NSString *sql = @"UPDATE T_Student SET s_age = 0 WHERE s_id = '123'";
    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"修改成功");
    }else {
        NSLog(@"修改失败");
    }
}
- (IBAction)select:(id)sender {
    //NSString *sql = @"SELECT * FROM T_Student";
    NSString *sql1 = @"SELECT * FROM T_Student LIMIT 10";
    FMResultSet *resultSet = [self.dataBase executeQuery:sql1];
    while ([resultSet next]) {
        NSString *sid = [resultSet stringForColumn:@"s_id"];
        NSString *name = [resultSet stringForColumn:@"s_name"];
        NSInteger age = [resultSet intForColumn:@"s_age"];
        NSLog(@"%@ %@ %ld",sid,name,age);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
































