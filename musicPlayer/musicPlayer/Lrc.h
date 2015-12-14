//
//  Lrc.h
//  musicPlayer
//
//  Created by king on 15/12/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lrc : NSObject

@property (nonatomic,strong) NSArray *lrcArray;
@property (nonatomic) NSTimeInterval timercount;

- (NSDictionary *)musicLrc:(NSString *)lrc;
- (NSUInteger)changeTime:(NSString *)str;
- (NSString *)timeIntival:(NSInteger)time;

@end
