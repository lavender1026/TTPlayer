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

- (void)viewDidLoad
{
//    实例化对象
    TTPlayerView *video = [[TTPlayerView alloc]initWithFrame:self.view.bounds];
    video.vc = self;
    [self.view addSubview:video];
    
}
@end
