//
//  ModalView.m
//  TechTalk
//
//  Created by  on 1/18/12.
//  Copyright (c) 2012 Mark Rickert. All rights reserved.
//

#import "ModalView.h"

@interface ModalView ()
- (void)close;
@end

@implementation ModalView

@synthesize image;

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.title = @"Awww";
  
  UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
  self.navigationItem.rightBarButtonItem = closeButton;
  
  //Allow the user to tap the image to dismiss the modal controller as well.
  UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
  tapper.numberOfTapsRequired = 1;
  self.image.userInteractionEnabled = YES;
  [self.image addGestureRecognizer:tapper];
  
  self.contentSizeForViewInPopover = CGSizeMake(320, 480);

}

-(void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  int catImagePicker = arc4random() % 7;
  NSString *catPictureChosen = [NSString stringWithFormat:@"modal_%u.jpg", catImagePicker];
  [self.image setImage:[UIImage imageNamed:catPictureChosen]];  
}

-(void) close
{
  [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

@end
