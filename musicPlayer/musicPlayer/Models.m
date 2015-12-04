//
//  models.m
//  musicPlayer
//
//  Created by king on 15/12/1.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "Models.h"

@implementation Models

- (instancetype)initWithMusics:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
