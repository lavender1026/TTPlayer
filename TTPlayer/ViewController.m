//
//  ViewController.m
//  TTPlayer
//
//  Created by Lavender on 16/4/25.
//  Copyright © 2016年 lavender. All rights reserved.
//

#import "ViewController.h"
#import "TTPlayerView.h"
@implementation ViewController
/**
 *   然而实际中的mvvm并没有采用在view中设置controller属性来达到跳转控制器的方法，而是采用了reactivecocoa—+通知的形式
 */
- (void)viewDidLoad
{
//    实例化对象
    TTPlayerView *video = [[TTPlayerView alloc]initWithFrame:self.view.bounds];
//    将video中的vc控制器属性赋值给self
    video.vc = self;
    [self.view addSubview:video];
    
}
@end
