//
//  ZGNavigationBarTitleViewController.m
//  ZGNavigationBarTitle
//
//  Created by Kyle Fang on 9/8/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ZGNavigationBarTitleViewController.h"

@interface ZGNavigationBarTitleViewController ()
@end

@implementation ZGNavigationBarTitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!self.topViewController.navigationItem.titleView) {
        ZGNavigationTitleView *titleView = [[ZGNavigationTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titleView.navigationBarTitle = self.topViewController.title.length ? self.topViewController.title : self.topViewController.navigationItem.title;
        self.topViewController.navigationItem.titleView = titleView;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (!viewController.navigationItem.titleView) {
        ZGNavigationTitleView *titleView = [[ZGNavigationTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titleView.navigationBarTitle = viewController.title.length ? viewController.title : viewController.navigationItem.title;
        viewController.navigationItem.titleView = titleView;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)updateSubtitleTo:(NSString *)subtitle{
    if ([self.visibleViewController.navigationItem.titleView isKindOfClass:[ZGNavigationTitleView class]]) {
        [(ZGNavigationTitleView *)self.visibleViewController.navigationItem.titleView setNavigationBarSubtitle:subtitle];
    }
}

@end
