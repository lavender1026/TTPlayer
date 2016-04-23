//
//  TTVideo.m
//  TTPlayer
//
//  Created by Lavender on 16/4/23.
//  Copyright © 2016年 lavender. All rights reserved.
//

#import "TTVideo.h"

@implementation TTVideo
+(instancetype)VideoWithDict:(NSDictionary *)dict
{
    TTVideo *video = [[TTVideo alloc]init];
    
    [video setValuesForKeysWithDictionary:dict];
    
    return video;
}
@end
