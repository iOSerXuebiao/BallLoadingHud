//
//  ViewController.m
//  BallLoadingHud
//
//  Created by 薛彪 on 16/6/6.
//  Copyright © 2016年 xuebiao. All rights reserved.
//

#import "ViewController.h"
#import "BallLoadingHudView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BallLoadingHudView * ballLoadingHudView = [[BallLoadingHudView alloc] initWithFrame:CGRectMake(0, 0, 120,120)];
    ballLoadingHudView.center = self.view.center;
    [self.view addSubview:ballLoadingHudView];
    [ballLoadingHudView showHub];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
