//
//  HRLianlianView.m
//  LianliankanDemo
//
//  Created by heer on 2018/6/28.
//  Copyright © 2018年 heer. All rights reserved.
//

#import "HRLianlianView.h"
#import "HRUnitButton.h"
#import "HRLianlianManager.h"

@interface HRLianlianView()
@property (nonatomic) HRLianLianDifficultyType type;

@property (nonatomic,strong) HRUnitButton *selectButton;
@end
@implementation HRLianlianView
{
    NSInteger lineCount;
    CGFloat unitWidth;
}
-(void)createUnitWithData:(NSMutableArray *)dataArray {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[HRLianlianManager instance].dict removeAllObjects];
    NSInteger count = dataArray.count;
    for (NSInteger i=0; i<count; i++) {
        NSInteger index = arc4random() % dataArray.count;
        NSString *message = dataArray[index];
        [self addunitButtonWithMessage:message number:i];
        [dataArray removeObjectAtIndex:index];
    }
}
-(void)addunitButtonWithMessage:(NSString *)message number:(NSInteger)i  {
    HRUnitButton *button = [[HRUnitButton alloc]init];
    NSInteger xPlace = i%lineCount;
    NSInteger yPlace = i/lineCount;
    [button setFrame:CGRectMake(xPlace*unitWidth, yPlace*unitWidth, unitWidth, unitWidth)];
    [button setTitle:message forState:UIControlStateNormal];
    button.unit_name = message;
    CGPoint point = CGPointMake(yPlace, xPlace);
    button.belongsPoint = point;
    NSString *key = NSStringFromCGPoint(point);
    [[HRLianlianManager instance].dict setObject:@"1" forKey:key];
    button.layer.cornerRadius = 5.0;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,1,1,1});
    button.layer.borderColor = color;//设置边框颜色
    CGColorSpaceRelease(colorSpaceRef);
    CGColorRelease(color);
    button.layer.borderWidth = 1.0f;//设置边框颜色
    CGFloat colorR = (arc4random()%255)/255.0;
    CGFloat colorG = (arc4random()%255)/255.0;
    CGFloat colorB = (arc4random()%255)/255.0;
    [button setBackgroundColor:[UIColor colorWithRed:colorR green:colorG blue:colorB alpha:1]];
    [button addTarget:self action:@selector(lianlianCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

-(instancetype)initWithFrame:(CGRect)frame andDifficultyType:(HRLianLianDifficultyType) difficultyType {
    if (self = [super initWithFrame:frame]) {
        self.type = difficultyType;
        [self setDefaultData:difficultyType];
    }
    return self;
}

-(void)setDefaultData:(HRLianLianDifficultyType) difficultyType{

    switch (difficultyType) {
        case HRLianLianEasy:
        {
            lineCount = 4;
            unitWidth = self.frame.size.width/4;
        }
            break;
        case HRLianLianNoraml:
        {
            lineCount = 6;
            unitWidth = self.frame.size.width/6;
        }
            break;
        case HRLianLianDifficulty:
        {
            lineCount = 8;
            unitWidth = self.frame.size.width/8;
        }
            break;
        default:
            break;
    }

}
-(void)lianlianCheck:(HRUnitButton *)button {
    if (!self.selectButton) {
        self.selectButton = button;
        button.selected = YES;
        button.enabled = NO;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){93/255.0,156/2255.0,236/255.0,1});
        button.layer.borderColor = color;//设置边框颜色
        CGColorSpaceRelease(colorSpaceRef);
        CGColorRelease(color);
    } else {
        if ([button.unit_name isEqualToString:self.selectButton.unit_name]) {
            NSString *key = NSStringFromCGPoint(self.selectButton.belongsPoint);
            NSString *secKey = NSStringFromCGPoint(button.belongsPoint);
            if ([[HRLianlianManager instance]lianLianEliminationCheckWith:self.selectButton.belongsPoint point:button.belongsPoint difficultyType:self.type]) {
                [[[HRLianlianManager instance]dict]setObject:@"0" forKey:key];
                [[[HRLianlianManager instance]dict]setObject:@"0" forKey:secKey];
                
                [UIView animateWithDuration:0.5 animations:^{
                    CGPoint center1 = self.selectButton.center;
                    CGPoint center2 = button.center;
                    [self.selectButton setFrame:CGRectMake(center1.x, center1.y, 0, 0)];
                    [button setFrame:CGRectMake(center2.x, center2.y, 0, 0)];
                } completion:^(BOOL finished) {
                    [self.selectButton removeFromSuperview];
                    [button removeFromSuperview];
                }];
        
                self.selectButton = nil;
            } else {
                self.selectButton.selected = NO;
                self.selectButton.enabled = YES;
                CGColorSpaceRef colorSpaceRef0 = CGColorSpaceCreateDeviceRGB();
                CGColorRef color0 = CGColorCreate(colorSpaceRef0, (CGFloat[]){1,1,1,1});
                self.selectButton.layer.borderColor = color0;//设置边框颜色
                CGColorSpaceRelease(colorSpaceRef0);
                CGColorRelease(color0);
                
                self.selectButton = button;
                button.selected = YES;
                button.enabled = NO;
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
                CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){93/255.0,156/2255.0,236/255.0,1});
                button.layer.borderColor = color;//设置边框颜色
                CGColorSpaceRelease(colorSpaceRef);
                CGColorRelease(color);
            }
        }else {
            self.selectButton.selected = NO;
            self.selectButton.enabled = YES;
            CGColorSpaceRef colorSpaceRef0 = CGColorSpaceCreateDeviceRGB();
            CGColorRef color0 = CGColorCreate(colorSpaceRef0, (CGFloat[]){1,1,1,1});
            self.selectButton.layer.borderColor = color0;//设置边框颜色
            CGColorSpaceRelease(colorSpaceRef0);
            CGColorRelease(color0);
            
            self.selectButton = button;
            button.selected = YES;
            button.enabled = NO;
            CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
            CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){93/255.0,156/2255.0,236/255.0,1});
            button.layer.borderColor = color;//设置边框颜色
            CGColorSpaceRelease(colorSpaceRef);
            CGColorRelease(color);
        }
    }
}
@end
