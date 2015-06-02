//
//  firstPageViewController.m
//  StartUpDemo
//
//  Created by ChowShayne on 15/3/9.
//  Copyright (c) 2015年 ShayneChow. All rights reserved.
//

#import "firstPageViewController.h"
#import "UUChart.h"
#import "WMGaugeView.h"

@interface firstPageViewController () <UUChartDataSource>{
    UUChart *chartView;
    WMGaugeView *gaugeView;
}

@end

@implementation firstPageViewController

#pragma mark - ViewController-life
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Blog";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 70,
                            [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:UUChartLineStyle];
    [chartView showInView:self.view];
    
    if (gaugeView) {
        [gaugeView removeFromSuperview];
        gaugeView = nil;
    }
    
    gaugeView = [[WMGaugeView alloc] initWithFrame:CGRectMake(20, 230, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.width-40)];
    [self.view addSubview:gaugeView];
    gaugeView.backgroundColor = [UIColor clearColor];
    [self loadGaugeView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i+1];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart{
    return [self getXTitles:11];
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart{
    NSArray *ary = @[@"23",@"42",@"25",@"15",@"30",@"6",@"32",@"40",@"42",@"25",@"33"];

    return @[ary];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart{
    return CGRangeMake(50, 0);
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart{
//    if (path.row==2) {
//        return CGRangeMake(25, 75);
//    }
//    return CGRangeZero;
    return CGRangeMake(15, 35);
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index{
    return 4;
}

#pragma mark - WMGaugeView
- (void)loadGaugeView{
    gaugeView.maxValue = 100.0;
    gaugeView.scaleDivisions = 10;
    gaugeView.scaleSubdivisions = 5;
    gaugeView.scaleStartAngle = 30;
    gaugeView.scaleEndAngle = 280;
    gaugeView.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleFlat;
    gaugeView.showScaleShadow = YES;
    gaugeView.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    gaugeView.scalesubdivisionsAligment = WMGaugeViewSubdivisionsAlignmentCenter;
    gaugeView.scaleSubdivisionsWidth = 0.002;
    gaugeView.scaleSubdivisionsLength = 0.04;
    gaugeView.scaleDivisionsWidth = 0.007;
    gaugeView.scaleDivisionsLength = 0.07;
    gaugeView.needleStyle = WMGaugeViewNeedleStyleFlatThin;
    gaugeView.needleWidth = 0.012;
    gaugeView.needleHeight = 0.4;
    gaugeView.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain;
    gaugeView.needleScrewRadius = 0.05;
    
//    [gaugeView setValue:56.2 animated:YES duration:1.6 completion:^(BOOL finished) {
//        NSLog(@"gaugeView animation complete");
//    }];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(gaugeUpdateTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)gaugeUpdateTimer:(NSTimer *)timer{
    [gaugeView setValue:rand()%(int)gaugeView.maxValue animated:YES duration:1.6 completion:^(BOOL finished) {
        NSLog(@"gaugeView animation complete");
    }];
}

@end
