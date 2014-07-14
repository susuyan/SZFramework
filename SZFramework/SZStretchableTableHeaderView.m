//
//  SZStretchableTableHeaderView.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-7-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "SZStretchableTableHeaderView.h"

@interface SZStretchableTableHeaderView () {
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}
@end

@implementation SZStretchableTableHeaderView
- (void)stretchHeaderViewForTableView:(UITableView *)tableView withHeaderView:(UIView *)headerView {
    self.tableView = tableView;
    self.headerView = headerView;
    
    initialFrame = self.headerView.frame;
    defaultViewHeight = initialFrame.size.height;
    
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    self.tableView.tableHeaderView = emptyTableHeaderView;
    
    [self.tableView addSubview:self.headerView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.headerView.frame;
    frame.size.width = self.tableView.frame.size.width;
    self.headerView.frame = frame;
    
    if (scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        self.headerView.y = scrollView.contentOffset.y;
        initialFrame.origin.y = offsetY * -1;
        initialFrame.size.height = defaultViewHeight + offsetY;
        self.headerView.frame = initialFrame;
    }
}
- (void)resizeHeaderView {
    initialFrame.size.width = self.tableView.frame.size.width;
    self.headerView.frame = initialFrame;
}
@end

