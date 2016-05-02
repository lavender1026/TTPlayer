//
//  TTPlayerView.m
//  TTPlayer
//
//  Created by Lavender on 16/4/23.
//  Copyright © 2016年 lavender. All rights reserved.
//


#import "TTPlayerView.h"
#import "UIImageView+WebCache.h"
#import "TTVideo.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TTPlayerView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *videos;
@end
@implementation TTPlayerView

//懒加载模型数组
- (NSArray *)videos
{
    if (!_videos) {
        _videos = [NSArray array];
    }
    return _videos;

}
#pragma mark     重写初始化方法
- (instancetype) initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        [self loadServerDataWithUrlString:@"http://127.0.0.1/resources/vedios.json"];
//        这里注意 ，设置代理以及数据源可以设置给view
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark 读取网络数据
- (void)loadServerDataWithUrlString:(NSString *)urlString
{
    //    获取url地址字符串
    NSURL *url = [NSURL URLWithString:urlString];
    
    //    已知json的根元素为数组，so用数组接json解析出来的数据
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
#warning 这里一定要注意用判断，因为网络的情况都素不清楚的!
        if (data && !error) {
            
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            //            NSLog(@"%@",array);
            /**
             *   添加模型
             */
            NSMutableArray *arrM = [NSMutableArray array];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TTVideo *video = [TTVideo VideoWithDict:obj];
                [arrM addObject:video];
                //                这里讲模型数组设置到声明的array中
                _videos = arrM;
            }];
            /**
             *   模型添加完毕，这时候需要刷新ui，因为使用json网络下载都是异步子线程中完成的，so要返回主线程刷新、
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
            });
                    }
    }] resume];

}

#pragma mark tableview代理

//设置row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    获取视频地址
    TTVideo *videoUrl = self.videos[indexPath.row];
    NSURL *url = [NSURL URLWithString:videoUrl.url];
//    设置播放器
    AVPlayerViewController *av = [[AVPlayerViewController alloc]init];
    av.player = [AVPlayer playerWithURL:url];
//    播放视频
    [av.player play];
//    跳转控制器
    [self.vc presentViewController:av animated:YES completion:^{
//        <#code#>
    }];
}

#pragma mark 数据源方法data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    获取模型数据
    TTVideo *video = self.videos[indexPath.row];
//    名称 时长
    cell.textLabel.text =video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长：%@",video.length];
//   设置下载图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:video.image] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    return cell;
}

@end
