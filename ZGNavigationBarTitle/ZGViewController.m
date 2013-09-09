//
//  ZGViewController.m
//  ZGNavigationBarTitle
//
//  Created by Kyle Fang on 9/8/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ZGViewController.h"
#import "ZGNavigationBarTitleViewController.h"

@interface ZGViewController ()
@property (weak, nonatomic) IBOutlet UITextField *navigationSubtitle;

@end

@implementation ZGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateSubtitle:(id)sender {
    [(ZGNavigationBarTitleViewController *)self.navigationController updateSubtitleTo:self.navigationSubtitle.text];
}

- (IBAction)nextViewController:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ZGViewController"] animated:YES];
}

@end
