//
//  CMPhotoBrowserScrollView.h
//  AFNetworking
//
//  Created by yrl on 2017/11/29.
//

#import <UIKit/UIKit.h>

@class CMPhotoBrowserScrollView;
@protocol CMPhotoBrowserScrollViewDelegate<NSObject>
- (void)scrollView:(CMPhotoBrowserScrollView *)scrollView receiveSingleTouch:(UITapGestureRecognizer *)tapGestureRecognizer;
@end

@interface CMPhotoBrowserScrollView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, assign, readwrite) CGFloat doubleTapScale;
@property (nonatomic, weak) id<CMPhotoBrowserScrollViewDelegate> touchDelegate;
@end
