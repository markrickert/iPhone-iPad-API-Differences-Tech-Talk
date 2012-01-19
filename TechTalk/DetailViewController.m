//
//  DetailViewController.m
//  TechTalk
//
//  Created by  on 1/18/12.
//  Copyright (c) 2012 Mark Rickert. All rights reserved.
//

#import "DetailViewController.h"
#import "ModalView.h"
#include <unistd.h>

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
- (void)createModalWindowWithStyle:(UIModalPresentationStyle)presStyle customSize:(BOOL)custom;
- (void)pinnedPopoverFromSender:(UIBarButtonItem *)sender;
- (void)regularPopoverFromSender:(UIButton *)sender;
- (UIActionSheet *)getActionSheet;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;

@synthesize homeView, modalWindows, actionSheets, popoverControllers;
@synthesize popover;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

  self.navigationItem.rightBarButtonItem = nil;
  
  if (self.detailItem)
  {
    //Set the correct view
    if([self.detailItem isEqualToString:@"Modal Windows"])
      self.view = self.modalWindows;
    else if([self.detailItem isEqualToString:@"Popover Controllers"])
    {
      self.view = self.popoverControllers;

      UIBarButtonItem *popoverThingie = [[UIBarButtonItem alloc] initWithTitle:@"Pinned Popover" style:UIBarButtonItemStylePlain target:self action:@selector(pinnedPopover:)];
      self.navigationItem.rightBarButtonItem = popoverThingie;
    }
    else if([self.detailItem isEqualToString:@"Action Sheets"])
    {
      self.view = self.actionSheets;         

      UIBarButtonItem *actionSheetThingie = [[UIBarButtonItem alloc] initWithTitle:@"Pinned Action Sheet" style:UIBarButtonItemStylePlain target:self action:@selector(pinnedToolbarButtonActionSheet:)];
      self.navigationItem.rightBarButtonItem = actionSheetThingie;
}
    else
      self.view = self.homeView;
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
  self.detailDescriptionLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    self.title = NSLocalizedString(@"Detail View", @"Detail View");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark -
#pragma Modal Window Functions

-(void)createModalWindowWithStyle:(UIModalPresentationStyle)presStyle customSize:(BOOL)custom
{

  ModalView *modal = [[ModalView alloc] init];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:modal];
  navController.modalPresentationStyle = presStyle;  

  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    [self.splitViewController presentModalViewController:navController animated:YES];
  else
    [self presentModalViewController:navController animated:YES];

  if(custom == YES)
  {
    //lets mess with the size a bit.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
      navController.view.superview.frame = CGRectMake(0, 0, 320, 460);
      navController.view.superview.center = self.view.center;
    }
    
  }
}

-(IBAction)regularModal:(id)sender
{
  [self createModalWindowWithStyle:UIModalPresentationFullScreen customSize:NO];
}

-(IBAction)formSheetModal:(id)sender
{
  [self createModalWindowWithStyle:UIModalPresentationFormSheet customSize:NO];  
}

-(IBAction)pageSheetModal:(id)sender
{
  [self createModalWindowWithStyle:UIModalPresentationPageSheet customSize:NO];
}

-(IBAction)customSizeModal:(id)sender
{
  [self createModalWindowWithStyle:UIModalPresentationFormSheet customSize:YES];
}

#pragma mark -
#pragma mark Popovers

-(IBAction)regularPopover:(UIButton *)sender
{
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
  {
    [[[UIAlertView alloc] initWithTitle:@"CRASH!" message:@"NSInvalidArgumentException, reason: -[UIPopoverController initWithContentViewController:] called when not running under UIUserInterfaceIdiomPad." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  
    [self performSelector:@selector(regularPopoverFromSender:) withObject:nil afterDelay:1];
    return;
  }
  
  [self regularPopoverFromSender:sender];
}

-(IBAction)pinnedPopover:(UIBarButtonItem *)sender
{
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
  {
    [[[UIAlertView alloc] initWithTitle:@"CRASH!" message:@"NSInvalidArgumentException, reason: -[UIPopoverController initWithContentViewController:] called when not running under UIUserInterfaceIdiomPad." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  
    [self performSelector:@selector(pinnedPopoverFromSender:) withObject:nil afterDelay:1];
    return;
  }
  
  [self pinnedPopoverFromSender:sender];

}

-(void) regularPopoverFromSender:(UIButton *)sender
{
  if(self.popover == nil)
  {
    ModalView *modal = [[ModalView alloc] init];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:modal];    
  }
  [self.popover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];  
  
}

-(void) pinnedPopoverFromSender:(UIBarButtonItem *)sender
{
  if(self.popover == nil)
  {
    ModalView *modal = [[ModalView alloc] init];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:modal];    
  }
  [self.popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];  
}

#pragma mark -
#pragma mark ActionSheets

-(UIActionSheet *)getActionSheet
{
  UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Action Sheet TItle" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive Button" otherButtonTitles:@"Option 1", @"Option 2", @"Option 3", nil];
  return as;
}

-(IBAction)pinnedActionSheet:(UIButton *)sender
{
  UIActionSheet *as = [self getActionSheet];
  [as showFromRect:sender.frame inView:self.view animated:YES];
}

-(IBAction)pinnedToolbarButtonActionSheet:(UIBarButtonItem *)sender
{
  UIActionSheet *as = [self getActionSheet];
  [as showFromBarButtonItem:sender animated:YES];
}

-(IBAction)regularActionSheet:(UIButton *)sender
{
  UIActionSheet *as = [self getActionSheet];
  [as showInView:self.view];
}

@end
