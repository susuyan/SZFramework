//
//  SZStretchableTableHeaderView.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-7-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZStretchableTableHeaderView : NSObject
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
- (void)stretchHeaderViewForTableView:(UITableView *)tableView withHeaderView:(UIView *)headerView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)resizeHeaderView;
@end
