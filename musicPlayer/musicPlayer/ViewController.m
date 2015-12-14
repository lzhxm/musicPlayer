//
//  ViewController.m
//  musicPlayer
//
//  Created by king on 15/11/30.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "MusicTableCell.h"

@interface ViewController ()<AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate>


@end

@implementation ViewController

- (NSMutableArray *)musicArray
{
    if (_musicArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"musicRecource" ofType:@"plist"];
        NSArray *arrar = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *musicMutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arrar) {
            Models *model = [[Models alloc] initWithMusics:dict];
            [musicMutableArray addObject:model];
        }
        _musicArray = musicMutableArray;
    }
    
    return _musicArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //更新界面
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    //创建按钮
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *frontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    

    [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    [frontButton setImage:[UIImage imageNamed:@"上一首"] forState:UIControlStateNormal];
    [nextButton setImage:[UIImage imageNamed:@"下一首"] forState:UIControlStateNormal];
    

    
    
    frontButton.frame = CGRectMake(43, 550, 50, 40);
    _playButton.frame = CGRectMake(175, 550, 70, 40);
    nextButton.frame = CGRectMake(292, 550, 50, 40);
    
    [self.view addSubview:_playButton];
    [self.view addSubview:frontButton];
    [self.view addSubview:nextButton];
    
    //为按钮添加点击事件
    [_playButton addTarget:self action:@selector(musicStart) forControlEvents:UIControlEventTouchUpInside];
    [frontButton addTarget:self action:@selector(musicFront) forControlEvents:UIControlEventTouchUpInside];
    [nextButton addTarget:self action:@selector(musicNext) forControlEvents:UIControlEventTouchUpInside];
    //进度条
    _timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 500, 280, 20)];
    [self.view addSubview:_timeSlider];
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, 40, 20)];
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(330, 500, 40, 20)];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"声音"]];
    img.frame = CGRectMake(340, 420, 20, 20);
    
    [self.view addSubview:img];
    [self.view addSubview:_label1];
    [self.view addSubview:_label2];
   
}


- (void)viewDidDisappear:(BOOL)animated
{
    [_player stop];
}


//设置界面信息
- (void)setUI
{

    //显示歌名
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0,64,375, 50)];
    
    _label.textColor = [UIColor blackColor];
    _label.text = _model.musicName;
    _label.font = [UIFont systemFontOfSize:30];
    _label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:_label];
    //显示图片
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, 0, 375, 667);
    _imageView.alpha = 0.5;
    _imageView.image = [UIImage imageNamed:_model.picture];
    [self.view addSubview:_imageView];
    
    [self.view sendSubviewToBack:_imageView];
    
    //创建音量控制
    _volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(250, 300, 200, 20)];
    _volumeSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _volumeSlider.value = 0.5;
    _volumeSlider.minimumValue = 0;
    _volumeSlider.maximumValue = 1;
    [self.view addSubview:_volumeSlider];
    [_volumeSlider addTarget:self action:@selector(volume) forControlEvents:UIControlEventValueChanged];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(35, 110, 300, 390) style:UITableViewStylePlain];
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.allowsSelection = NO;
    
    [self.view addSubview:_tableView];
    [self initLrc:_model.lrc];
    [self loadMusic:_model.musicName AndType:@"mp3"];
    [_player play];
}
//加载歌曲
- (void)loadMusic:(NSString *)musicName AndType:(NSString *)type
{
     NSString *path = [[NSBundle mainBundle] pathForResource:musicName ofType:type];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
   _player.delegate = self;
}
//播放
- (void)musicStart
{
    
    if (_player.playing) {
        [_player pause];
       
        [_playButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    } else {
        [_player play];

        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    }
}

//上一首
- (void)musicFront
{
   
    if (_integer <= 0) {
        _integer = [_musicArray count]-1;
        _model = self.musicArray[_integer];
        [self loadMusic:_model.musicName AndType:@"mp3"];
        [self initLrc:_model.lrc];
        _label.text = _model.musicName;
        _imageView.image = [UIImage imageNamed:_model.picture];
        [_player play];

        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    } else {
        _integer --;
        _model = self.musicArray[_integer];
        [self loadMusic:_model.musicName AndType:@"mp3"];
        [self initLrc:_model.lrc];
        _label.text = _model.musicName;
        _imageView.image = [UIImage imageNamed:_model.picture];
        [_player play];

        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    }
   
}
//下一首
- (void)musicNext
{
   
    if (_integer >=[_musicArray count]-1) {
        _integer = 0;
        _model = self.musicArray[_integer];
        [self loadMusic:_model.musicName AndType:@"mp3"];
        [self initLrc:_model.lrc];
        _label.text = _model.musicName;
        _imageView.image = [UIImage imageNamed:_model.picture];
        [_player play];
 
        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    } else {
         _integer ++;
      
         _model = self.musicArray[_integer];
      [self loadMusic:_model.musicName AndType:@"mp3"];
        [self initLrc:_model.lrc];
        _label.text = _model.musicName;
        _imageView.image = [UIImage imageNamed:_model.picture];
        [_player play];
   
        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    }
   
   
 
}
//歌曲播放完毕执行此方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    if (flag) {
        [self musicNext];
    }
    
}
//调节音量大小
- (void)volume
{
    _player.volume = _volumeSlider.value;
}

//初始化歌词
- (void)initLrc:(NSString *)lrcName
{
    NSString *pathLrc = [[NSBundle mainBundle] pathForResource:lrcName ofType:@"lrc"];
    Lrc *lrc1 = [[Lrc alloc] init];
    NSDictionary *lrcDict = [lrc1 musicLrc:pathLrc];
    _lrcDict = [NSMutableDictionary dictionaryWithDictionary:[lrcDict objectForKey:@"lrcDict"]];
    _timeArray = [NSMutableArray arrayWithArray:[lrcDict objectForKey:@"timeArray"]];
}
//动态更新歌词
- (void)updateLrcTableView:(NSUInteger)lineNumber
{
    _lrcRow = lineNumber;
    [_tableView reloadData];
   
    if (lineNumber > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
        
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}
//进度条更新
- (void)showTime
{
    Lrc *lrc = [[Lrc alloc] init];
    [self displayWord];
    _label1.text = [lrc timeIntival:_player.currentTime];
    _label2.text = [lrc timeIntival:_player.duration];
    _timeSlider.value = _player.currentTime/_player.duration;
}
//
- (void)displayWord
{
    Lrc *lrc = [[Lrc alloc] init];
    NSInteger num = [_timeArray count];
    for (int i = 0; i<num; i++) {
        NSUInteger currentTime = [lrc changeTime:_timeArray[i]];
        if (i + 1<num) {
            NSUInteger currentTime1 = [lrc changeTime:_timeArray[i+1]];
            if (_player.currentTime >currentTime && _player.currentTime<currentTime1) {
                [self updateLrcTableView:i];
                [_tableView reloadData];
                break;
            }
        }else if(_player.currentTime > currentTime){
            [self updateLrcTableView:i];
            [_tableView reloadData];
            break;
        
            
        }
    }
}
//UITableView代理实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_timeArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _lrcDict[_timeArray[indexPath.row]];
    if (indexPath.row == _lrcRow) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }else{
         cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
@end
