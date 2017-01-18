//
//  StoryDetialTableViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/18.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "StoryDetialTableViewCell.h"

@implementation StoryDetialTableViewCell


- (UIImageView *)picture
{
    if (_picture == nil) {
        self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth - 40, 100)];
        [self.contentView addSubview:_picture];
        UITapGestureRecognizer *panRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        _picture.userInteractionEnabled = YES;
        [_picture addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
        //名字

    }
    return _picture;
}


- (UILabel *)text
{
    if (_text == nil) {
        self.text = [[UILabel alloc]init]; 
        self.text.numberOfLines = 0;
        self.text.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_text];
    }
    return _text;
}


- (void)getValueFromDeitalModel:(Detail_listModel *)model
{
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:pich]];
    self.text.text = model.text;
}




- (void)awakeFromNib {
    // Initialization code
    
}
- (void)handlePanFrom:(UITapGestureRecognizer *)sender {
    [SJAvatarBrowser showImage:(UIImageView*)sender.view];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
