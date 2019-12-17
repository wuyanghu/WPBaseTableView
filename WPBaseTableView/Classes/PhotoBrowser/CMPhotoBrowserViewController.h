//
//  CMPhotoBrowserViewController.h
//  AFNetworking
//
//  Created by yrl on 2017/11/29.
//

#import <UIKit/UIKit.h>
#import "CMPhotoBrowserAnimator.h"

@protocol CMPhotoCellDelegate <NSObject>
- (void)imageViewDidClick;
@end


@interface CMPhotoBrowserViewController : UIViewController<CMPhotoBrowserAnimatorDismissDelegate>
@property (nonatomic, copy) NSArray<UIImage *> *imageArray;
@property (nonatomic, copy) NSArray<NSString *> *imageURLs;
@property (nonatomic, copy) NSArray<NSString *> *smallImageURLs;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat maskViewAlpha;
@end

