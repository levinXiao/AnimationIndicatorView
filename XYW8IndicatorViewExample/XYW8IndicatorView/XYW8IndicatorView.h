//
//  XYW8IndicatorView.h
//  XYW8IndicatorViewExample
//
//  Created by xiaoyu on 15/12/2.
//  Copyright © 2015年 _companyname_. All rights reserved.
//  if any question or bug  email me with 772381545@qq.com China

#import <UIKit/UIKit.h>

@protocol XYW8IndicatorViewDelegate;

@interface XYW8IndicatorView : UIView

//set the animating dot backgroundcolor default or nil  set to [UIColor grayColor]
@property (nonatomic,strong) UIColor *dotColor;

//set the loadingLabel  default set the text to @"loading"
@property (nonatomic,strong) UILabel *loadingLabel;

@property (nonatomic,assign) id<XYW8IndicatorViewDelegate> delegate;

//current animating state
@property (nonatomic,readonly,getter=isAnimating) BOOL animating;

- (void)startAnimating;

- (void)stopAnimating:(BOOL)animated;

- (void)stopAnimating:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end


@protocol XYW8IndicatorViewDelegate <NSObject>

@optional
//call when clicked background view  in here you can cut off background network requset
- (void)indicatorViewDidTapBakground:(XYW8IndicatorView *)indicatorView;

//call when the animation will/did start
- (void)indicatorViewWillStartAnimating:(XYW8IndicatorView *)indicatorView;
- (void)indicatorViewDidStartAnimating:(XYW8IndicatorView *)indicatorView;

//call when the animation will/did end
- (void)indicatorView:(XYW8IndicatorView *)indicatorView willEndAnimating:(BOOL)animted;
- (void)indicatorView:(XYW8IndicatorView *)indicatorView didEndAnimating:(BOOL)animted;

@end