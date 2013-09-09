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

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customLooks];
    }
    return self;
}

- (void)customLooks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
            [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithWhite:.6 alpha:0.4]];
        } else {
            [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        }
        [[ZGNavigationTitleView appearance] setNavigationBarTitleFontColor:[UIColor blackColor]];
        [[ZGNavigationTitleView appearance] setNavigationBarSubtitleFontColor:[UIColor colorWithWhite:0.3 alpha:1]];
    });
}

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

- (IBAction)clear:(id)sender {
    self.navigationSubtitle.text = @"";
    [(ZGNavigationBarTitleViewController *)self.navigationController updateSubtitleTo:nil];
}

- (IBAction)nextViewController:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ZGViewController"] animated:YES];
}

@end
