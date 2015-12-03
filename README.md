# XYW8AnimationIndicatorView
A Windows startup  indicatorviewStyle for iOS with Objective-C delegate support

#English
##How to Use

###alloc and satrt animation
```
    XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
    animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    animationView.frame = (CGRect){0,0,self.view.frame.size.width,self.view.frame.size.height};
    animationView.dotColor = [UIColor redColor];
    animationView.delegate = self;
    [self.view addSubview:animationView];
    
    [animationView startAnimating];
    
```

###stop the animation

``` 
- (void)stopAnimating:(BOOL)animated;

- (void)stopAnimating:(BOOL)animated afterDelay:(NSTimeInterval)delay;

    
```

###propertys

``` 
@interface XYW8IndicatorView : UIView

//set the animating dot backgroundcolor default or nil  set to [UIColor grayColor]
@property (nonatomic,strong) UIColor *dotColor;

//set the loadingLabel  default set the text to @"loading"
@property (nonatomic,strong) UILabel *loadingLabel;

@property (nonatomic,assign) id<XYW8IndicatorViewDelegate> delegate;

//current animating state
@property (nonatomic,readonly,getter=isAnimating) BOOL animating;

    
```

##Full Delegate Support
```
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

```

#中文
##使用说明

###初始化和开始动画
```
    XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
    animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    animationView.frame = (CGRect){0,0,self.view.frame.size.width,self.view.frame.size.height};
    animationView.dotColor = [UIColor redColor];
    animationView.delegate = self;
    [self.view addSubview:animationView];
    
    [animationView startAnimating];
    
```

###停止动画

``` 
- (void)stopAnimating:(BOOL)animated;

- (void)stopAnimating:(BOOL)animated afterDelay:(NSTimeInterval)delay;

    
```

###propertys

``` 
@interface XYW8IndicatorView : UIView

//set the animating dot backgroundcolor default or nil  set to [UIColor grayColor]
//设置要进行动画的点的背景颜色  如果传入nil或不设置该参数 默认设置成[UIColor grayColor]
@property (nonatomic,strong) UIColor *dotColor;

//set the loadingLabel  default set the text to @"loading"
//设置动画过程中的loadingLabel的属性  默认文字为loading
@property (nonatomic,strong) UILabel *loadingLabel;

@property (nonatomic,assign) id<XYW8IndicatorViewDelegate> delegate;

//current animating state
//现在是否处于动画中
@property (nonatomic,readonly,getter=isAnimating) BOOL animating;

    
```

##支持delegate
```
@protocol XYW8IndicatorViewDelegate <NSObject>

@optional

//call when clicked background view  in here you can cut off background network requset
//当tap背景时,该函数会被触发,在这儿你可以取消后台的网络请求去刷新界面
- (void)indicatorViewDidTapBakground:(XYW8IndicatorView *)indicatorView;

//call when the animation will/did start
//当动画 将要/已经 开始时的回调
- (void)indicatorViewWillStartAnimating:(XYW8IndicatorView *)indicatorView;
- (void)indicatorViewDidStartAnimating:(XYW8IndicatorView *)indicatorView;

//call when the animation will/did end
//当动画 将要/已经 结束时的回调
- (void)indicatorView:(XYW8IndicatorView *)indicatorView willEndAnimating:(BOOL)animted;
- (void)indicatorView:(XYW8IndicatorView *)indicatorView didEndAnimating:(BOOL)animted;

@end

```

