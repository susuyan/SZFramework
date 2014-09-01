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
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@end

@implementation SZViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testHalfFont];
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

    [JDStatusBarNotification showWithStatus:@"status" styleName:@"name"];
    [JDStatusBarNotification dismissAfter:1];
}
- (IBAction)button:(id)sender {
    self.blueButton.enabled = NO;
    [self performSelector:@selector(enableBlueButton) withObject:nil afterDelay:1];
}
- (void)enableBlueButton {
    self.blueButton.enabled = YES;
}
- (void)testHalfFont {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"IIIIIIIIII"];
    [attributedString setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.5]} range:NSMakeRange(5, 5)];
    self.label.attributedText = attributedString;
}
@end
