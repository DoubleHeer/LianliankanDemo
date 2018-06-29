//
//  ViewController.m
//  LianliankanDemo
//
//  Created by heer on 2018/6/28.
//  Copyright © 2018年 heer. All rights reserved.
//

#import "ViewController.h"
#import "HRLianlianManager.h"
#import "HRLianlianView.h"

@interface ViewController ()
@property (nonatomic,strong) HRLianlianView *lianlianView;
@end

@implementation ViewController

-(HRLianlianView *)lianlianView {
    if (!_lianlianView) {
        _lianlianView = [[HRLianlianView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width) andDifficultyType:HRLianLianDifficulty];
        [_lianlianView setBackgroundColor:[UIColor whiteColor]];
    }
    return _lianlianView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.lianlianView];
    
    HRLianlianManager *manager = [HRLianlianManager instance];
    NSMutableArray *array1 = [manager dataWithDifficultyType:HRLianLianEasy];
    NSLog(@"%@",array1);
    NSMutableArray *array2 = [manager dataWithDifficultyType:HRLianLianNoraml];
    NSLog(@"%@",array2);
    NSMutableArray *array3 = [manager dataWithDifficultyType:HRLianLianDifficulty];
    NSLog(@"%@",array3);
    [self.lianlianView createUnitWithData:array3];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
