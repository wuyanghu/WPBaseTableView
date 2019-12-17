//
//  CMPhotoBrowserScrollView.m
//  AFNetworking
//
//  Created by yrl on 2017/11/29.
//

#import "CMPhotoBrowserScrollView.h"

@implementation CMPhotoBrowserScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor blackColor];
    //放大缩小容器
    [self addSubview:self.imageView];
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 3.0;
    self.delegate = self;
    self.doubleTapScale = 2.0f;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [self addGestureRecognizer:singleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

#pragma mark - Public
- (void)setDoubleTapScale:(CGFloat)doubleTapScale {
    _doubleTapScale = MAX(doubleTapScale, 1.0f);
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGRect frame = _imageView.frame;
    frame.origin.y = (self.frame.size.height - _imageView.frame.size.height) > 0 ? (self.frame.size.height - _imageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.frame.size.width - _imageView.frame.size.width) > 0 ? (self.frame.size.width - _imageView.frame.size.width) * 0.5 : 0;
    _imageView.frame = frame;
}
#pragma mark - action
- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer{
    CGPoint center = [tapGestureRecognizer locationInView:self];
    //双击放大图片
    CGFloat scale = 0.0f;
    if (self.zoomScale > 1) {
        scale = 1.0f;
    } else {
        scale = self.doubleTapScale;
    }
    [self zoomRectForScale:scale withCenter:center];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer{
    if(self.touchDelegate && [self.touchDelegate respondsToSelector:@selector(scrollView:receiveSingleTouch:)]){
       [self.touchDelegate scrollView:self receiveSingleTouch:tapGestureRecognizer];
    }
}

#pragma mark - private
- (void)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  =self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
    [self zoomToRect:zoomRect animated:YES];
    [self setZoomScale:scale animated:YES];
}

@end
