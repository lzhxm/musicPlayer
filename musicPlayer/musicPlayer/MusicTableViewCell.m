//
//  MusicTableViewCell.m
//  musicPlayer
//
//  Created by king on 15/12/10.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "MusicTableViewCell.h"


@implementation MusicTableViewCell

- (void)setModel:(Models *)model
{
    _model = model;
    _imgView.image = [UIImage imageNamed:_model.picture];
    _titleLabel.text = _model.musicName;
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 35;
    _imgView.layer.borderWidth = 1;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
