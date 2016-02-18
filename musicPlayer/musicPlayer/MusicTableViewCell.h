//
//  MusicTableViewCell.h
//  musicPlayer
//
//  Created by king on 15/12/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

@interface MusicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

@property (nonatomic,strong) Models *model;
@end
