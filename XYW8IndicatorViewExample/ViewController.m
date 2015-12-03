//
//  ViewController.m
//  XYW8IndicatorViewExample
//
//  Created by xiaoyu on 15/12/2.
//  Copyright © 2015年 _companyname_. All rights reserved.
//

#import "ViewController.h"
#import "XYW8IndicatorView.h"

@interface ViewController () <XYW8IndicatorViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XYW8IndicatorView *animationView = [[XYW8IndicatorView alloc] init];
    animationView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    animationView.frame = (CGRect){0,0,self.view.frame.size.width,self.view.frame.size.height};
    animationView.dotColor = [UIColor redColor];
    animationView.delegate = self;
    [self.view addSubview:animationView];
    
    [animationView startAnimating];
}

#pragma mark - XYW8IndicatorViewDelgate
-(void)indicatorViewDidTapBakground:(XYW8IndicatorView *)indicatorView{
    
}

- (void)indicatorViewWillStartAnimating:(XYW8IndicatorView *)indicatorView{
    
}

- (void)indicatorViewDidStartAnimating:(XYW8IndicatorView *)indicatorView{
    
}

- (void)indicatorView:(XYW8IndicatorView *)indicatorView willEndAnimating:(BOOL)animted{
    
}

- (void)indicatorView:(XYW8IndicatorView *)indicatorView didEndAnimating:(BOOL)animted{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
