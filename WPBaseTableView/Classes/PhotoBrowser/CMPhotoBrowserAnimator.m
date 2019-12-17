//
//  CMPhotoBrowserAnimator.m
//  AFNetworking
//
//  Created by yrl on 2017/11/29.
//

#import "CMPhotoBrowserAnimator.h"

@interface CMPhotoBrowserAnimator ()
@property (nonatomic, assign) BOOL isPresented;
@end
@implementation CMPhotoBrowserAnimator

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresented = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresented = NO;
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if(self.isPresented){
        [self animationForPresentView:transitionContext];
    } else{
        [self animationForDismissView:transitionContext];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

//自定义弹出动画
- (void)animationForPresentView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *presentView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    //将执行的View添加到containerView
    [transitionContext.containerView addSubview:presentView];
    
    //获取开始尺寸和结束尺寸
    UIImageView *imageView = nil;
    if (self.animationPresentDelegate && [self.animationPresentDelegate respondsToSelector:@selector(locImageView:)]) {
        imageView = [self.animationPresentDelegate locImageView:self.index];
    }
    CGRect startRect = CGRectZero;
    if (self.animationPresentDelegate && [self.animationPresentDelegate respondsToSelector:@selector(startRect:)]) {
        startRect = [self.animationPresentDelegate startRect:self.index];
    }
    CGRect endRect = CGRectZero;
    if (self.animationPresentDelegate && [self.animationPresentDelegate respondsToSelector:@selector(endRect:)]) {
        endRect = [self.animationPresentDelegate endRect:self.index];
    }
    if (!imageView || !self.animated) {
        [transitionContext completeTransition:YES];
    } else {
        [transitionContext.containerView addSubview:imageView];
        imageView.frame = startRect;
        presentView.alpha = 0;
        transitionContext.containerView.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            imageView.frame = endRect;
        }completion:^(BOOL finished) {
            presentView.alpha = 1.0;
            [imageView removeFromSuperview];
            transitionContext.containerView.backgroundColor = [UIColor clearColor];
            [transitionContext completeTransition:YES];
        }];
    }
}

//自定义消失动画
- (void)animationForDismissView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *dismissView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    [dismissView removeFromSuperview];
    
    UIImageView *imageView = nil;
    if (self.animationDismissDelegate && [self.animationDismissDelegate respondsToSelector:@selector(imageViewForDismissView)]) {
        imageView = [self.animationDismissDelegate imageViewForDismissView];
    }
    if (!imageView || !self.animated) {
        [transitionContext completeTransition:YES];
    } else {
        [transitionContext.containerView addSubview:imageView];
        NSInteger index = [self.animationDismissDelegate indexForDismissView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            imageView.frame = [self.animationPresentDelegate startRect:index];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}
@end



