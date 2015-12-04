//
//  ViewController.h
//  musicPlayer
//
//  Created by king on 15/11/30.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Models.h"
#import "Lrc.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UISlider *volumeSlider;
@property (nonatomic) NSInteger  integer;//数组索引
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *timeArray;//时间数组
@property (nonatomic,strong) NSMutableDictionary *lrcDict;//歌词字典
@property (nonatomic) NSInteger lrcRow;//歌词行数
@property (nonatomic,strong) UISlider *timeSlider;//播放进度
@property (nonatomic,strong) UILabel *label1;//已播放时长
@property (nonatomic,strong) UILabel *label2;//总时长
@property (nonatomic,strong) void (^changeValue) (Models *modelValue);
@property (nonatomic,strong) Models *model;

@end

