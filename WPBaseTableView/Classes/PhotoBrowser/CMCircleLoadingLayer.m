//
//  CMCircleLoadingLayer.m
//  CMRead
//
//  Created by Ally on 2019/6/28.
//

#import "CMCircleLoadingLayer.h"

static const CGFloat loadingAnamtionDuration = 1.0f;
static const CGFloat loadingCircleBorderWidthDefault = 1.5f;

@implementation CMCircleLoadingLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.circleRadius = 10;
    self.loadingCircleColor = [UIColor blueColor];
    self.loadingCircleBorderWidth = 2;
}

- (void)setUpAnimationLayer:(CGFloat)percent {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.circleRadius startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    self.path = path.CGPath;
    self.fillColor = [UIColor clearColor].CGColor;
    self.lineWidth = self.loadingCircleBorderWidth ?: loadingCircleBorderWidthDefault;
    self.strokeColor = self.loadingCircleColor.CGColor ?: [UIColor redColor].CGColor;
    self.lineCap = kCALineCapRound;
    self.strokeEnd = percent;
}

- (void)startLoadingAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = loadingAnamtionDuration;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.toValue = @(M_PI * 2.0);
    [self addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoadingAnimation {
    [self removeAllAnimations];
}
@end
