//
//  ViewController.m
//  Dome1 FMDB -- sqlite
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
@interface ViewController ()

//声明一个数据库
@property (nonatomic, strong)FMDatabase *dataBase;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //沙盒的library 路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    
    // 数据库路径 （把创建好的数据库放到这个路径里面）
    NSString *dataPath = [path stringByAppendingPathComponent:@"test.sqlite"];
    
    //创建一个数据库 然后再创建表   数据库需要一个存放的路径 所以要先创建一个路径
    //创建数据库的方法  如果数据库存在 就不会创建 反之 如果不存在 就去创建 数据库是一个单例
    _dataBase = [FMDatabase databaseWithPath:dataPath];
    
    
    //要想使用数据库 数据库必需先打开
    if ([_dataBase open]) {
        NSLog(@"数据库打开成功");
    }else {
        NSLog(@"数据库打开失败");
    }
    //打印沙盒路径
    NSLog(@"%@",NSHomeDirectory());
}
#pragma mark - 在数据库中创建一张表
- (IBAction)createTable:(id)sender {
    //创建一张表 如果不存在就去创建 表名是T_Student 表里面有三个字段 学号 姓名 年龄  一般情况下一张表要有一个主键（唯一的标识） 在字段的后面直接加 PRIMARY KEY NOT NULL  并且主键不能为空
    NSString *sql = @"CREATE TABLE IF NOT EXISTS T_Student(s_id TEXT PRIMARY KEY NOT NULL,s_name TEXT,s_age INTERGER)";
    
    //sql语句执行
    //除了查询语句 其他的都要用executeUpdate
    BOOL res = [self.dataBase executeUpdate:sql];
    if (res) {
        NSLog(@"创建表成功");
    }else {
        NSLog(@"创建表失败");
    }
}
//添加一条数据
- (IBAction)insertData:(id)sender {
    
    //插入数据 语句 value 的内容是字符串 用单引号 数字直接用
//    NSString *sql = @"INSERT INTO T_Student(s_id,s_name,s_age) VALUES ('2013031218','cinderella',20)";
    
    //拼接sql语句的方法 这种拼接sql语句的方法有漏洞 sql注入漏洞
    NSInteger randomID = arc4random() % 1000 + 1;//随即一个1000以内的学号 学号不为0
    NSString *randomIDStr = [NSString stringWithFormat:@"%ld",randomID];
    NSString *sql = [NSString stringWithFormat:@" INSERT INTO T_Student(s_id,s_name,s_age) VALUES ('%@','cinderella',20)",randomIDStr];
    
    
    // sql注入漏洞（黑客可以传入指定的字符串 让你的sql语句变为另一种功能 或者做更多的操作）
    //怎么防止
    
    NSString *sql2 = @"INSERT INTO T_Student(s_id,s_name,s_age) VALUES (?,'小白',3)";
    if ([self.dataBase executeUpdate:sql2,randomIDStr]) {
        NSLog(@"防止sql漏洞 注入 的sql语句执行成功");
    }
    
    
    //执行sql语句
//   BOOL ret = [self.dataBase executeUpdate:sql];
//    if (ret) {
//        NSLog(@"插入成功");
//    }else {
//        NSLog(@"插入失败");
//    }
}
- (IBAction)deleteData:(id)sender {
    NSString *sql = @"DELETE FROM T_Student WHERE s_id = '2013031217'";
   BOOL ret = [self.dataBase executeUpdate:sql];
    if (ret) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}
- (IBAction)updateData:(id)sender {
    
    
    
    //修改id 是2013031217 年龄为19
    NSString *sql = @"UPDATE T_Student SET s_age = 19 WHERE s_id = '2013031217'";
    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"修改成功");
    }else {
        NSLog(@"修改失败");
    }
}
//查找
- (IBAction)selectData:(id)sender {
    //查找所有学生
   // NSString *sql = @"SELECT * FROM T_Student";
    
    //查找学号大于500的
   // NSString *sql = @"SELECT * FROM T_Student WHERE s_id > 500";
    
    //获得最后十条数据
    NSString *sql = @"SELECT * FROM T_Student LIMIT 10";
    
    //ORDER BY s_age DESC
    
    
    //查找只能用 executeQuery 这个方法 查找的结果是一个集合  FMResultSet 是用一个指针指向每一条记录
    FMResultSet *resultSet = [self.dataBase executeQuery:sql];
    
    //如果next 有值的话 就去查看
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
































