//
//  HomeCellModel.h
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomeCellModel : NSObject

@property (strong, nonatomic) UIImageView *headImage;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) UIImageView *image1;
@property (strong, nonatomic) UIImageView *image2;
@property (strong, nonatomic) UIImageView *image3;


@end
