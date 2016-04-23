//
//  TTVideo.h
//  TTPlayer
//
//  Created by Lavender on 16/4/23.
//  Copyright © 2016年 lavender. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *   ID = 02;
 image = "http://127.0.0.1/resources/images/minion_02.png";
 length = 14;
 name = "\U5c0f\U9ec4\U4eba \U7b2c02\U90e8";
 url = "http://127.0.0.1/resources/videos/minion_02.mp4";
 */
@interface TTVideo : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
+(instancetype)VideoWithDict:(NSDictionary *)dict;
@end
