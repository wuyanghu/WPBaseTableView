//
//  CMPhotoBrowserAnimator.h
//  AFNetworking
//
//  Created by yrl on 2017/11/29.
//

#import <Foundation/Foundation.h>

/**
 图片开始浏览协议
 */
@protocol CMPhotoBrowserAnimatorPresentDelegate <NSObject>
/**
 获取图片浏览前的位置
 
 @param index 图片的下标
 @return 图片相对于window的位置
 */
- (CGRect)startRect:(NSInteger)index;

/**
 获取图片浏览中的位置
 
 @param index 图片的下标
 @return 图片在图片查看控制器中位置
 */
- (CGRect)endRect:(NSInteger)index;

/**
 获取当前要浏览的图片
 
 @param index 图片的下标
 @return 当前要浏览的图片
 */
- (UIImageView *)locImageView:(NSInteger)index;
@end

/**
 图片结束浏览协议
 */
@protocol CMPhotoBrowserAnimatorDismissDelegate <NSObject>

/**
 获取当前浏览的图片的下标
 
 @return 当前浏览图片的下标
 */
- (NSInteger)indexForDismissView;

/**
 获取当前浏览的图片
 
 @return 当前浏览的图片
 */
- (UIImageView *)imageViewForDismissView;
@end

@interface CMPhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) id<CMPhotoBrowserAnimatorPresentDelegate> animationPresentDelegate;

@property (nonatomic, weak) id<CMPhotoBrowserAnimatorDismissDelegate> animationDismissDelegate;
/**当前所要查看的图片*/
@property (nonatomic, assign) NSInteger index;
@property (nonatomic) BOOL animated;
@end

