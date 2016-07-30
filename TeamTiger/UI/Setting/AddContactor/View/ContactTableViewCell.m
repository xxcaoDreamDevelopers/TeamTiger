//
//  ContactTableViewCell.m
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "ContactTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ContactTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局View
        [self setUpView];
    }
    return self;
}

#pragma mark - setUpView
- (void)setUpView{
    
    self.contentView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:47.0/255.0 blue:61.0/255.0 alpha:1.0];
    //头像
    [self headImageView];
    //姓名
    [self.contentView addSubview:self.nameLabel];
    //邮箱
    [self.contentView addSubview:self.emailLabel];
    //添加按钮
    [self.contentView addSubview:self.operationBtn];
    
    UIImageView *line = [[UIImageView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.3;
    line.tag = 2016;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(69);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(minLineWidth);
    }];
}

- (void)reloadCell:(id)obj {
    
}

- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.0);
            make.top.mas_equalTo(10.0);
            make.width.mas_equalTo(40.0);
            make.height.mas_equalTo(40.0);
        }];
        setViewCorner(_headImageView,20);
    }
    return _headImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFont:[UIFont systemFontOfSize:16.0]];
        _nameLabel.textColor = [UIColor colorWithRed:54.0 / 255.0 green:82.0 / 255.0 blue:134.0 / 255.0 alpha:1.0];
        _nameLabel.text = @"刘鹏鹏";
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth - 100.0);
            make.left.equalTo(self.headImageView.mas_right).offset(15);
            make.top.mas_equalTo(10.0);
        }];
    }
    return _nameLabel;
}

- (UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc]init];
        [_emailLabel setFont:[UIFont systemFontOfSize:14.0]];
        _emailLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:129.0/255.0 alpha:1.0];
        _emailLabel.text = @"cxcxcxcx@qq.com";
        _emailLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_emailLabel];
        [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth - 100.0);
            make.left.equalTo(self.headImageView.mas_right).offset(15);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(2);
        }];
    }
    return _emailLabel;
}

- (UIButton *)operationBtn{
    if (!_operationBtn) {
        _operationBtn=[[UIButton alloc]initWithFrame:CGRectMake(50.0, 5.0, kScreenWidth-60.0, 40.0)];
    }
    return _operationBtn;
}


@end
