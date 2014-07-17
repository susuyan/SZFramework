//
//  StretchalbeHeaderTableViewController.h
//  SZFramework
//
//  Created by Sid_Zheng on 14-7-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface StretchalbeHeaderTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet MKMapView *headerView;
@property (strong, nonatomic) SZStretchableTableHeaderView *stretchableTableHeaderView;

@end
