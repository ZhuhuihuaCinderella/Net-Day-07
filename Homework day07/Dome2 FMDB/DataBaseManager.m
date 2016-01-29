//
//  DataBaseManager.m
//  Dome2 FMDB
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "DataBaseManager.h"


@interface DataBaseManager ()
//数据库
@property (nonatomic, strong)FMDatabase *dataBase;
//数据库地址
@property (nonatomic, copy) NSString *dataPath;

@end

@implementation DataBaseManager

+(instancetype)shareManager {
    /*
     //非线程安全的
    static DataBaseManager *manager = nil;
    if (manager) {
        manager = [[DataBaseManager alloc]init];
    }
    return manager;
     */
    
    
    //线程安全的单例
    static DataBaseManager *manager = nil;
    
    //dispatch_once_t 只执行一次
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        NSLog(@"只会执行一次");
        manager = [[DataBaseManager alloc]init];
    });
    return manager;
    
}

//重写init方法
-(instancetype)init {
    if (self == [super init]) {
        //初始化数据库
        //dataPath
        NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
        _dataPath = [library stringByAppendingPathComponent:@"my.sqlite"];
        _dataBase = [FMDatabase databaseWithPath:_dataPath];
        //如果数据库打开 就去创建
        if ([_dataBase open]) {
            NSString *sql = @"CREATE TABLE IF NOT EXISTS T_Student(s_id INTERGER PRIMARY KEY NOT NULL,s_age INTERGER,s_name TEXT,s_sex INTERGER,s_score INTERGER)";
            
            if ([_dataBase executeUpdate:sql]) {
                NSLog(@"succeed");
            }else {
                NSLog(@"Faild");
            }
        }
    }
    return self;
}

//获得数据库单例
//+(instancetype)shareManager;

//插入数据
-(void)insertStudent:(StudentModel*)stu {

    NSString *sql = [NSString stringWithFormat:@"INSERT INTO T_Student(s_id,s_age,s_name,s_sex,s_score) VALUES (%ld,%ld,'%@',%ld,%ld)",stu.s_id,stu.s_age,stu.s_name,stu.s_sex,stu.s_score];
   

    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"插入成功");
    }else {
        NSLog(@"插入失败");
    }
}
//修改数据
-(void)updateStudent:(StudentModel*)stu {
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE T_Student SET s_name = 'woshidameinv' WHERE s_id = %ld",stu.s_id];
    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"修改成功");
    }else {
        NSLog(@"修改失败");
    }
    
    
    //NSString *sql = @"UPDATE T_Student SET s_name = 'woshidameinv' WHERE s_id = 123456";
    
}
//删除数据
-(void)deleteStudent:(StudentModel*)stu{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM T_Student WHERE(s_id = %ld)",stu.s_id];
    //NSString *sql = @"DELETE FROM T_Student WHERE(s_id = 123456)";
    if ([self.dataBase executeUpdate:sql]) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}
//查询数据
-(StudentModel*)selectStudentByID:(NSInteger)stuID {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM T_Student WHERE s_id = %ld",stuID];

    FMResultSet *result = [self.dataBase executeQuery:sql];
    StudentModel *model = [StudentModel new];
    
    while ([result next]) {
        model.s_id  = [result intForColumn:@"s_id"];
        model.s_sex= [result intForColumn:@"s_sex"];
        model.s_score  = [result intForColumn:@"s_score"];
        model.s_age = [result intForColumn:@"s_age"];
        model.s_name = [result stringForColumn:@"s_name"];
        //NSLog(@"%ld %ld %@ %ld %ld",sid,sex,name,score,age);
    }
    NSLog(@"%ld %@ %ld %ld %ld",model.s_id,model.s_name,model.s_age,model.s_score,model.s_sex);
    return model;
   
}

//查找 按照年龄
-(NSArray*)selectStudentByAge:(NSInteger)stuAge {
    StudentModel *model = [StudentModel new];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM T_Student WHERE s_age = %ld",stuAge];
    
    FMResultSet *resultSet = [self.dataBase executeQuery:sql];
    while ([resultSet next]) {
        model.s_id  = [resultSet intForColumn:@"s_id"];
        model.s_sex= [resultSet intForColumn:@"s_sex"];
        model.s_score  = [resultSet intForColumn:@"s_score"];
        model.s_age = [resultSet intForColumn:@"s_age"];
        model.s_name = [resultSet stringForColumn:@"s_name"];
        [array addObject:model];
    }
    NSLog(@"%ld %@ %ld %ld %ld",model.s_id,model.s_name,model.s_age,model.s_score,model.s_sex);
    return array;
}

//查找 按照年龄 和 限制条件
-(NSArray*)selectStudentByAge:(NSInteger)stuAge andLimit:(NSInteger)limit {
    StudentModel *model = [StudentModel new];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM T_Student WHERE s_age = %ld LIMIT %ld",stuAge,limit];
    
    FMResultSet *resultSet = [self.dataBase executeQuery:sql];
    while ([resultSet next]) {
        model.s_id  = [resultSet intForColumn:@"s_id"];
        model.s_sex= [resultSet intForColumn:@"s_sex"];
        model.s_score  = [resultSet intForColumn:@"s_score"];
        model.s_age = [resultSet intForColumn:@"s_age"];
        model.s_name = [resultSet stringForColumn:@"s_name"];
        [array addObject:model];
    }
    NSLog(@"%ld %@ %ld %ld %ld",model.s_id,model.s_name,model.s_age,model.s_score,model.s_sex);
    return array;
    
}

@end






















