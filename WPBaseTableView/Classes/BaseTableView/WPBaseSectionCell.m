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
        [self addSubview:self.contentLabel];
        [self addSubview:self.contentImageView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self).offset(10);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.left.equalTo(self.contentLabel);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setSectionContentModel:(WPBaseRowModel *)sectionContentModel{
    if (_sectionContentModel != sectionContentModel) {
        self.titleHeight = [self calculateLabelHeightWithChangeText:sectionContentModel.title originalHeight:_titleHeight label:self.titleLabel];
        
        self.contentHeight = [self calculateLabelHeightWithChangeText:sectionContentModel.desc originalHeight:_contentHeight label:self.contentLabel];
        
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:sectionContentModel.imageModel.url]];
        self.contentImageSize = [sectionContentModel.imageModel getImageSize];
        
    }
    _sectionContentModel = sectionContentModel;
    
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
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(offset);
        }];
    }
    
    _contentHeight = contentHeight;
}

- (void)setContentImageSize:(CGSize)contentImageSize{
    if (!CGSizeEqualToSize(_contentImageSize, contentImageSize)) {
        CGFloat offset = CGSizeEqualToSize(CGSizeZero, contentImageSize)?0:10;
        
        [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(offset);
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
    
    if (_sectionContentModel.imageModel.url) {
        totalHeight+= self.contentImageSize.height+10;
    }
    return CGSizeMake(size.width, totalHeight);
}

/*
 changeText:变化的text;originalHeight起始高度;label需要计算的label
 防止重复计算:
 1.字符长度为0时，返回0
 2.字符发生变化时，计算高度;字符未发生变化，保留原来高度
 */
- (CGFloat)calculateLabelHeightWithChangeText:(NSString *)text originalHeight:(CGFloat)height label:(UILabel *)label{
    CGFloat labelHeight = height;
    if (text.length == 0) {
        labelHeight = 0;
    }else{
        if (![label.text isEqualToString:text]) {
            labelHeight = [text boundingRectWithSize:CGSizeMake(ScreenWidth-16*2, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:label.font}
                                             context:nil].size.height;
        }
    }
    label.text = text;
    return labelHeight;
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

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
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




