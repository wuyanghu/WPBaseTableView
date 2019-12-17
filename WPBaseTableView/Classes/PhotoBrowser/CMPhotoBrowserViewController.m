//
//  CMPhotoBrowserViewController.m
//  AFNetworking
//
//  Created by yrl on 2017/11/29.
//

#import "CMPhotoBrowserViewController.h"
#import "CMPhotoBrowserScrollView.h"
#import "SDWebImageManager.h"
#import "CMCircleLoadingLayer.h"
#import "WPCommonMacros.h"

@interface CMPhotoCell : UICollectionViewCell<CMPhotoBrowserScrollViewDelegate>
@property (nonatomic, weak) id<CMPhotoCellDelegate> delegate;
@property (nonatomic, strong, readonly) CMPhotoBrowserScrollView *scrollView;
@property (nonatomic, strong) CMCircleLoadingLayer *loadingAnimationlayer;
@property (nonatomic) id<SDWebImageOperation> imageDownloadOperation;
@end

@implementation CMPhotoCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    //放大缩小容器
    _scrollView = [[CMPhotoBrowserScrollView alloc] init];
    _scrollView.frame = self.bounds;
    _scrollView.touchDelegate = self;
    [self.contentView addSubview:_scrollView];
}

- (void)configImage:(UIImage *)image smallImageUrl:(NSString *)smallImageUrl imageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage scale:(CGFloat)scale
{
    [self setPlaceholderImage:placeholderImage];
    [self.imageDownloadOperation cancel];
    //展示高清图
    if (image) {
        [self setImage:image scale:scale];
    } else if (imageUrl && imageUrl.length > 0) {
        [self showAnimation];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:imageUrl options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                [self setImage:image scale:scale];
            }
            [self hideAnimation];
        }];
    }
}

- (void)scrollView:(CMPhotoBrowserScrollView *)scrollView receiveSingleTouch:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidClick)]) {
        [self.delegate imageViewDidClick];
    }
}

- (void)setImage:(UIImage *)image scale:(CGFloat)scale
{
    if (!image) {
        return;
    }
    _scrollView.imageView.image = nil;
    _scrollView.imageView.image = image;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat x = 0;
    CGFloat width = screenW*scale;
    CGFloat height = width / image.size.width * image.size.height;
    CGFloat y = 0;
    if(height < screenH){
        y = (screenH - height) * 0.5;
    }
    _scrollView.imageView.frame = CGRectMake(x, y, width, height);
    _scrollView.imageView.contentMode = UIViewContentModeScaleToFill;
    //设置scrollView属性
    _scrollView.contentSize = CGSizeMake(width, height);
    _scrollView.bouncesZoom = YES;
}

- (void)setPlaceholderImage:(UIImage *)image {
    _scrollView.imageView.image = image;
    CGFloat imageViewHeight = 300;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat x = 0;
    CGFloat y = (screenH - imageViewHeight)/2;
    _scrollView.imageView.frame = CGRectMake(x, y, screenW, imageViewHeight);
    _scrollView.imageView.contentMode = UIViewContentModeCenter;
    _scrollView.bouncesZoom = NO;
}

- (CMCircleLoadingLayer *)loadingAnimationlayer {
    if (!_loadingAnimationlayer) {
        _loadingAnimationlayer = [[CMCircleLoadingLayer alloc]init];
        _loadingAnimationlayer.circleRadius = 10;
        _loadingAnimationlayer.loadingCircleBorderWidth = 2;
        _loadingAnimationlayer.loadingCircleColor = HEX_COLOR(0x3778FF);
        _loadingAnimationlayer.frame = CGRectMake(CGRectGetMidX(self.bounds)-12,CGRectGetMidY(self.frame)-12, 24, 24);
        [self.layer addSublayer:_loadingAnimationlayer];
        [_loadingAnimationlayer setUpAnimationLayer:0.9];
    }
    return _loadingAnimationlayer;
}

- (void)showAnimation {
    [self.loadingAnimationlayer startLoadingAnimation];
}

- (void)hideAnimation {
    [self.loadingAnimationlayer stopLoadingAnimation];
    [self.loadingAnimationlayer removeFromSuperlayer];
    self.loadingAnimationlayer = nil;
}
@end

@interface CMPhotoBrowserViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, CMPhotoCellDelegate>
{
    UICollectionView *_collectionView;
    UIView *_maskView;
}
@end

static NSString *const cellIdentifier = @"PhotoBrowserCell";
@implementation CMPhotoBrowserViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUp];
    //跳转到指定页
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition: UICollectionViewScrollPositionLeft animated:NO];
    _pageControl.currentPage = self.index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - private
- (void)setUp {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置分页器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 20)];
    _pageControl.currentPage = 1;
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[CMPhotoCell class] forCellWithReuseIdentifier:cellIdentifier];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [self.view insertSubview:_collectionView atIndex:0];
    
    _maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = self.maskViewAlpha;
    _maskView.userInteractionEnabled = NO;
    [self.view addSubview:_maskView];
}

- (void)setMaskViewAlpha:(CGFloat)maskViewAlpha {
    _maskViewAlpha = maskViewAlpha;
    _maskView.alpha = maskViewAlpha;
}
#pragma mark - UICollectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CMPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.imageArray.count > indexPath.row) {
        [cell configImage:self.imageArray[indexPath.row] smallImageUrl:nil imageUrl:nil placeholderImage:self.placeholderImage scale:1];
    } else if (self.imageURLs.count > indexPath.row) {
        NSString *smallImageUrl = nil;
        if (self.smallImageURLs.count > indexPath.row) {
            smallImageUrl = self.smallImageURLs[indexPath.row];
        }
        [cell configImage:nil smallImageUrl:smallImageUrl imageUrl:self.imageURLs[indexPath.row] placeholderImage:self.placeholderImage scale:1];
    }
    cell.delegate = self;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = self.imageArray.count;
    if (count == 0) {
        count = self.imageURLs.count;
    }
    _pageControl.numberOfPages = count;
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contenOffset = scrollView.contentOffset.x;
    //通过滚动算出在哪一页
    int page = contenOffset / scrollView.frame.size.width + ((int)contenOffset % (int)scrollView.frame.size.width == 0 ? 0 : 1);
    _pageControl.currentPage = page;
    self.index = page;
}

#pragma  mark - CMPhotoCellDelegate
- (void)imageViewDidClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CMPhotoBrowserAnimatorDismissDelegate
- (NSInteger)indexForDismissView {
    return self.index;
}

- (UIImageView *)imageViewForDismissView {
    CMPhotoCell *cell = (CMPhotoCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0]];
    UIImageView *cellImageView = cell.scrollView.imageView;
    cellImageView.clipsToBounds = YES;
    UIView *maskView = [[UIView alloc]initWithFrame:cellImageView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = self.maskViewAlpha;
    [cellImageView addSubview:maskView];
    return cellImageView;
}

@end

