//
//  TTPickerView.m
//  TeamTiger
//
//  Created by xxcao on 16/8/8.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTPickerView.h"

@implementation TTPickerView

- (instancetype)initWithDatas:(NSArray *)datas SelectBlock:(TTPickerViewBlock)block TapBlock:(TTTapBlock)tapBlock {

    self = [super init];
    if (self) {
        _dataSources = [NSMutableArray arrayWithArray:datas];

        _picker = [[UIPickerView alloc] init];
        [self addSubview:_picker];
        _picker.delegate = self;
        [_picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(200);
        }];
        [_picker reloadAllComponents];
        
        _pickerBlock = [block copy];
        
        _tapBlock = [tapBlock copy];
        
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGR];

    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSources.count;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *srcStr = self.dataSources[row];
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:srcStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attributedStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerBlock) {
        self.pickerBlock(self,self.dataSources[row]);
    }
}

- (void)tapAction:(id)sender {
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

@end
