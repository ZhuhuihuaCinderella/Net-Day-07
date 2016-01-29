//
//  StudentModel.h
//  Dome2 FMDB
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 @"CREATE TABLE IF NOT EXISTS T_Student(s_id INTERGER PRIMARY KEY NOT NULL,s_age INTERGER,s_name TEXT,s_sex INTERGER,s_score INTERGER)";
 */
@interface StudentModel : NSObject
@property (nonatomic)NSInteger s_id;
@property (nonatomic)NSInteger s_age;
@property (nonatomic,copy) NSString *s_name;
@property (nonatomic)NSInteger s_sex;
@property (nonatomic)NSInteger s_score;
@end
