//
//  DataBaseManager.h
//  Dome2 FMDB
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "StudentModel.h"
//数据库管理类
@class StudentModel;//把student当做一个类 可以防止相互引用

@interface DataBaseManager : NSObject

//获得数据库单例
+(instancetype)shareManager;

//插入数据
-(void)insertStudent:(StudentModel*)stu;
//修改数据
-(void)updateStudent:(StudentModel*)stu;
//删除数据
-(void)deleteStudent:(StudentModel*)stu;
//查询数据
-(StudentModel*)selectStudentByID:(NSInteger)stuID;

//查找 按照年龄
-(NSArray*)selectStudentByAge:(NSInteger)stuAge;

//查找 按照年龄 和 限制条件
-(NSArray*)selectStudentByAge:(NSInteger)stuAge andLimit:(NSInteger)limit;
@end
























