//
//  Lrc.m
//  musicPlayer
//
//  Created by king on 15/12/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "Lrc.h"

@implementation Lrc

//歌词解析
- (NSDictionary *)musicLrc:(NSString *)lrc
{
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *lrcDict = [[NSMutableDictionary alloc] init];
    NSString *path = [NSString stringWithContentsOfFile:lrc encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [path componentsSeparatedByString:@"\n"];
    for (int i = 0; i<[array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *linArray = [linStr componentsSeparatedByString:@"]"];
        if ([linArray[0] length]>8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = [linArray objectAtIndex:1];
                NSString *timeStr = [[linArray objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];
                [lrcDict setObject:lrcStr forKey:timeStr];
                [timeArray addObject:timeStr];
               
            }
        }
    }
    NSDictionary *dict = @{@"lrcDict":lrcDict,@"timeArray":timeArray};
    return dict;

    
}
//时间转换
- (NSUInteger)changeTime:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@":"];
    return [array[0] intValue]*60 + [array[1] intValue];
}
//时间显示
- (NSString *)timeIntival:(NSInteger)time
{
    if (time % 60 <10) {
        return [NSString stringWithFormat:@"%ld:0%ld",time/60,time%60];
    } else {
        return [NSString stringWithFormat:@"%ld:%ld",time/60,time%60];
    }
}
@end
