//
//  BallLoadingHudView.h
//  BallLoadingHud
//
//  Created by 薛彪 on 16/6/6.
//  Copyright © 2016年 xuebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallLoadingHudView : UIView

/** 球的颜色 */
@property (nonatomic,strong) UIColor *ballColor;

/**
 *展示加载动画
 */
- (void)showHub;

/**
 *  关闭加载动画
 */
- (void)dismissHub;

@end
