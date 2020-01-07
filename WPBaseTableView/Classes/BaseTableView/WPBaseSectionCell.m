//
//  BaseSectionCell.m
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import "WPBaseSectionCell.h"
#import "Masonry.h"
#import "WPCommonMacros.h"
#import "WPBaseSectionModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UITableView+FDTemplateLayoutCell.h"

@interface WPBaseSectionCell()

@property (nonatomic,assign) CGFloat titleHeight;//title高度
@property (nonatomic,assign) CGFloat contentHeight;//content高度
@property (nonatomic,assign) CGSize contentImageSize;//image宽度和高度

@end

@implementation WPBaseSectionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.fd_enforceFrameLayout = YES;
        _titleHeight = -1;
        _contentHeight = -1;
        _contentImageSize = CGSizeMake(-1, -1);
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentTextView];
        [self addSubview:self.contentImageView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self).offset(10);
        }];
        
        [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.height.mas_equalTo(0); make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentTextView.mas_bottom).offset(10);
            make.left.equalTo(self.contentTextView);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setRowModel:(WPBaseRowModel *)rowModel{
    if (_rowModel != rowModel) {
        self.titleHeight = rowModel.titleHeight;
        self.contentHeight = rowModel.descHeight;
        self.titleLabel.attributedText = rowModel.titleAttributedString;
        self.contentTextView.attributedText = rowModel.descAttributedString;
        
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:rowModel.imageModel.url]];
        self.contentImageSize = [rowModel.imageModel getImageSize];
        
    }
    _rowModel = rowModel;
    
}

- (void)browsePhotoTapGesture:(UITapGestureRecognizer *)tapGesture{
    if (_callBlock) {
        _callBlock();
    }
}

#pragma mark - setter

- (void)setTitleHeight:(CGFloat)titleHeight{
    if (_titleHeight != titleHeight) {
        CGFloat offset = titleHeight == 0?0:10;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(offset);
        }];
    }
    
    _titleHeight = titleHeight;
}

- (void)setContentHeight:(CGFloat)contentHeight{
    if (_contentHeight != contentHeight) {
        CGFloat offset = contentHeight == 0?0:10;
        [self.contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentHeight);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(offset);
        }];
    }
    
    _contentHeight = contentHeight;
}

- (void)setContentImageSize:(CGSize)contentImageSize{
    if (!CGSizeEqualToSize(_contentImageSize, contentImageSize)) {
        CGFloat offset = CGSizeEqualToSize(CGSizeZero, contentImageSize)?0:10;
        
        [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentTextView.mas_bottom).offset(offset);
            make.size.mas_equalTo(contentImageSize);
        }];
    }
    
    _contentImageSize = contentImageSize;
}

#pragma mark - 计算高度

- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat totalHeight = 10;
    if (_titleHeight>0) {
        totalHeight += _titleHeight+10;
    }
    
    if (_contentHeight>0) {
        totalHeight += _contentHeight+10;
    }
    
    if (_rowModel.imageModel.url) {
        totalHeight+= self.contentImageSize.height+10;
    }
    return CGSizeMake(size.width, totalHeight);
}

#pragma mark - getter

- (UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.userInteractionEnabled = YES;
        _contentImageView.layer.cornerRadius = 5.0;
        _contentImageView.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browsePhotoTapGesture:)];
        tapGesture.numberOfTouchesRequired = 1;
        [_contentImageView addGestureRecognizer:tapGesture];
    }
    return _contentImageView;
}

- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.editable = NO;
        _contentTextView.scrollEnabled = NO;
        _contentTextView.showsVerticalScrollIndicator = NO;
        _contentTextView.textContainer.lineFragmentPadding = 0;
        _contentTextView.textContainerInset = UIEdgeInsetsZero;
    }
    return _contentTextView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

@end




