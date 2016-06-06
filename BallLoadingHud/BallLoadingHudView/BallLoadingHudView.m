//
//  BallLoadingHudView.m
//  BallLoadingHud
//
//  Created by 薛彪 on 16/6/6.
//  Copyright © 2016年 xuebiao. All rights reserved.
//

#import "BallLoadingHudView.h"
#define ORIGIN_X    self.frame.origin.x
#define ORIGIN_Y    self.frame.origin.y
#define WIDTH       self.frame.size.width
#define HEIGHT      self.frame.size.height
#define RandomColor [UIColor colorWithRed:arc4random_uniform(245)/255.0 green:arc4random_uniform(245)/255.0 blue:arc4random_uniform(245)/255.0 alpha:0.85]
#define BALL_RADIUS  14

@interface BallLoadingHudView ()

/**第1个球 */
@property (nonatomic, strong) UIView *ball_1;
/**第2个球 */
@property (nonatomic, strong) UIView *ball_2;
/**第3个球 */
@property (nonatomic, strong) UIView *ball_3;

@property (nonatomic, strong) UIView *ball_4;
@property (nonatomic, strong) UIView *ball_5;


@end

@implementation BallLoadingHudView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * loadingBg = [[UIImageView alloc] initWithFrame:self.frame];
        loadingBg.image = [UIImage imageNamed:@"loding_bg"];
        [self addSubview:loadingBg];
        UIVisualEffectView *bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        bgView.alpha = 0.85f;
        bgView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        bgView.layer.cornerRadius = BALL_RADIUS;
        bgView.clipsToBounds = YES;
        [loadingBg addSubview:bgView];
    }
    return self;
}

- (UIColor *)ballColor{
    if (_ballColor) {
        return _ballColor;
    }
    return RandomColor;
}

- (void)showHub{
    CGFloat ballW = WIDTH / 2 - BALL_RADIUS * 0.5;
    CGFloat ballH = HEIGHT / 2 - BALL_RADIUS * 0.5;
    UIView *ball_1 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2 - BALL_RADIUS * 1.5, ballH, BALL_RADIUS, BALL_RADIUS)];
    ball_1.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_1.backgroundColor = self.ballColor;
    [self addSubview:ball_1];
    self.ball_1 = ball_1;
    
    UIView *ball_2 = [[UIView alloc] initWithFrame:CGRectMake(ballW,ballH, BALL_RADIUS, BALL_RADIUS)];
    ball_2.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45f];
    [self addSubview:ball_2];
    self.ball_2 = ball_2;
    
    UIView *ball_3 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2 + BALL_RADIUS * 0.5, ballH, BALL_RADIUS, BALL_RADIUS)];
    ball_3.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_3.backgroundColor = self.ballColor;
    [self addSubview:ball_3];
    self.ball_3 = ball_3;
    
    UIView *ball_4 = [[UIView alloc] initWithFrame:CGRectMake(ballW,HEIGHT / 2 - BALL_RADIUS * 1.5, BALL_RADIUS, BALL_RADIUS)];
    ball_4.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_4.backgroundColor = self.ballColor;
    [self addSubview:ball_4];
    self.ball_4 = ball_4;

    UIView *ball_5 = [[UIView alloc] initWithFrame:CGRectMake(ballW,HEIGHT / 2 + BALL_RADIUS * 0.5, BALL_RADIUS, BALL_RADIUS)];
    ball_5.layer.cornerRadius = BALL_RADIUS / 2; // 成为圆形
    ball_5.backgroundColor = self.ballColor;
    [self addSubview:ball_5];
    self.ball_5 = ball_5;

    
    [self rotationAnimation];
}

- (void)rotationAnimation{
    // 1.1 取得围绕中心轴的点
    CGPoint centerPoint = CGPointMake(WIDTH / 2 , HEIGHT / 2);
    // 1.2 获得第一个圆的中点
    CGPoint centerBall_1 = CGPointMake(WIDTH/2 - BALL_RADIUS, HEIGHT/2);
    // 1.3 获得第三个圆的中点
    CGPoint centerBall_2 = CGPointMake(WIDTH/2 + BALL_RADIUS, HEIGHT / 2);
    // 1.4 获得第四个圆的中点
    CGPoint centerBall_4 = CGPointMake(WIDTH/2, HEIGHT/2-BALL_RADIUS);
    // 1.5 获得第五个圆的中点
    CGPoint centerBall_5 = CGPointMake(WIDTH/2, HEIGHT/2+BALL_RADIUS);

    // 2.1 第一个圆的曲线
    UIBezierPath *path_ball_1 = [UIBezierPath bezierPath];
    [path_ball_1 moveToPoint:centerBall_1];
    
    [path_ball_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    UIBezierPath *path_ball_1_1 = [UIBezierPath bezierPath];
    [path_ball_1_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO];
    [path_ball_1 appendPath:path_ball_1_1];
    
    // 2.2 第一个圆的动画
    CAKeyframeAnimation *animation_ball_1=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_1.path = path_ball_1.CGPath;
    animation_ball_1.removedOnCompletion = NO;
    animation_ball_1.fillMode = kCAFillModeForwards;
    animation_ball_1.calculationMode = kCAAnimationCubic;
    animation_ball_1.repeatCount = 1;
    animation_ball_1.duration = 1.4;
    animation_ball_1.delegate = self;
    animation_ball_1.autoreverses = NO;
    animation_ball_1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.ball_1.layer addAnimation:animation_ball_1 forKey:@"animation"];
    
    // 2.3 第三个圆的曲线
    UIBezierPath *path_ball_3 = [UIBezierPath bezierPath];
    [path_ball_3 moveToPoint:centerBall_2];
    
    [path_ball_3 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO];
    UIBezierPath *path_ball_3_1 = [UIBezierPath bezierPath];
    [path_ball_3_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI endAngle:M_PI*2 clockwise:NO];
    [path_ball_3 appendPath:path_ball_3_1];
    
    // 2.4 第三个圆的动画
    CAKeyframeAnimation *animation_ball_3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_3.path = path_ball_3.CGPath;
    animation_ball_3.removedOnCompletion = NO;
    animation_ball_3.fillMode = kCAFillModeForwards;
    animation_ball_3.calculationMode = kCAAnimationCubic;
    animation_ball_3.repeatCount = 1;
    animation_ball_3.duration = 1.4;
    //    animation_ball_3.delegate = self;
    animation_ball_3.autoreverses = NO;
    animation_ball_3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.ball_3.layer addAnimation:animation_ball_3 forKey:@"rotation"];
    
    // 2.4 第四个圆的曲线
    UIBezierPath *path_ball_4 = [UIBezierPath bezierPath];
    [path_ball_4 moveToPoint:centerBall_4];
    
    [path_ball_4 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI_2 endAngle:M_PI+M_PI_2 clockwise:NO];
    UIBezierPath *path_ball_4_1 = [UIBezierPath bezierPath];
    [path_ball_4_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI+M_PI_2 endAngle:M_PI_2 clockwise:NO];
    [path_ball_4 appendPath:path_ball_4_1];
    
    // 2.5 第四个圆的动画
    CAKeyframeAnimation *animation_ball_4=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_4.path = path_ball_4.CGPath;
    animation_ball_4.removedOnCompletion = NO;
    animation_ball_4.fillMode = kCAFillModeForwards;
    animation_ball_4.calculationMode = kCAAnimationCubic;
    animation_ball_4.repeatCount = 1;
    animation_ball_4.duration = 1.4;
    //animation_ball_4.delegate = self;
    animation_ball_4.autoreverses = NO;
    animation_ball_4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.ball_4.layer addAnimation:animation_ball_4 forKey:@"animation"];
    
    // 2.5 第五个圆的曲线
    UIBezierPath *path_ball_5 = [UIBezierPath bezierPath];
    [path_ball_5 moveToPoint:centerBall_5];
    
    [path_ball_5 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI+M_PI_2 endAngle:M_PI_2 clockwise:NO];
    UIBezierPath *path_ball_5_1 = [UIBezierPath bezierPath];
    [path_ball_5_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI_2 endAngle:M_PI+M_PI_2 clockwise:NO];
    [path_ball_5 appendPath:path_ball_5_1];
    
    // 2.6 第五个圆的动画
    CAKeyframeAnimation *animation_ball_5=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_5.path = path_ball_5.CGPath;
    animation_ball_5.removedOnCompletion = NO;
    animation_ball_5.fillMode = kCAFillModeForwards;
    animation_ball_5.calculationMode = kCAAnimationCubic;
    animation_ball_5.repeatCount = 1;
    animation_ball_5.duration = 1.4;
    //animation_ball_5.delegate = self;
    animation_ball_5.autoreverses = NO;
    animation_ball_5.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.ball_5.layer addAnimation:animation_ball_5 forKey:@"animation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self rotationAnimation];
}

- (void)animationDidStart:(CAAnimation *)anim{
    [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.ball_1.transform = CGAffineTransformMakeTranslation(-BALL_RADIUS, 0);
        self.ball_1.transform = CGAffineTransformScale(self.ball_1.transform, 0.7, 0.7);
        
        self.ball_3.transform = CGAffineTransformMakeTranslation(BALL_RADIUS, 0);
        self.ball_3.transform = CGAffineTransformScale(self.ball_3.transform, 0.7, 0.7);
        
        self.ball_4.transform = CGAffineTransformMakeTranslation(0,BALL_RADIUS);
        self.ball_4.transform = CGAffineTransformScale(self.ball_4.transform, 0.7, 0.7);
        
        self.ball_5.transform = CGAffineTransformMakeTranslation(0,-BALL_RADIUS);
        self.ball_5.transform = CGAffineTransformScale(self.ball_5.transform, 0.7, 0.7);
        self.ball_2.transform = CGAffineTransformScale(self.ball_2.transform, 0.7, 0.7);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f delay:0.1f options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.ball_1.transform = CGAffineTransformIdentity;
            self.ball_3.transform = CGAffineTransformIdentity;
            self.ball_4.transform = CGAffineTransformIdentity;
            self.ball_5.transform = CGAffineTransformIdentity;
            self.ball_2.transform = CGAffineTransformIdentity;
        } completion:NULL];
    }];
}

- (void)dismissHub{
    
}

@end
