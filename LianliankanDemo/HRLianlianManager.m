//
//  HRLianlianManager.m
//  LianliankanDemo
//
//  Created by heer on 2018/6/28.
//  Copyright © 2018年 heer. All rights reserved.
//

#import "HRLianlianManager.h"
#import <UIKit/UIKit.h>

@interface HRLianlianManager ()
@property (nonatomic,strong) NSArray *lHeArray;
@property (nonatomic,strong) NSArray *lHuArray;
@end

@implementation HRLianlianManager

+ (instancetype)instance {
    static HRLianlianManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HRLianlianManager alloc] init];
    });
    return instance;
}


-(NSMutableDictionary *)dict {
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

-(NSArray *)lHeArray {
    if (!_lHeArray) {
        _lHeArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H", nil];
    }
    return _lHeArray;
}

-(NSArray *)lHuArray {
    if (!_lHuArray) {
        _lHuArray = [NSArray arrayWithObjects:@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P", nil];
    }
    return _lHuArray;
}
-(NSMutableArray *)dataWithDifficultyType:(HRLianLianDifficultyType)difficultyType {
    NSMutableArray *dataArray = [NSMutableArray array];
    switch (difficultyType) {
        case HRLianLianEasy://4*4
        {
            for (NSInteger i=0; i<4; i++) {
                 int x = arc4random() % 8;
                NSString *unit = self.lHeArray[x];
                [dataArray addObject:unit];
            }
            for (NSInteger i=0; i<4; i++) {
                int x = arc4random() % 8;
                NSString *unit = self.lHuArray[x];
                [dataArray addObject:unit];
            }
            [dataArray addObjectsFromArray:[dataArray copy]];
        }
            break;
        case HRLianLianNoraml://6*6
        {
            for (NSInteger i=0; i<9; i++) {
                int x = arc4random() % 8;
                NSString *unit = self.lHeArray[x];
                [dataArray addObject:unit];
            }
            for (NSInteger i=0; i<9; i++) {
                int x = arc4random() % 8;
                NSString *unit = self.lHuArray[x];
                [dataArray addObject:unit];
            }
            [dataArray addObjectsFromArray:[dataArray copy]];
        }
            break;
        case HRLianLianDifficulty://8*8
        {
            for (NSInteger i=0; i<16; i++) {
                int x = arc4random() % 8;
                NSString *unit = self.lHeArray[x];
                [dataArray addObject:unit];
            }
            for (NSInteger i=0; i<16; i++) {
                int x = arc4random() % 8;
                NSString *unit = self.lHuArray[x];
                [dataArray addObject:unit];
            }
            [dataArray addObjectsFromArray:[dataArray copy]];
        }
            break;
        default:
            break;
    }
    return dataArray;
}
#pragma mark - 计算轨迹
-(BOOL)lianLianEliminationCheckWith:(CGPoint)pointA point:(CGPoint)pointB difficultyType:(HRLianLianDifficultyType)difficultyType{
    /** 1.直连型 */
    if ([self verticalWith:pointA point:pointB]) {//是否存在直线,存在返回yes
        //连接成功
        return YES;
    }
    /** 2.一折型 */
    if([self oneCorner:pointA button:pointB]){
        return YES;
    }else{
        switch (difficultyType) {
            case HRLianLianEasy:
                /** 3.两折型 */
                return [self twoCorner:pointA button:pointB maxRow:4 maxCol:4];
                break;
            case HRLianLianNoraml:
                /** 3.两折型 */
                return [self twoCorner:pointA button:pointB maxRow:6 maxCol:6];
                break;
            case HRLianLianDifficulty:
                /** 3.两折型 */
                return [self twoCorner:pointA button:pointB maxRow:8 maxCol:8];
                break;
            default:
                return NO;
                break;
        }
    }
}
/** 1.直连型 */
- (BOOL)verticalWith:(CGPoint)pointA point:(CGPoint)pointB {
    
    int rowA = [[NSString stringWithFormat:@"%f",pointA.x] intValue];
    int colA = [[NSString stringWithFormat:@"%f",pointA.y] intValue];
    
    int rowB = [[NSString stringWithFormat:@"%f",pointB.x] intValue];
    int colB = [[NSString stringWithFormat:@"%f",pointB.y] intValue];
    
    //1.直连型
    if (rowA == rowB){//同一行
        int minCol = colA < colB ? colA : colB;//最小列号
        int maxCol = colA > colB ? colA : colB;//最大列号
        
        for (int j = minCol+1; j<maxCol; j++) {
            CGPoint point = CGPointMake(rowA, j);
            NSString *key = NSStringFromCGPoint(point);
            if ([self.dict[key] intValue] != 0) {//两个图案之间存在其他的图案
                return NO;
            }
        }
        return YES;
        
    }else if(colA == colB){//同一列
        int minRow = rowA < rowB ? rowA : rowB;//最小行号
        int maxRow = rowA > rowB ? rowA : rowB;//最大行号
        for (int i = minRow+1; i<maxRow; i++) {
            CGPoint point = CGPointMake(i, colA);
            NSString *key = NSStringFromCGPoint(point);
            if ([self.dict[key] intValue] != 0) {//两个图案之间存在其他的图案
                return NO;
            }
        }
        return YES;
    } else{
        return NO;
    }
}

/** 2.一折型 */
- (BOOL)oneCorner:(CGPoint)pointA button:(CGPoint)pointB{
    
    //找出拐角点的坐标
    CGPoint pointC = CGPointMake(pointA.x, pointB.y);
    
    CGPoint pointD = CGPointMake(pointB.x, pointA.y);
    
    //判断C点是否有元素
    if ([self.dict[NSStringFromCGPoint(pointC)] intValue] == 0) {
        
        return [self verticalWith:pointA point:pointC] && [self verticalWith:pointC point:pointB];
    }
    //判断D点是否有元素
    if ([self.dict[NSStringFromCGPoint(pointD)] intValue] == 0) {
        
        return [self verticalWith:pointA point:pointD] && [self verticalWith:pointD point:pointB];
    }
    
    //其他情况
    return NO;
}
/** 3.两折型 */
/* 判断A和B是否两折连通
 * (1) 水平方向: 从A水平方向左右扫描,并判断经过的点能否与B通过1折连通;
 * (2) 垂直方向: 从A垂直方向上下扫描,并判断经过的点能否与B通过1折连通;
 */
- (BOOL)twoCorner:(CGPoint)pointA button:(CGPoint)pointB maxRow:(int)maxRow maxCol:(int)maxCol{
    //得到A点的所在行列
    int rowA = [[NSString stringWithFormat:@"%f",pointA.x] intValue];
    int colA = [[NSString stringWithFormat:@"%f",pointA.y] intValue];
    
    //初始化C点
    CGPoint pointC = CGPointMake(0, 0);
    
    // 1. 水平方向(列)
    // 1.1 左
//    if (colA != 0){//A点不在最左边
        for (int i = colA - 1; i >= -1; i--) {
            pointC = CGPointMake(rowA, i);
            //判断C点是否为空
            if ([self.dict[NSStringFromCGPoint(pointC)] intValue] == 0) {
                if ([self oneCorner:pointC button:pointB]){
                    return YES;
                }
            }else{//不为空的话,直接跳出
                break;
            }
        }
//    }
    
    // 1.2 右
//    if (colA != maxCol - 1){//A点不在最右边
        for (int i = colA + 1; i <= maxCol; i++) {
            pointC = CGPointMake(rowA, i);
            //判断C点是否为空
            if ([self.dict[NSStringFromCGPoint(pointC)] intValue] == 0) {
                if ([self oneCorner:pointC button:pointB]){
                    return YES;
                }
            }else{//不为空的话,直接跳出
                break;
            }
        }
//    }
    
    // 2. 垂直方向(行)
    // 2.1 上
//    if (rowA != 0){//A点不在最上边
        for (int i = rowA - 1; i >= -1; i--) {
            pointC = CGPointMake(i, colA);
            //判断C点是否为空
            if ([self.dict[NSStringFromCGPoint(pointC)] intValue] == 0) {
                if ([self oneCorner:pointC button:pointB]){
                    return YES;
                }
            }else{//不为空的话,直接跳出
                break;
            }
        }
//    }
    
    // 2.2 下
//    if (rowA != maxRow - 1){//A点不在最下边
        for (int i = rowA + 1; i <= maxRow; i++) {
            pointC = CGPointMake(i, colA);
            //判断C点是否为空
            if ([self.dict[NSStringFromCGPoint(pointC)] intValue] == 0) {
                if ([self oneCorner:pointC button:pointB]){
                    return YES;
                }
            }else{//不为空的话,直接跳出
                break;
            }
        }
//    }
    
    //其他情况
    return NO;
}
@end
