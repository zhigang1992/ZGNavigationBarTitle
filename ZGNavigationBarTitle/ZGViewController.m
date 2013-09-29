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
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        self.title = @"World";
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateSubtitle:(id)sender
{
    self.subtitle = self.navigationSubtitle.text;
}

- (IBAction)clear:(id)sender
{
    self.navigationSubtitle.text = @"";
    self.subtitle = nil;
}

- (IBAction)nextViewController:(id)sender
{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ZGViewController"] animated:YES];
}

@end
