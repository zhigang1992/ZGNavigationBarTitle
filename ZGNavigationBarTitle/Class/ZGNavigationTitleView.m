//
//  ZGNavigationTitleView.m
//  ZGNavigationBarTitle
//
//  Created by Kyle Fang on 9/8/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ZGNavigationTitleView.h"

@protocol ZGNavigationTitleContentViewDelegate <NSObject>
- (void)drawContent:(CGRect)rect;
@end

@interface ZGNavigationTitleContentView : UIView
@property (nonatomic, weak) id <ZGNavigationTitleContentViewDelegate> delegate;
@end

@implementation ZGNavigationTitleContentView
- (void)drawRect:(CGRect)rect
{
    if ([self.delegate respondsToSelector:@selector(drawContent:)]) {
        [self.delegate drawContent:rect];
    }
}
@end

@interface ZGNavigationTitleView () <ZGNavigationTitleContentViewDelegate>
@property (nonatomic, strong) ZGNavigationTitleContentView *contentView;
@end

@implementation ZGNavigationTitleView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    self.contentView = [[ZGNavigationTitleContentView alloc] initWithFrame:self.frame];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
}

- (void)setNavigationBarTitle:(NSString *)navigationBarTitle
{
    if (![_navigationBarTitle isEqualToString:navigationBarTitle]) {
        _navigationBarTitle = navigationBarTitle;
        [self.contentView setNeedsDisplay];
    }
}

- (void)setNavigationBarSubtitle:(NSString *)navigationBarSubtitle
{
    if (![_navigationBarSubtitle isEqualToString:navigationBarSubtitle]) {
        if (navigationBarSubtitle.length && !_navigationBarSubtitle.length) {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.4f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;
            [transition setValue:(id) kCFBooleanFalse forKey:kCATransitionFade];
            [self.contentView.layer addAnimation:transition forKey:nil];
        }
        else if (!navigationBarSubtitle.length && _navigationBarSubtitle.length) {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.4f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromBottom;
            [transition setValue:(id) kCFBooleanFalse forKey:kCATransitionFade];
            [self.contentView.layer addAnimation:transition forKey:nil];
        }
        _navigationBarSubtitle = navigationBarSubtitle;
        [self.contentView setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawContent:(CGRect)rect
{
    // Default paragraph style
    NSMutableParagraphStyle *paragraphStyle     = NSMutableParagraphStyle.new;
    NSMutableDictionary     *subtitleAttributes = NSMutableDictionary.dictionary;
    NSMutableDictionary     *titleAttributes    = NSMutableDictionary.dictionary;
    
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    // Drawing code
    if (self.navigationBarSubtitle.length) {
        
        [titleAttributes setValue:[UIFont boldSystemFontOfSize:17]      forKey:NSFontAttributeName];
        [titleAttributes setValue:paragraphStyle                        forKey:NSParagraphStyleAttributeName];
        
        [subtitleAttributes setValue:[UIFont boldSystemFontOfSize:13]   forKey:NSFontAttributeName];
        [subtitleAttributes setValue:paragraphStyle                     forKey:NSParagraphStyleAttributeName];
        
        CGRect titleRect = rect;
        titleRect.origin.y = 4;
        titleRect.size.height = 20;
        [self.navigationBarTitleFontColor setFill];
        [self.navigationBarTitle drawInRect:titleRect withAttributes:titleAttributes];
        CGRect subtitleRect = rect;
        subtitleRect.origin.y = 24;
        subtitleRect.size.height = rect.size.height - 24;
        [self.navigationBarSubtitleFontColor setFill];
        [self.navigationBarSubtitle drawInRect:subtitleRect withAttributes:subtitleAttributes];
    }
    else {
        
        [titleAttributes setValue:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
        [titleAttributes setValue:paragraphStyle                   forKey:NSParagraphStyleAttributeName];
        
        CGRect titleRect = rect;
        titleRect.origin.y = (rect.size.height - 24.f) / 2.f;
        titleRect.size.height = 24.f;
        [self.navigationBarTitleFontColor setFill];
        [self.navigationBarTitle drawInRect:titleRect withAttributes:titleAttributes];
    }
}

@end
