//
//  TTPlayerView.m
//  TTPlayer
//
//  Created by Lavender on 16/4/23.
//  Copyright © 2016年 lavender. All rights reserved.
//

#import "TTPlayerView.h"
#import "TTPlayerView.h"
#import "UIImageView+WebCache.h"
#import "TTVideo.h"

@interface TTPlayerView ()
@property (nonatomic, strong) NSArray *videos;
@end
@implementation TTPlayerView
/**
 *   获取url字符串 然后将json转变成字典或者数组，然后字典数组转模型，然后给ttplyaerview使用，调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //    获取url地址字符串
    NSURL *urlString = [NSURL URLWithString:@"http://127.0.0.1/resources/vedios.json"];
    
    //    已知json的根元素为数组，so用数组接json解析出来的数据
    [[[NSURLSession sharedSession] dataTaskWithURL:urlString completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
#warning 这里一定要注意用判断，因为网络的情况都素不清楚的!
        if (data && !error) {
            
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            NSLog(@"%@",array);
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
                [self.tableView reloadData];
            });
        }
            }] resume];
}
#pragma mark 数据源方法
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
