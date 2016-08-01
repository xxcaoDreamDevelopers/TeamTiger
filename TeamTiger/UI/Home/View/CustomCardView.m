//
//  CustomCardView.m
//  CCDraggableCard-Master
//
//  Created by jzzx on 16/7/9.
//  Copyright © 2016年 Zechen Liu. All rights reserved.
//

#import "CustomCardView.h"
static const CGFloat kCustomEdage = -10.0f;
@interface CustomCardView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel     *titleLabel;

@end

@implementation CustomCardView

- (instancetype)init {
    if (self = [super init]) {
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.imageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.conteneView = [[UIView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView.layer setMasksToBounds:YES];
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.conteneView];
    [self.conteneView addSubview:self.imageView];
    [self.conteneView addSubview:self.titleLabel];
    
    self.conteneView.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
//    self.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
    self.backgroundColor = [UIColor clearColor];
}

- (void)cc_layoutSubviews {
    self.conteneView.frame = CGRectMake(kCustomEdage, Screen_Height * 0.25, self.frame.size.width, Screen_Height * 0.5);
    self.imageView.frame   = CGRectMake(0, 0, self.conteneView.frame.size.width, self.conteneView.frame.size.height - 64);
    self.titleLabel.frame = CGRectMake(0, self.conteneView.frame.size.height - 64, self.conteneView.frame.size.width, 64);
    
    [self.conteneView.layer setMasksToBounds:YES];
    [self.conteneView.layer setCornerRadius:10.0f];
    self.conteneView.layer.shouldRasterize = YES;
    self.conteneView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)installData:(NSDictionary *)element {
    self.imageView.image  = [UIImage imageNamed:element[@"image"]];
    self.titleLabel.text = element[@"title"];
}

@end
