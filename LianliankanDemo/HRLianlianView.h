//
//  HRLianlianView.h
//  LianliankanDemo
//
//  Created by heer on 2018/6/28.
//  Copyright © 2018年 heer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRLianlianManager.h"

@interface HRLianlianView : UIView

-(instancetype)initWithFrame:(CGRect)frame andDifficultyType:(HRLianLianDifficultyType)difficultyType;

-(void)createUnitWithData:(NSMutableArray *)dataArray;
@end
