//
//  MasterViewController.h
//  TechTalk
//
//  Created by  on 1/18/12.
//  Copyright (c) 2012 Mark Rickert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
