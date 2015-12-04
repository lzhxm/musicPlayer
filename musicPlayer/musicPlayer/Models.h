//
//  models.h
//  musicPlayer
//
//  Created by king on 15/12/1.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Models : NSObject

@property (nonatomic,strong) NSString *music;
@property (nonatomic,strong) NSString *lrc;
@property (nonatomic,strong) NSString *picture;
@property (nonatomic,strong) NSString *musicName;
@property (nonatomic,strong) NSString *singer;

- (instancetype)initWithMusics:(NSDictionary *)dict;

@end
