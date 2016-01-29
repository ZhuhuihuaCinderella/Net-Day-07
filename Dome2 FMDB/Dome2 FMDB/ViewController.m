//
//  ViewController.m
//  Dome2 FMDB
//
//  Created by Qianfeng on 16/1/26.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DataBaseManager *manager = [DataBaseManager shareManager];
    
    StudentModel *model = [[StudentModel alloc]init];
    
    NSInteger randomID = arc4random()%1000+1;
    
    model.s_name = @"heheda";
    model.s_id = randomID;
    model.s_age = 20;
    model.s_score = 90;
    model.s_sex = 1;
    
    //s_id,  s_name,  s_age,  s_score,  s_sex
    
    [manager insertStudent:model];
    [manager updateStudent:model];
    [manager deleteStudent:model];
    [manager selectStudentByID:20];
    [manager selectStudentByAge:20];
    [manager selectStudentByAge:20 andLimit:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
