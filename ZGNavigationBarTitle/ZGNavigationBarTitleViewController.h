//
//  ZGNavigationBarTitleViewController.h
//  ZGNavigationBarTitle
//
//  Created by Kyle Fang on 9/8/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGNavigationTitleView.h"

@interface ZGNavigationBarTitleViewController : UINavigationController
- (void)updateSubtitleTo:(NSString *)subtitle;
@end
