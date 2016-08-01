//
//  ViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/19.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkManager.h"
#import "UIButton+HYBHelperBlockKit.h"
#import "TTSettingViewController.h"
#import "AKPickerView.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"

@interface HomeViewController ()<AKPickerViewDataSource, AKPickerViewDelegate,CCDraggableContainerDataSource,
CCDraggableContainerDelegate>
@property (nonatomic, strong) AKPickerView *pickerView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, assign) NSInteger lastSelectItem;
@property (nonatomic, assign) BOOL isAutoScroll;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //配置网络
//    [NetworkManager configerNetworking];
//    
//    Api1 *api1 = [[Api1 alloc] init];
//    api1.cacheInvalidTime = 60;//需要缓存
//    api1.requestArgument = @{@"lat":@"34.345",@"lng":@"113.678"};
//    LCRequestAccessory *accessary = [[LCRequestAccessory alloc] initWithShowVC:self];
//    [api1 addAccessory:accessary];
//    [api1 startWithBlockSuccess:^(__kindof LCBaseRequest *request) {
//        NSLog(@"%@",request.responseJSONObject);
//    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
//        NSLog(@"%@",error.description);
//    }];
        
    //
//    UIButton *btn = [UIButton hyb_buttonWithTitle:@"TEST" superView:self.view constraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.centerY.mas_equalTo(self.view.mas_centerY);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(100);
//    } touchUp:^(UIButton *sender) {
//        TTSettingViewController *settingVC = [[TTSettingViewController alloc] init];
//        [self.navigationController pushViewController:settingVC animated:YES];
//    }];
//    btn.backgroundColor = [UIColor redColor];
    
   
    
    
    self.titles = @[@"所有项目",@"工作牛",@"易会",@"MPP",@"营配"];
    
    self.dataSources = [NSMutableArray array];
    
    for (int i = 0; i < self.titles.count; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"image_%d.jpg",i + 1],
                               @"title" : [NSString stringWithFormat:@"Page %d",i + 1]};
        [self.dataSources addObject:dict];
    }
    [self.view addSubview:self.container];
    
    [self.view addSubview:self.pickerView];
    
    [self layoutSubviews];
}

-(void)layoutSubviews{
    WeakSelf;
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wself.view);
        make.top.equalTo(wself.view);
        make.bottom.equalTo(wself.view);
        make.width.mas_equalTo(Screen_Width * 0.2);
    }];
    
//    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(wself.view).offset(-20.0);
//        make.centerY.equalTo(wself.view);
//        make.height.equalTo(@400);
//        make.width.equalTo(@280);
//    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AKPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return [self.titles count];
}

/*
 * AKPickerView now support images!
 *
 * Please comment '-pickerView:titleForItem:' entirely
 * and uncomment '-pickerView:imageForItem:' to see how it works.
 *
 */

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return self.titles[item];
}

/*
 - (UIImage *)pickerView:(AKPickerView *)pickerView imageForItem:(NSInteger)item
 {
	return [UIImage imageNamed:self.titles[item]];
 }
 */

#pragma mark - AKPickerViewDelegate

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    NSLog(@"%@", self.titles[item]);
    if (self.lastSelectItem == item) {
        return;
    }
    
    if (self.lastSelectItem < item) {
        [self.container removeFormDirection:CCDraggableDirectionLeft];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.container reloadDataWithLoadIndex:item animated:NO];
        });
    } else
    {
        [self.container reloadDataWithLoadIndex:item animated:YES];
    }

    
    self.lastSelectItem = item;
    
//    TTSettingViewController *settingVC = [[TTSettingViewController alloc] init];
//    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - getter and setter
- (AKPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[AKPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;

        _pickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        _pickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _pickerView.highlightedBackGroundColor = [UIColor clearColor];
        _pickerView.interitemSpacing = 20.0;
        _pickerView.fisheyeFactor = 0.001;
        _pickerView.pickerViewStyle = AKPickerViewStyleFlat;
        _pickerView.maskDisabled = false;
        [_pickerView reloadData];
    }
    return _pickerView;
}

- (CCDraggableContainer *)container {
    if (!_container) {
//        _container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, (Screen_Height*0.5)/2, Screen_Width * 0.60, Screen_Height*0.5) style:CCDraggableStyleUpOverlay];
        _container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 0, Screen_Width * 0.60, Screen_Height) style:CCDraggableStyleUpOverlay];
        _container.delegate = self;
        _container.dataSource = self;
        [_container reloadData];
    }
    return _container;
}

//- (NSMutableArray *)dataSources {
//    if (!_dataSources) {
//        _dataSources = [NSMutableArray array];
//        
//        for (int i = 0; i < 9; i++) {
//            NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"image_%d.jpg",i + 1],
//                                   @"title" : [NSString stringWithFormat:@"Page %d",i + 1]};
//            [_dataSources addObject:dict];
//        }
//    }
//    return _dataSources;
//}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    [self.pickerView scrollToItem:draggableContainer.loadedIndex % _dataSources.count animated:YES];
    
//    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
//        self.disLikeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
//        self.likeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
        TTSettingViewController *settingVC = [[TTSettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
    [draggableContainer reloadData];
}

@end
