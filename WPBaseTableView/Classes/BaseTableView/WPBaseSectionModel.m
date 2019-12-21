//
//  BaseSectionModel.m
//  WPBase
//
//  Created by wupeng on 2019/11/11.
//

#import "WPBaseSectionModel.h"
#import "WPCommonMacros.h"

@implementation WPBaseSectionsModel

- (NSMutableArray<WPBaseSectionModel *> *)contentArray{
    if (!_contentArray) {
        _contentArray = [[NSMutableArray alloc] init];
    }
    return _contentArray;
}

- (NSString *)getTitleWithSection:(NSInteger)section{
    if (section<self.contentArray.count) {
        WPBaseSectionModel * sectionModel = self.contentArray[section];
        return sectionModel.sectionTitle;
    }
    return nil;
}

- (WPBaseRowModel *)getContentModelWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>= self.contentArray.count) {
        return nil;
    }
    WPBaseSectionModel * sectionModel = self.contentArray[indexPath.section];
    if (indexPath.row >= sectionModel.rowArray.count) {
        return nil;
    }
    WPBaseRowModel * contentModel = sectionModel.rowArray[indexPath.row];
    return contentModel;
}

- (id)getExtensionWithIndexPath:(NSIndexPath *)indexPath{
    WPBaseRowModel * rowModel = [self getContentModelWithIndexPath:indexPath];
    return rowModel.extension;
}

- (void)removeWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= self.contentArray.count) {
        return;
    }
    WPBaseSectionModel * sectionModel = self.contentArray[indexPath.section];
    NSMutableArray * rowArray = [sectionModel rowArray];
    if (rowArray.count == 1) {
        [self.contentArray removeObjectAtIndex:indexPath.section];
    }else{
        [rowArray removeObjectAtIndex:indexPath.row];
    }
}

@end

@implementation WPBaseSectionModel

- (NSMutableArray<WPBaseRowModel *> *)rowArray{
    if (!_rowArray) {
        _rowArray = [[NSMutableArray alloc] init];
    }
    return _rowArray;
}

@end

@implementation WPBaseRowModel

- (WPBaseRowImageModel *)imageModel{
    if (!_imageModel) {
        _imageModel = [WPBaseRowImageModel new];
    }
    return _imageModel;
}

- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
    }
    return _params;
}

@end

@implementation WPBaseRowImageModel

- (CGSize)getImageSize{
    if (!_url) {
        return CGSizeZero;
    }
    return [self.class imageSizeWithWidth:_width height:_height];
}

+ (CGSize)imageSizeWithWidth:(NSString *)widthStr height:(NSString *)heightStr{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat imageMaxWidth = ScreenWidth-16*2;
    
    CGFloat width = [widthStr floatValue]/screenScale;
    CGFloat height = [heightStr floatValue]/screenScale;
    
    if (width<imageMaxWidth) {
        return CGSizeMake(width, height);
    }else{
        CGFloat scale = (imageMaxWidth)/width;
        return CGSizeMake(imageMaxWidth, height * scale);
    }
}

@end



