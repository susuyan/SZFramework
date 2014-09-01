//
//  Item4ViewController.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-8-25.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "Item4ViewController.h"

@interface Item4ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation Item4ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    SZLog(@"%@", self);
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger row = indexPath.row;
    if (row == 0) {
        cell.textLabel.text = @"show notification view";
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        [SZNotificationView showInViewController:self tintColor:[UIColor grayColor] font:[UIFont systemFontOfSize:20] textAlignment:(NSTextAlignmentCenter) image:nil message:@"notification without image" duration:2];
    }
}
@end
