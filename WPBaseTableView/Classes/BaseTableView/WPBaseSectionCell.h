//
//  BaseSectionCell.h
//  WPBase
//
//  Created by wupeng on 2019/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WPBaseRowModel;

typedef void(^WPBaseSectionCellBlock)(void);

@interface WPBaseSectionCell : UITableViewCell
@property (nonatomic,strong) UILabel * titleLabel;
@property (strong, nonatomic) UITextView * contentTextView;
@property (nonatomic,strong) UIImageView * contentImageView;

@property (nonatomic,strong) WPBaseRowModel * rowModel;
@property (nonatomic,copy) WPBaseSectionCellBlock callBlock;

@end

NS_ASSUME_NONNULL_END

