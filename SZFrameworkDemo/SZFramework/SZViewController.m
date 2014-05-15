//
//  SZViewController.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-10.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZViewController.h"
#import <JDStatusBarNotification/JDStatusBarNotification.h>

@interface SZViewController ()

@end

@implementation SZViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [[SZPopWindow sharedWindow] show];
    [JDStatusBarNotification showWithStatus:@"show" styleName:@"show"];
    [JDStatusBarNotification dismissAfter:1];
}
- (IBAction)showView:(id)sender {
    [[SZPopView sharedView] show];
    [JDStatusBarNotification showWithStatus:@"status" styleName:@"name"];
    [JDStatusBarNotification dismissAfter:1];
}
@end
