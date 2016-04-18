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

+ (void)initialize {
    if (self != [ZGNavigationTitleView class]) {
        return;
    }
    
    [[ZGNavigationTitleView appearance] setNavigationBarTitleFontColor:[UIColor blackColor]];
    [[ZGNavigationTitleView appearance] setNavigationBarSubtitleFontColor:[UIColor colorWithWhite:0.3 alpha:1]];
    
    [[ZGNavigationTitleView appearance] setNavigationBarTitleFont:[UIFont systemFontOfSize:17]];
    [[ZGNavigationTitleView appearance] setNavigationBarTitleFontInSubtitleMode:[UIFont systemFontOfSize:15]];
    [[ZGNavigationTitleView appearance] setNavigationBarSubtitleFont:[UIFont systemFontOfSize:12]];
}

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

- (float)offsetXTitleWithSubtitle:(BOOL)subtitle inRect:(CGRect)rect
{
	float finalCenter = (self.superview.frame.size.width / 2) - (self.frame.origin.x + rect.size.width / 2);
	UILabel *label = [[UILabel alloc] init];
	label.text = self.navigationBarTitle;
	label.font = subtitle ? self.navigationBarTitleFontInSubtitleMode : self.navigationBarTitleFont;
	[label sizeToFit];
	
	float spaceLeft = (rect.size.width + finalCenter) - label.frame.size.width;
	
	if (spaceLeft < 0) {
		finalCenter = 0;
	}
	else if (spaceLeft < (fabsf(finalCenter))) {
		finalCenter = spaceLeft - fabsf(finalCenter);
		finalCenter = finalCenter < 0 ? 0 : finalCenter;
	}
	return finalCenter;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawContent:(CGRect)rect
{
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	
    // Drawing code
    if (self.navigationBarSubtitle.length) {
        CGRect titleRect = rect;
        titleRect.origin.y = 4;
		titleRect.origin.x = [self offsetXTitleWithSubtitle:YES inRect:rect];
        titleRect.size.height = 20;
        [self.navigationBarTitleFontColor setFill];
		[self.navigationBarTitle drawInRect:titleRect withAttributes:@{
																	  NSForegroundColorAttributeName: self.navigationBarTitleFontColor,
																	  NSFontAttributeName: self.navigationBarTitleFontInSubtitleMode,
																	  NSParagraphStyleAttributeName: paragraphStyle}];
		
        CGRect subtitleRect = rect;
        subtitleRect.origin.y = 24;
        subtitleRect.size.height = rect.size.height - 24;
		subtitleRect.origin.x = [self offsetXTitleWithSubtitle:YES inRect:rect];
        [self.navigationBarSubtitleFontColor setFill];
		[self.navigationBarSubtitle drawInRect:subtitleRect withAttributes:@{
																		  NSForegroundColorAttributeName: self.navigationBarSubtitleFontColor,
																		  NSFontAttributeName: self.navigationBarSubtitleFont,
																		  NSParagraphStyleAttributeName: paragraphStyle}];

    }
    else {
        CGRect titleRect = rect;
        titleRect.origin.y = (rect.size.height - 24.f) / 2.f;
        titleRect.size.height = 24.f;
		titleRect.origin.x = [self offsetXTitleWithSubtitle:NO inRect:rect];;
        [self.navigationBarTitleFontColor setFill];
		[self.navigationBarTitle drawInRect:titleRect withAttributes:@{
																	   NSForegroundColorAttributeName: self.navigationBarTitleFontColor,
																	   NSFontAttributeName: self.navigationBarTitleFont,
																	   NSParagraphStyleAttributeName: paragraphStyle}];
    }
}

@end
