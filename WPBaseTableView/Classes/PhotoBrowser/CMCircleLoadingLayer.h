//
//  CMCircleLoadingLayer.h
//  CMRead
//
//  Created by Ally on 2019/6/28.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMCircleLoadingLayer : CAShapeLayer
@property (nonatomic, strong) UIColor *loadingCircleColor;
@property (nonatomic, assign) CGFloat loadingCircleBorderWidth;
@property (nonatomic, assign) CGFloat circleRadius;

- (void)setUpAnimationLayer:(CGFloat)percent;
- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;
@end

NS_ASSUME_NONNULL_END
