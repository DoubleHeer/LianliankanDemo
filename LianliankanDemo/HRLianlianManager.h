//
//  HRLianlianManager.h
//  LianliankanDemo
//
//  Created by heer on 2018/6/28.
//  Copyright © 2018年 heer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HRLianLianDifficultyType) {
    HRLianLianEasy,
    HRLianLianNoraml,
    HRLianLianDifficulty
};
@interface HRLianlianManager : NSObject

/*单例*/
+ (instancetype)instance;

@property (nonatomic,strong) NSMutableDictionary *dict;

-(NSMutableArray *)dataWithDifficultyType:(HRLianLianDifficultyType)difficultyType;

-(BOOL)lianLianEliminationCheckWith:(CGPoint)pointA point:(CGPoint)pointB difficultyType:(HRLianLianDifficultyType)difficultyType;
@end
