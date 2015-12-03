//
//  XYW8IndicatorView.m
//  XYW8IndicatorViewExample
//
//  Created by xiaoyu on 15/12/2.
//  Copyright © 2015年 _companyname_. All rights reserved.
//  if any question  email me with 772381545@qq.com China

#import "XYW8IndicatorView.h"

@implementation XYW8IndicatorView{
    UIView *contentView;
    UIView *dotsSuperView;
}

static int dotCount = 5;
static CFTimeInterval animationDuration = 7.15;

-(instancetype)init{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        contentView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:contentView];
        
        UITapGestureRecognizer *contentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapGesture)];
        [contentView addGestureRecognizer:contentTapGesture];
        
        dotsSuperView = [[UIView alloc] init];
        [contentView addSubview:dotsSuperView];
        
        if (!self.dotColor) {
            self.dotColor = [UIColor grayColor];
        }
        
        for (int i = 0; i < dotCount; i++) {
            CALayer *layer = [CALayer layer];
            layer.opacity = 0.f;
            layer.frame = CGRectMake(0, 0, 60, 60);
            [dotsSuperView.layer addSublayer:layer];
            
            CALayer *dotLayer = [CALayer layer];
            dotLayer.frame = CGRectMake(6, 6, 6, 6);
            dotLayer.cornerRadius = 3.f;
            dotLayer.masksToBounds = YES;
            dotLayer.backgroundColor = self.dotColor.CGColor;
            [layer addSublayer:dotLayer];
        }
        
        self.loadingLabel = [[UILabel alloc] init];
        self.loadingLabel.text = @"loading";
        self.loadingLabel.frame = (CGRect){10,(CGRectGetHeight(frame)-60)/2+60+20,contentView.frame.size.width-20,20};
        self.loadingLabel.textColor = [UIColor whiteColor];
        self.loadingLabel.textAlignment = NSTextAlignmentCenter;
        self.loadingLabel.font = [UIFont systemFontOfSize:17];
        [contentView addSubview:self.loadingLabel];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    contentView.frame = frame;
    dotsSuperView.frame = (CGRect){(CGRectGetWidth(frame)-60)/2,(CGRectGetHeight(frame)-60)/2-20,60,60};
    self.loadingLabel.frame = (CGRect){10,(CGRectGetHeight(frame)-60)/2+60+20,contentView.frame.size.width-20,20};
}

- (void)setDotColor:(UIColor *)dotColor{
    if (!dotColor) {
        dotColor = [UIColor grayColor];
    }
    _dotColor = dotColor;
    [dotsSuperView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL *stop) {
        [layer.sublayers enumerateObjectsUsingBlock:^(CALayer *obj, NSUInteger idx, BOOL *stop) {
            obj.backgroundColor = dotColor.CGColor;
        }];
    }];
}

- (void)startAnimating{
    if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorViewWillStartAnimating:)]) {
        [self.delegate indicatorViewWillStartAnimating:self];
    }
    if (contentView.alpha < 0.1f) {
        [UIView animateWithDuration:0.2f animations:^{
            contentView.alpha = 1.f;
        } completion:nil];
    }
    _animating = NO;
    CFTimeInterval beginTime = CACurrentMediaTime();
    NSArray *delayTime = @[@1.56,@0.31,@0.62,@0.94,@1.25];
    
    for (int i = 0; i < dotCount; i++) {
        CALayer *layer = dotsSuperView.layer.sublayers[i];
        
        NSArray *rotateTimeFunction =@[
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];

        NSMutableArray *rotateValues = [NSMutableArray array];
        [rotateValues addObject:[NSNumber numberWithFloat:M_PI]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+M_PI*(300.0f-180.0f)/180.0f]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+M_PI*(410.0f-300.0f)/180.0f]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+M_PI*(645.0f-410.0f)/180.0f]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+M_PI*(770.0f-645.0f)/180.0f]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+M_PI*(900.0f-770.0f)/180.0f]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+0]];
        [rotateValues addObject:[NSNumber numberWithFloat:[rotateValues[rotateValues.count-1] floatValue]+0]];
        
        CAKeyframeAnimation *rotateAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnim.keyTimes = @[@0.0, @0.07, @0.3, @0.39, @0.7, @0.75, @0.76, @1.0];
        rotateAnim.duration = animationDuration;
        rotateAnim.values = rotateValues;
        rotateAnim.timingFunctions = rotateTimeFunction;
        
        CAKeyframeAnimation *opacityAnima = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnima.keyTimes = @[@0.0, @0.07, @0.3, @0.39, @0.7, @0.75, @0.76, @1.0];
        opacityAnima.values = @[@0.0, @1.0, @1.0, @1.0, @1.0, @0.0, @0.0, @0.0];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = false;
        group.repeatCount = HUGE;
        group.duration = animationDuration;
        group.animations = @[rotateAnim, opacityAnima];
        group.beginTime = beginTime + [delayTime[i] floatValue];
        
        [layer addAnimation:group forKey:@"group"];
    }
    _animating = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorViewDidStartAnimating:)]) {
        [self.delegate indicatorViewDidStartAnimating:self];
    }
}

- (void)stopAnimating:(BOOL)animated{
    if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorView:willEndAnimating:)]) {
        [self.delegate indicatorView:self willEndAnimating:animated];
    }
    [dotsSuperView.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL * stop) {
        [layer removeAllAnimations];
    }];
    _animating = NO;
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            contentView.alpha = 0.f;
        } completion:^(BOOL finished) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorView:didEndAnimating:)]) {
                [self.delegate indicatorView:self didEndAnimating:animated];
            }
        }];
    }else{
        contentView.alpha = 0.f;
        if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorView:didEndAnimating:)]) {
            [self.delegate indicatorView:self didEndAnimating:animated];
        }
    }
}

- (void)stopAnimating:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopAnimating:animated];
    });
}

#pragma mark - 
- (void)contentTapGesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(indicatorViewDidTapBakground:)]) {
        [self.delegate indicatorViewDidTapBakground:self];
    }
}


@end
