//
//  ZGNavigationBarTitleViewController.h
//  ZGNavigationBarTitle
//
//  Created by Kyle Fang on 9/8/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZGNavigationSubTitle)
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;
@end

@interface ZGNavigationBarTitleViewController : UINavigationController
@end
