//
//  PhotoTableViewController.m
//  SZFramework
//
//  Created by Sid_Zheng on 14-7-14.
//  Copyright (c) 2014年 3MeoW. All rights reserved.
//

#import "PhotoTableViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>

@interface PhotoTableViewController () <MWPhotoBrowserDelegate>
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSMutableArray *photoModel;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@end

@implementation PhotoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoModel = [NSMutableArray array];
    
    self.photos = [NSMutableArray array];
    
    [self.photos addObject:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"];
    [self.photos addObject:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_q.jpg"];
    [self.photos addObject:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"];
    [self.photos addObject:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_q.jpg"];
    [self.photos addObject:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"];
    [self.photos addObject:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_q.jpg"];
    [self.photos addObject:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_q.jpg"];
    [self.photos addObject:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_q.jpg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
    
    [[cell buttonWithTag:777] setImageWithURL:[NSURL URLWithString:self.photos[indexPath.row]] forState:(UIControlStateNormal)];
    [cell buttonWithTag:777].imageView.contentMode = UIViewContentModeScaleAspectFill;
    [[cell buttonWithTag:777] addTarget:self action:@selector(onCellButtonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

- (void)onCellButtonPressed:(UIButton *)button {
    NSLog(@"%@", NSStringFromCGRect(button.frame));
    UIImageView *imageView = button.imageView;
    
    [self.photoModel removeAllObjects];
    [self.photoModel addObject:[MWPhoto photoWithImage:imageView.image]];
    [self.photoBrowser reloadData];
    
    if (!self.photoBrowser) {
        self.photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    }
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser { return self.photoModel.count; }
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return self.photoModel[index];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
