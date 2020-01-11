# WPBaseTableView

[![CI Status](https://img.shields.io/travis/823105162@qq.com/WPBaseTableView.svg?style=flat)](https://travis-ci.org/823105162@qq.com/WPBaseTableView)
[![Version](https://img.shields.io/cocoapods/v/WPBaseTableView.svg?style=flat)](https://cocoapods.org/pods/WPBaseTableView)
[![License](https://img.shields.io/cocoapods/l/WPBaseTableView.svg?style=flat)](https://cocoapods.org/pods/WPBaseTableView)
[![Platform](https://img.shields.io/cocoapods/p/WPBaseTableView.svg?style=flat)](https://cocoapods.org/pods/WPBaseTableView)

![列表.gif](https://upload-images.jianshu.io/upload_images/1387554-ab7582d0dea3d3da.gif?imageMogr2/auto-orient/strip)
背景:列表中有很多数据，每个数据都对应一个点击事件。
\- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;方法会非常的长，导入的头文件也非常多。想交换两个位置，会非常困难。

```
//
//  CoreAnimationViewController.m
//  DataStructureDemo
//
//  Created by wupeng on 2019/7/21.
//  Copyright © 2019 wupeng. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import "CALayerTreeViewController.h"
#import "CALayerContentsViewController.h"
#import "CAlayerContentsRectViewController.h"
#import "CALayerContentsCenterViewController.h"
#import "CustomDrawingViewController.h"
#import "AnchorPointViewController.h"
#import "ZPositionViewController.h"
#import "HitTestingViewController.h"
#import "ConrnerRadiusViewController.h"
#import "ShadowMaskToBoundsViewController.h"
#import "ShadowPathViewController.h"
#import "MaskViewController.h"
#import "KCAFilterViewController.h"
#import "GroupAlphaViewController.h"
#import "AffineTransformViewController.h"
#import "TransfromPerspectiveTypeViewController.h"
#import "DelayeringViewController.h"
#import "SolidObjectViewController.h"
#import "CAShapeLayerViewController.h"
#import "CMTextLayerViewController.h"
#import "CATransformLayerViewController.h"
#import "CATiledLayerViewController.h"
#import "CAEAGLLayerViewController.h"
#import "HermitViewController.h"
#import "ShowViewController.h"
#import "ClockAnimationPointViewController.h"
#import "TransitionViewController.h"
#import "StopViewController.h"
#import "LayerTimeViewController.h"
#import "LayerTimeOffsetSpeedViewController.h"
#import "LayerTimeHandViewController.h"
#import "BufferingViewController.h"
#import "TimerViewController.h"
#import "CADisplayLinkViewController.h"
#import "InstrumentsViewController.h"
#import "CoreGraphicsViewController.h"
#import "ImageIOViewController.h"
#import "ImageTiledLayerIOViewController.h"
#import "ImageLoadViewController.h"
#import "MixtureViewController.h"
#import "CoverageViewController.h"
#import "Drawing3DViewController.h"
#import "Drawing3DRecyclePoolViewController.h"

#import "SMCallTrace.h"

@interface CoreAnimationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSArray * titleSection;
@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Core Animation"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    NSInteger section = self.dataArray.count-1;
//    NSInteger row = [self.dataArray[section] count]-1;
//    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:section];
//    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleSection[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CoreAnimationStoryboard" bundle:nil];
    [SMCallTrace startWithMinCost:1000];
    id viewController;
    if (indexPath.section == 0) {
        CALayerTreeViewController * coreAnimation = [storyboard instantiateViewControllerWithIdentifier:@"CALayerTreeViewController"];
        viewController = coreAnimation;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            CALayerContentsViewController * contents = [storyboard instantiateViewControllerWithIdentifier:@"CALayerContentsViewController"];
            viewController = contents;
        }else if(indexPath.row == 1){
            CAlayerContentsRectViewController * contentsRect = [storyboard instantiateViewControllerWithIdentifier:@"CAlayerContentsRectViewController"];
            viewController = contentsRect;
        }else if (indexPath.row == 2){
            CALayerContentsCenterViewController * contentsCenter = [storyboard instantiateViewControllerWithIdentifier:@"CALayerContentsCenterViewController"];
            viewController = contentsCenter;
        }else{
            CustomDrawingViewController * customDrawing = [storyboard instantiateViewControllerWithIdentifier:@"CustomDrawingViewController"];
            viewController = customDrawing;
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            AnchorPointViewController * anchorPoint = [storyboard instantiateViewControllerWithIdentifier:@"AnchorPointViewController"];
            viewController = anchorPoint;
        }else if (indexPath.row == 1){
            ZPositionViewController * zPosition = [storyboard instantiateViewControllerWithIdentifier:@"ZPositionViewController"];
            viewController = zPosition;
        }else if (indexPath.row == 2){
            HitTestingViewController * hitTesting = [storyboard instantiateViewControllerWithIdentifier:@"HitTestingViewController"];
            viewController = hitTesting;
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            ConrnerRadiusViewController * cornerReadius = [storyboard instantiateViewControllerWithIdentifier:@"ConrnerRadiusViewController"];
            viewController = cornerReadius;
        }else if (indexPath.row == 1){
            ShadowMaskToBoundsViewController * shadowMaskToBounds = [storyboard instantiateViewControllerWithIdentifier:@"ShadowMaskToBoundsViewController"];
            viewController = shadowMaskToBounds;
        }else if (indexPath.row == 2){
            ShadowPathViewController * shadowPath = [storyboard instantiateViewControllerWithIdentifier:@"ShadowPathViewController"];
            viewController = shadowPath;
        }else if (indexPath.row == 3){
            MaskViewController * shadowPath = [storyboard instantiateViewControllerWithIdentifier:@"MaskViewController"];
            viewController = shadowPath;
        }else if (indexPath.row == 4){
            KCAFilterViewController * kCAFilter = [storyboard instantiateViewControllerWithIdentifier:@"KCAFilterViewController"];
            viewController = kCAFilter;
        }else if (indexPath.row == 5){
            GroupAlphaViewController * groupAlpha = [storyboard instantiateViewControllerWithIdentifier:@"GroupAlphaViewController"];
            viewController = groupAlpha;
        }
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            AffineTransformViewController * transform = [storyboard instantiateViewControllerWithIdentifier:@"AffineTransformViewController"];
            [transform setType:TransfromAffineType];
            viewController = transform;
        }else if (indexPath.row == 1){
            AffineTransformViewController * transform = [storyboard instantiateViewControllerWithIdentifier:@"AffineTransformViewController"];
            [transform setType:Transfrom3DType];
            viewController = transform;
        }else if (indexPath.row == 2){
            AffineTransformViewController * transform = [storyboard instantiateViewControllerWithIdentifier:@"AffineTransformViewController"];
            [transform setType:TransfromPerspectiveType];
            viewController = transform;
        }else if (indexPath.row == 3){
            TransfromPerspectiveTypeViewController * perspective = [storyboard instantiateViewControllerWithIdentifier:@"TransfromPerspectiveTypeViewController"];
            viewController = perspective;
        }else if (indexPath.row == 4){
            DelayeringViewController * delayering = [storyboard instantiateViewControllerWithIdentifier:@"DelayeringViewController"];
            [delayering setType:DelayeringZType];
            viewController = delayering;
        }else if (indexPath.row == 5){
            DelayeringViewController * delayering = [storyboard instantiateViewControllerWithIdentifier:@"DelayeringViewController"];
            [delayering setType:DelayeringYType];
            viewController = delayering;
        }else if (indexPath.row == 6){
            SolidObjectViewController * solidObject = [storyboard instantiateViewControllerWithIdentifier:@"SolidObjectViewController"];
            viewController = solidObject;
        }
    }else if (indexPath.section == 5){
        if (indexPath.row == 0) {
            CAShapeLayerViewController * shapeLayer = [CAShapeLayerViewController new];
            [shapeLayer setType:ShapeLayerMatchstickMenType];
            viewController = shapeLayer;
        }else if (indexPath.row == 1){
            CAShapeLayerViewController * shapeLayer = [CAShapeLayerViewController new];
            [shapeLayer setType:ShapeLayerPartCornerType];
            viewController = shapeLayer;
        }else if (indexPath.row == 2){
            CMTextLayerViewController * textLayer = [CMTextLayerViewController new];
            [textLayer setType:TextLayerStringType];
            viewController = textLayer;
        }else if (indexPath.row == 3){
            CMTextLayerViewController * textLayer = [CMTextLayerViewController new];
            [textLayer setType:TextLayerAttributedStringType];
            viewController = textLayer;
        }else if (indexPath.row == 4){
            CMTextLayerViewController * textLayer = [CMTextLayerViewController new];
            [textLayer setType:TextLayerLayerLabelType];
            viewController = textLayer;
        }else if (indexPath.row == 5){
            CATransformLayerViewController * transformLayer = [CATransformLayerViewController new];
            viewController = transformLayer;
        }else if (indexPath.row == 6){
            CATransformLayerViewController * transformLayer = [CATransformLayerViewController new];
            [transformLayer setType:CALayerGradientType];
            viewController = transformLayer;
        }else if (indexPath.row == 7){
            CATransformLayerViewController * transformLayer = [CATransformLayerViewController new];
            [transformLayer setType:CALayerManyGradientType];
            viewController = transformLayer;
        }else if (indexPath.row == 8){
            CATransformLayerViewController * transformLayer = [CATransformLayerViewController new];
            [transformLayer setType:CALayerReplicatorType];
            viewController = transformLayer;
        }else if (indexPath.row == 9){
            CATransformLayerViewController * transformLayer = [storyboard instantiateViewControllerWithIdentifier:@"CATransformLayerViewController"];
            [transformLayer setType:CALayerReplicatorReflectionType];
            viewController = transformLayer;
        }else if (indexPath.row == 10){
            //没有代码
        }else if (indexPath.row == 11){
            CATiledLayerViewController * tiledLayer = [storyboard instantiateViewControllerWithIdentifier:@"CATiledLayerViewController"];
            [tiledLayer setType:CASpecialTiledLayerType];
            viewController = tiledLayer;
        }else if (indexPath.row == 12){
            CATiledLayerViewController * tiledLayer = [storyboard instantiateViewControllerWithIdentifier:@"CATiledLayerViewController"];
            [tiledLayer setType:CASpecialEmitterLayerType];
            viewController = tiledLayer;
        }else if (indexPath.row == 13){
            CAEAGLLayerViewController * eagllayer = [storyboard instantiateViewControllerWithIdentifier:@"CAEAGLLayerViewController"];
            viewController = eagllayer;
        }
    }else if (indexPath.section == 6){
        HermitViewController * hermit = [storyboard instantiateViewControllerWithIdentifier:@"HermitViewController"];
        viewController = hermit;
        if (indexPath.row == 0) {
            [hermit setType:HermitDefaultType];
        }else if (indexPath.row == 1){
            [hermit setType:HermitTransactionType];
        }else if (indexPath.row == 2){
            [hermit setType:HermitBlockType];
        }else if (indexPath.row == 3){
            [hermit setType:HermitLayerBehaviorType];
        }else if (indexPath.row == 4){
            [hermit setType:HermitLayerBehaviorRealizeType];
        }else if (indexPath.row == 5){
            [hermit setType:HermitLayerBehaviorCustomType];
        }else if (indexPath.row == 6){
            [hermit setType:HermitPresentationLayerType];
        }
    }else if (indexPath.section == 7){
        if (indexPath.row == 0) {
            ShowViewController * show = [storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
            viewController = show;
        }else if (indexPath.row == 1){
            ClockAnimationPointViewController * clock = [storyboard instantiateViewControllerWithIdentifier:@"ClockAnimationPointViewController"];
            viewController = clock;
        }else if (indexPath.row == 2){
            ShowViewController * show = [storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
            [show setType:ShowKeyframeAnimationType];
            viewController = show;
        }else if (indexPath.row == 3){
            ShowViewController * show = [storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
            [show setType:ShowKeyframePathAnimationType];
            viewController = show;
        }else if (indexPath.row == 4){
            ShowViewController * show = [storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
            [show setType:ShowTransformType];
            viewController = show;
        }else if (indexPath.row == 5){
            ShowViewController * show = [storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
            [show setType:ShowTransformRotationType];
            viewController = show;
        }else if (indexPath.row == 6){
            ShowViewController * show = [storyboard instantiateViewControllerWithIdentifier:@"ShowViewController"];
            [show setType:ShowBasicAnimationType];
            viewController = show;
        }else if (indexPath.row == 7){
            TransitionViewController * transition = [storyboard instantiateViewControllerWithIdentifier:@"TransitionViewController"];
            viewController = transition;
        }else if (indexPath.row == 8){
            TransitionViewController * transition = [storyboard instantiateViewControllerWithIdentifier:@"TransitionViewController"];
            [transition setType:TransitionUIViewType];
            viewController = transition;
        }else if (indexPath.row == 9){
            TransitionViewController * transition = [storyboard instantiateViewControllerWithIdentifier:@"TransitionViewController"];
            [transition setType:TransitionCustomType];
            viewController = transition;
        }else if (indexPath.row == 10){
            StopViewController * stop = [storyboard instantiateViewControllerWithIdentifier:@"StopViewController"];
            viewController = stop;
        }
    }else if (indexPath.section == 8){
        if (indexPath.row == 0) {
            LayerTimeViewController * layerTime = [storyboard instantiateViewControllerWithIdentifier:@"LayerTimeViewController"];
            viewController = layerTime;
        }else if (indexPath.row == 1){
            LayerTimeViewController * layerTime = [storyboard instantiateViewControllerWithIdentifier:@"LayerTimeViewController"];
            [layerTime setType:LayerTimeAutoreversesType];
            viewController = layerTime;
        }else if (indexPath.row == 2){
            LayerTimeOffsetSpeedViewController * layerTime = [storyboard instantiateViewControllerWithIdentifier:@"LayerTimeOffsetSpeedViewController"];
            viewController = layerTime;
        }else if (indexPath.row == 3){
            LayerTimeHandViewController * layerTimeHand = [LayerTimeHandViewController new];
            viewController = layerTimeHand;
        }
    }else if (indexPath.section == 9){
        if (indexPath.row == 0) {
            BufferingViewController * buffering = [BufferingViewController new];
            viewController = buffering;
        }else if (indexPath.row == 1){
            BufferingViewController * buffering = [BufferingViewController new];
            [buffering setType:BufferingViewType];
            viewController = buffering;
        }else if (indexPath.row == 2){
            BufferingViewController * buffering = [BufferingViewController new];
            [buffering setType:BufferingTimingFunctionType];
            viewController = buffering;
        }else if (indexPath.row == 3){
            BufferingViewController * buffering = [BufferingViewController new];
            [buffering setType:BufferingBezierPathType];
            viewController = buffering;
        }else if (indexPath.row == 4){
            ClockAnimationPointViewController * clock = [storyboard instantiateViewControllerWithIdentifier:@"ClockAnimationPointViewController"];
            clock.isBuffer = YES;
            viewController = clock;
        }else if (indexPath.row == 5){
            BufferingViewController * buffering = [BufferingViewController new];
            [buffering setType:BufferingKeyTimesType];
            viewController = buffering;
        }else if (indexPath.row == 6){
            BufferingViewController * buffering = [BufferingViewController new];
            [buffering setType:BufferingInsertValuesType];
            viewController = buffering;
        }else if (indexPath.row == 7){
            BufferingViewController * buffering = [BufferingViewController new];
            [buffering setType:BufferingCustomType];
            viewController = buffering;
        }
    }else if (indexPath.section == 10){
        if (indexPath.row == 0) {
            TimerViewController * timer = [TimerViewController new];
            viewController = timer;
        }else if (indexPath.row == 1){
            CADisplayLinkViewController * displayLink = [CADisplayLinkViewController new];
            viewController = displayLink;
        }
    }else if (indexPath.section == 11){
        InstrumentsViewController * instruments = [[InstrumentsViewController alloc] initWithNibName:@"InstrumentsViewController" bundle:nil];
        viewController = instruments;
        if (indexPath.row == 0) {
            [instruments setType:InstrumentsInitType];
        }else if (indexPath.row == 1){
            [instruments setType:InstrumentsForbidShoadowType];
        }else if (indexPath.row == 2){
            [instruments setType:InstrumentsShouldRasterizeType];
        }
        
    }else if (indexPath.section == 12){
        CoreGraphicsViewController * coreGraphics = [CoreGraphicsViewController new];
        viewController = coreGraphics;
        if (indexPath.row == 0) {
            [coreGraphics setType:DrawingCoreGaphicsType];
        }else if (indexPath.row == 1){
            [coreGraphics setType:DrawingShapeLayerType];
        }else if (indexPath.row == 2){
            [coreGraphics setType:DrawingBlackBoardType];
        }else if (indexPath.row == 3){
            [coreGraphics setType:DrawingBlackBoardAddBrushStorkeType];
        }
    }else if (indexPath.section == 13){
        if (indexPath.row < 3) {
            ImageIOViewController * imageIO = [[ImageIOViewController alloc] initWithNibName:nil bundle:nil];
            viewController = imageIO;
            
            if (indexPath.row == 0) {
                [imageIO setType:ImageIODefaultType];
            }else if (indexPath.row == 1){
                [imageIO setType:ImageIOGCDType];
            }else if (indexPath.row == 2){
                [imageIO setType:ImageIODecompressionType];
            }
        }else if (indexPath.row == 3){
            ImageTiledLayerIOViewController * tiledLayerIO = [[ImageTiledLayerIOViewController alloc] initWithNibName:nil bundle:nil];
            viewController = tiledLayerIO;
        }else if (indexPath.row == 4){
            ImageIOViewController * imageIO = [[ImageIOViewController alloc] initWithNibName:nil bundle:nil];
            viewController = imageIO;
            [imageIO setType:ImageIOCacheType];
        }else if (indexPath.row == 5){
            ImageLoadViewController * imageLoad = [[ImageLoadViewController alloc] initWithNibName:nil bundle:nil];
            viewController = imageLoad;
        }else if (indexPath.row == 6){
            MixtureViewController * mixture = [[MixtureViewController alloc] initWithNibName:nil bundle:nil];
            viewController = mixture;
        }
    }else if (indexPath.section == 14){
        if (indexPath.row == 0) {
            CoverageViewController * coverage = [[CoverageViewController alloc] initWithNibName:nil bundle:nil];
            viewController = coverage;
            [coverage setType:CoverageShapeLayerType];
        }else if (indexPath.row == 1){
            CoverageViewController * coverage = [[CoverageViewController alloc] initWithNibName:nil bundle:nil];
            viewController = coverage;
            [coverage setType:CoverageCornerType];
        }else if (indexPath.row == 2){
            Drawing3DViewController * coverage = [[Drawing3DViewController alloc] initWithNibName:nil bundle:nil];
            viewController = coverage;
        }else if (indexPath.row == 3){
            Drawing3DViewController * coverage = [[Drawing3DViewController alloc] initWithNibName:nil bundle:nil];
            [coverage setType:Drawing3DResetType];
            viewController = coverage;
        }else if (indexPath.row == 4){
            Drawing3DRecyclePoolViewController * coverage = [[Drawing3DRecyclePoolViewController alloc] initWithNibName:nil bundle:nil];
            viewController = coverage;
        }
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    [SMCallTrace stop];
    [SMCallTrace save];
}

#pragma mark - getter
- (NSArray *)titleSection{
    if (!_titleSection) {
        _titleSection = @[@"1.图层树",@"2.寄宿图(LayerContents)",@"3.图层几何学",@"4.视觉效果",
                          @"5.变换",@"6.专用图层",@"7.隐式动画",@"8.显式动画",@"9.图层时间",@"10.缓冲",
                          @"11.基于定时器的动画",@"12.性能调优",@"13.高效绘图",@"14.图像IO",@"15.图层性能"];
    }
    return _titleSection;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @[@"使用图层"],
                       @[@"contents",@"contentsRect",@"contentsCenter",@"custom Drawing"],
                       @[@"anchorPoint",@"zPosition",@"hitTesting"],
                       
                       @[@"cornerRadius和masksToBounds、边框、阴影",
                         @"解决开启MaskToBounds时阴影被裁剪问题",
                         @"shadowPath",@"Mask",@"拉伸过滤",@"组透明"],
                       
                       @[@"CGAffineTransform 仿射变换",@"CATransform3D 3D转换",
                         @"CATransform3D m34 透视投影",@"CATransform3D m34 多个透视投影",
                         @"CATransform3D 绕Z轴做相反的旋转变换",
                         @"CATransform3D m34 绕Y轴做相反的旋转变换",
                         @"CATransform3D GLKVector3 固体对象"],
                       
                       @[@"CAShapeLayer 绘制一个火柴人",@"CAShapeLayer 部分圆角",
                         @"CATextLayer string",@"CATextLayer 富文本",
                         @"CATextLayer layerLabel",@"CATransformLayer 装配一个3D图层体系",
                         @"CAGradientLayer 基础渐变",@"CAGradientLayer 多重渐变",
                         @"CAReplicatorLayer 重复图层",@"CAReplicatorLayer 反射",
                         @"CAScrollLayer 显示大图层的一小部分",@"CATiledLayer 实现大图分解成小片然后载入",
                         @"CAEmitterLayer 实现烟、雨、雪效果",@"CAEAGLLayerViewController OpenGL",
                         @"AVPlayerLayer"],
                       
                       @[@"隐士动画",@"CATransaction",@"完成块",@"图层行为",
                         @"测试UIView的 actionForLayer:forKey: 实现",@"推进过渡",@"presentationLayer"],
                       
                       @[@"属性动画",@"使用KVC对动画打标签",@"CAKeyframeAnimation 应用一系列颜色的变化",
                         @"沿着一个贝塞尔曲线对图层做动画",@"虚拟属性",@"虚拟属性rotation",
                         @"CAAnimationGroup 动画组",@"过渡",@"过渡 UIView",@"自定义过渡效果",
                         @"在动画过程中取消动画"],
                       
                       @[@"测试 duration 和 repeatCount",@"摆动门的动画",
                         @"测试 timeOffset 和 speed 属性",@"手动动画 timeOffset"],
                       
                       @[@"缓冲函数的简单测试",@"使用UIKit动画的缓冲测试工程",@"CAMediaTimingFunction",
                         @"使用 UIBezierPath 绘制 CAMediaTimingFunction",@"添加了自定义缓冲函数的时钟程序",
                         @"使用关键帧实现反弹球的动画",@"使用插入的值创建一个关键帧动画",@"用关键帧实现自定义的缓冲函数"],
                       
                       @[@"使用 NSTimer 实现弹性球动画",@"通过测量没帧持续的时间来使得动画更加平滑",
                         @"使用物理学来对掉落的木箱建模",@"物理模式，暂时没有"],
                       
                       @[@"Instruments 最初版本",@"Instruments 禁止阴影",
                         @"Instruments shouldRasterize提高性能"],
                       
                       @[@"用Core Graphics实现一个简单的绘图应用",@"用 CAShapeLayer 重新实现绘图应用",
                         @"简单的类似黑板的应用",@"用 -setNeedsDisplayInRect: 来减少不必要的绘制"],
                       
                       @[@"使用 UICollectionView 实现的图片传送器",@"使用GCD加载传送图片",
                         @"强制图片解压显示",@"使用 CATiledLayer 的图片传送器",@"添加缓存",
                         @"文件格式",@"从PNG遮罩和JPEG创建的混合图片"],
                       
                       @[@"用 CAShapeLayer 画一个圆角矩形",@"用可伸缩图片绘制圆角矩形",@"滚动的3D图层矩阵",
                         @"排除可视区域之外的图层",@"通过回收减少不必要的分配"]
                       ];
    }
    return _dataArray;
}

@end

```

直接使用tableView,缺点非常明显，viewController类非常臃肿，而且多个的列表，需要重复写tableView的方法。我想到使用json来配置tableView的数据源和跳转的类及方法参数。

封装之后的viewController没有一行代码,继承自BaseSectionTableViewViewController加一个json配置文件。这样我想增加一个列表或交换列表的顺序也非常简单。
```
#import <UIKit/UIKit.h>
#import "BaseSectionTableViewViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoreAnimationViewController : BaseSectionTableViewViewController

@end

NS_ASSUME_NONNULL_END

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"动画"];
}

@end
```
![viewController实现.png](https://upload-images.jianshu.io/upload_images/1387554-3546dd4b3b93825c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

BaseSectionTableViewViewController的实现:
1.通过类名读取对应的配置文件，我把解析的方法放在NSObject(Json)中:
```
- (id)readConfigJsonWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    if (!path) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    id dataId = [NSJSONSerialization JSONObjectWithData:data                   options:NSJSONReadingMutableContainers error:nil];
    return dataId;
}
```
2.解析配置文件信息
2.1 json配置介绍
title是用于展示titleForHeaderInSection的NSString，是一个数组。
content节点可配置title、classname、storyboardname、method、params。
```
{
    "title":[
        "其他",
        "小知识点总结"
    ],
    "content":[
        [
            {
                "title":"UIScrollView嵌套tableView",
            },
            {
                "title":"点赞动画",
            },
            {
                "title":"排行榜C化",
                "classname":"ClassifyViewController",
                "storyboardname":"CMClassify"
            },
            {
                "title":"壹句",
                "classname":"CMMiguOneSentenceViewController"
            },
            {
                "title":"图片裁剪",
                "classname":"ClipImageViewController"
            },
            {
                "title":"轮播图ScrollView",
                "classname":"SlideshowScrollViewController"
            },
            {
                "title":"彩虹",
                "classname":"RainbowViewController"
            },
            {
                "title":"NSString 为什么用copy",
                "classname":"CopyNString",
                "method":"main"
            },
            {
                "title":"关联对象弹窗",
                "classname":"AssociatedAlertView",
                "method":"askUserAQuestion"
            },
            {
                "title":"虚拟定位",
                "classname":"SelectLocationViewController"
            },
            {
                "title":"微信步数模拟",
                "classname":"WeChatStepSimulation",
                "method":"main"
            },
            {
                "title":"动画按顺序执行",
                "classname":"SequenceAnimationViewController"
            },
            {
                "title":"UIWebView",
                "classname":"UIWebViewViewController"
            },
            {
                "title":"WKWebView",
                "classname":"WKWebViewViewController"
            },
            {
                "title":"xib引用xib使用",
                "classname":"UseXibViewController"
            },
            {
                "title":"UILable内边距设置",
                "classname":"LabelEdgeInsetViewController"
            },
            {
                "title":"网络请求",
                "classname":"NetworkViewController"
            }
        ],
        [
            {
                "title":"多线程",
                "classname":"ThreadProblemViewController"
            },
            {
                "title":"内存泄露",
                "classname":"MemoryLeakViewController"
            },
            {
                "title":"RunLoop",
                "classname":"RunLoopViewController"
            },
            {
                "title":"RunTime",
                "classname":"RuntimeViewController"
            },
            {
                "title":"Category",
                "classname":"CategoryViewController"
            },
        ]
    ]
}
```

2.2获取title
```
- (NSString *)getTitleFromSectionTableView:(NSIndexPath *)indexPath{
    id content = self.contentArray[indexPath.section][indexPath.row];
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSDictionary * contentDict = (NSDictionary *)content;
        return contentDict[BASETABLEVIEW_CONTENT_TITLE];
    }else if([content isKindOfClass:[NSString class]]){
        return content;
    }
    
    return nil;
}
```
title分两种，如果是NSString直接展示，如果是NSDictonary,则取出其中的title。

2.3 处理点击事件
2.3.1考虑到UIViewController可能是xib、纯代码、或storyBoard创建。如果是UIViewController类直接push。
```
id content = self.contentArray[indexPath.section][indexPath.row];
    
    NSString * className;
    NSString * storyBoardName;
    if ([content isKindOfClass:[NSString class]]) {
        className = (NSString *)content;
    }else{
        NSDictionary * contentDict = (NSDictionary *)content;
        className = contentDict[BASETABLEVIEW_CONTENT_CLASSNAME];
        storyBoardName = contentDict[BASETABLEVIEW_CONTENT_STORYBOARDNAME];
        
        _params = contentDict[BASETABLEVIEW_CONTENT_PARAMS];
        _method = contentDict[BASETABLEVIEW_CONTENT_METHOD];
    }
    id objClass = nil;
    if (storyBoardName && storyBoardName.length>0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
        objClass = [storyboard instantiateViewControllerWithIdentifier:className];
    }else{
        objClass = [NSClassFromString(className) new];
    }
    if (!objClass) {//对象是空直接return
        return;
    }
```
2.3.2 params解析
NSObject (AddParams)来给NSObject动态添加参数
```
- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, @"params", params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, @"params");
}
```
2.3.3 method解析
```
 SEL selector = NSSelectorFromString(_method);
        if ([objClass respondsToSelector:selector]) {
            [objClass performSelector:selector withObject:self.params];
        }
```

3.使用:
3.1[可通过pod方式集成](https://github.com/wuyanghu/WPBaseTableView.git)
3.2新建viewController继承BaseSectionTableViewViewController,并新建一个json文件。
```
{
                "title":"标题",
                "classname":"ViewController",
                "storyboardname":"storyboard名称，可省略",
                "params":{
                    "type":"0"
                }
            }
```
3.3 配置
3.3.1 仅展示title
```
{
                "title":"点赞动画",
            }
```
3.3.2 纯代码创建
```
{
                "title":"图片裁剪",
                "classname":"ClipImageViewController"
            }
```
3.3.3 storyboard创建
```
{
                "title":"排行榜C化",
                "classname":"ClassifyViewController",
                "storyboardname":"CMClassify"
            }
```
3.3.4 创建NSObject并运行指定方法
```
{
                "title":"NSString 为什么用copy",
                "classname":"CopyNString",
                "method":"main"
            }
```
3.3.5 创建类并带有参数
```
{
                "title":"CGAffineTransform 仿射变换",
                "classname":"AffineTransformViewController",
                "storyboardname":"CoreAnimationStoryboard",
                "params":{
                    "type":"0"
                }
            }
```

总结:
这种方式使得viewController类非常整洁，新增一个列表非常方便。不用关心跳转了，由BaseTableViewViewController为我们做好。
具体使用可参考 [demo](https://github.com/wuyanghu/WPNote)

## Requirements

## Installation

WPBaseTableView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WPBaseTableView'
```

## Author

823105162@qq.com, 823105162@qq.com

## License

WPBaseTableView is available under the MIT license. See the LICENSE file for more info.
