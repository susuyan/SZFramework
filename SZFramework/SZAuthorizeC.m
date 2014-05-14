//
//  SZAuthorizeC.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-5-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZAuthorizeC.h"

@interface SZAuthorizeC ()

@end

@implementation SZAuthorizeC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleBordered) target:self action:@selector(dismissSelf)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dismissSelf {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
