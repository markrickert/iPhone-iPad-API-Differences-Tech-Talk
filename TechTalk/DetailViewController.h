//
//  DetailViewController.h
//  TechTalk
//
//  Created by  on 1/18/12.
//  Copyright (c) 2012 Mark Rickert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UIView *homeView;
@property (strong, nonatomic) IBOutlet UIView *modalWindows;
@property (strong, nonatomic) IBOutlet UIView *popoverControllers;
@property (strong, nonatomic) IBOutlet UIView *actionSheets;

@property (strong, nonatomic) UIPopoverController *popover;


//Modals
-(IBAction)regularModal:(id)sender;
-(IBAction)formSheetModal:(id)sender;
-(IBAction)pageSheetModal:(id)sender;
-(IBAction)customSizeModal:(id)sender;

//Popovers
-(IBAction)regularPopover:(UIButton *)sender;
-(IBAction)pinnedPopover:(UIBarButtonItem *)sender;

//Actiop Sheet
-(IBAction)pinnedActionSheet:(UIButton *)sender;
-(IBAction)pinnedToolbarButtonActionSheet:(UIBarButtonItem *)sender;
-(IBAction)regularActionSheet:(UIButton *)sender;

@end
