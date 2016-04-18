//
//  ZGNavigationTitleView.h
//  ZGNavigationBarTitle
//
//  Created by Kyle Fang on 9/8/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGNavigationTitleView : UIView
@property (nonatomic, copy) NSString *navigationBarTitle;
@property (nonatomic, copy) NSString *navigationBarSubtitle;
@property (nonatomic, copy) UIColor *navigationBarTitleFontColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) UIColor *navigationBarSubtitleFontColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) UIFont *navigationBarTitleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) UIFont *navigationBarTitleFontInSubtitleMode UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) UIFont *navigationBarSubtitleFont UI_APPEARANCE_SELECTOR;
@end
