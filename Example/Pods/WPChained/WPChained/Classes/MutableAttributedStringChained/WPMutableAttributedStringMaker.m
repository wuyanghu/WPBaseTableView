//
//  MutableAttributedStringMaker.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/2.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMutableAttributedStringMaker.h"

@interface WPMutableAttributedStringMaker()
@property (nonatomic,weak) NSMutableAttributedString * string;
@end

@implementation WPMutableAttributedStringMaker

- (id)initWithMutableAttributedString:(NSMutableAttributedString *)string{
    self = [super init];
    if (self) {
        _string = string;
    }
    return self;
}

//设置字体颜色
- (void)textColor:(UIColor *)color range:(NSRange)range{
    NSAssert(color, @"color不能为空");
    NSAssert(range.location+range.length<self.string.length, @"color不能为空");
    [self.string addAttribute:NSForegroundColorAttributeName value:color range:range];
}
//设置背景颜色
- (void)textBgColor:(UIColor *)color range:(NSRange)range{
    NSAssert(color, @"color不能为空");
    [self.string addAttribute:NSBackgroundColorAttributeName value:color range:range];
}
//设置字号
- (void)textFont:(UIFont *)font range:(NSRange)range{
    NSAssert(font, @"font不能为空");
    [self.string addAttribute:NSFontAttributeName value:font range:range];
}

//插入图片
- (void)insertImageWithImageName:(NSString *)imageName bounds:(CGRect)bounds index:(NSUInteger)index{
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = [UIImage imageNamed:imageName];
    attchImage.bounds = bounds;
    
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    
    //若不添加下面这句话,默认会把图片排在文字末尾
    [self.string insertAttributedString:stringImage atIndex:index];
}

//设置段落属性
- (void)paragraphStyle:(NSMutableParagraphStyle *)style range:(NSRange)range{
    [self.string addAttribute:NSParagraphStyleAttributeName value:style range:range];
}
//字间距
- (void)kernWordSpace:(CGFloat)space range:(NSRange)range{
    [self.string addAttribute:NSKernAttributeName value:@(space) range:range];//字间距
}
//单双删除线:1-7单线 依次加粗;9-15双线 依次加粗
//删除线颜色
- (void)strikethrough:(CGFloat)space color:(UIColor *)color range:(NSRange)range{
    [self.string addAttribute:NSStrikethroughStyleAttributeName value:@(space) range:range];
    [self.string addAttribute:NSStrikethroughColorAttributeName value:color range:range];
}

//下划线及颜色
- (void)underlineStyle:(NSUnderlineStyle)underlineStyle color:(UIColor *)color range:(NSRange)range{
    [self.string addAttribute:NSUnderlineStyleAttributeName value:@(underlineStyle) range:range];
    [self.string addAttribute:NSUnderlineColorAttributeName value:color range:range];
}

/*
 文本描边颜色
 width:正值镂空 负值描边
 */
- (void)strokeColorWithWidth:(CGFloat)width color:(UIColor *)color range:(NSRange)range{
    [self.string addAttribute:NSStrokeWidthAttributeName value:@(width) range:range];
    [self.string addAttribute:NSStrokeColorAttributeName value:color range:range];
}
//设置阴影
//offsetSize:阴影偏移量;color:阴影颜色;blurRadius:模糊度
- (void)shadowWithOffset:(CGSize)offsetSize color:(UIColor *)color blurRadius:(CGFloat)blurRadius range:(NSRange)range{
    NSShadow * shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = offsetSize;
    shadow.shadowColor = color;
    shadow.shadowBlurRadius = blurRadius;
    
    [self.string addAttribute:NSShadowAttributeName value:shadow range:range];
}
//添加链接
- (void)linkWithUrl:(NSString *)urlString range:(NSRange)range{
    if (urlString) {
        [self.string addAttribute:NSLinkAttributeName value:urlString range:range];
    }else{
        NSLog(@"urlString不能为空");
    }
}
/*
 文字基线偏移
 offset:负数向下偏移;正数向上偏移
 */
- (void)baselineOffsetWithOffset:(CGFloat)offset range:(NSRange)range{
    [self.string addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:range];
}
//文字倾斜度
- (void)obliquenessWithOffset:(CGFloat)offset range:(NSRange)range{
    [self.string addAttribute:NSObliquenessAttributeName value:@(offset) range:range];
}
//字体横向拉伸:正值拉伸，负值压缩
- (void)expansionWithOffset:(CGFloat)offset range:(NSRange)range{
    [self.string addAttribute:NSExpansionAttributeName value:@(offset) range:range];
}


#pragma mark - 统一设置

- (NSDictionary *)textColor:(UIColor *)color{
    NSAssert(color, @"color不能为空");
    return @{NSForegroundColorAttributeName:color};
}

- (NSDictionary *)textBgColor:(UIColor *)color{
    NSAssert(color, @"color不能为空");
    return @{NSBackgroundColorAttributeName:color};
}

- (NSDictionary *)textFont:(UIFont *)font{
    NSAssert(font, @"font不能为空");
    return @{NSFontAttributeName:font};
}

#pragma mark - 链式
//设置字体颜色
- (WPChainedAttributedBlock)textColor{
    WPChainedAttributedBlock block = ^WPMutableAttributedStringMaker *(UIColor * color,NSRange range){
        [self.string addAttribute:NSForegroundColorAttributeName value:color range:range];
        return self;
    };
    return block;
    
}
//设置背景颜色
- (WPChainedAttributedBlock)textBgColor{
    WPChainedAttributedBlock block = ^WPMutableAttributedStringMaker *(UIColor * color,NSRange range){
        [self.string addAttribute:NSBackgroundColorAttributeName value:color range:range];
        return self;
    };
    return block;
}
//设置字号
- (WPMutableAttributedStringMaker *(^) (CGFloat,NSRange))textFont{
    return ^WPMutableAttributedStringMaker *(CGFloat fontSize,NSRange range){
        [self.string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
        return self;
    };;
}
//插入图片
- (WPChainedAttributedImageBlock)insertImage{
    WPChainedAttributedImageBlock imageBlock = ^WPMutableAttributedStringMaker * (NSString * imageName ,CGRect bounds,NSInteger index){
        [self insertImageWithImageName:imageName bounds:bounds index:index];
        return self;
    };
    return imageBlock;
}

//设置段落属性
- (WPChainedAttributedParagraphBlock)paragraphStyle{
    WPChainedAttributedParagraphBlock block = ^WPMutableAttributedStringMaker *(NSMutableParagraphStyle * style,NSRange range){
        [self paragraphStyle:style range:range];
        return self;
    };
    return block;
}
//字间距
- (WPChainedAttributedFloatBlock)kernWordSpace{
    WPChainedAttributedFloatBlock block = ^WPMutableAttributedStringMaker *(CGFloat space,NSRange range){
        [self kernWordSpace:space range:range];
        return self;
    };
    return block;
}
//单双删除线:1-7单线 依次加粗;9-15双线 依次加粗
//删除线颜色
- (WPChainedAttributedFloatColorBlock)strikethrough{
    WPChainedAttributedFloatColorBlock block = ^WPMutableAttributedStringMaker *(CGFloat space,UIColor * color,NSRange range){
        [self strikethrough:space color:color range:range];
        return self;
    };
    return block;
}

//下划线及颜色
- (WPChainedAttributedUnderlineStyleBlock)underlineStyle{
    WPChainedAttributedUnderlineStyleBlock block = ^WPMutableAttributedStringMaker *(NSUnderlineStyle style,UIColor * color,NSRange range){
        [self underlineStyle:style color:color range:range];
        return self;
    };
    return block;
}

/*
 文本描边颜色
 width:正值镂空 负值描边
 */
- (WPChainedAttributedFloatColorBlock)strokeColorWithWidth{
    WPChainedAttributedFloatColorBlock block = ^WPMutableAttributedStringMaker *(CGFloat offset,UIColor * color,NSRange range){
        [self strokeColorWithWidth:offset color:color range:range];
        return self;
    };
    return block;
}
//设置阴影
//offsetSize:阴影偏移量;color:阴影颜色;blurRadius:模糊度
- (WPChainedAttributedShadowBlock)shadowWithOffset{
    WPChainedAttributedShadowBlock block = ^WPMutableAttributedStringMaker *(CGSize offsetSize,UIColor * color,CGFloat blurRadius,NSRange range){
        [self shadowWithOffset:offsetSize color:color blurRadius:blurRadius range:range];
        return self;
    };
    return block;
}
//添加链接
- (WPMutableAttributedStringMaker *(^)(NSString * url ,NSRange range))linkWithUrl{
    return ^ WPMutableAttributedStringMaker *(NSString * urlString,NSRange range){
        [self linkWithUrl:urlString range:range];
        return self;
    };
}
/*
 文字基线偏移
 offset:负数向下偏移;正数向上偏移
 */
- (WPChainedAttributedFloatBlock)baselineOffset{
    WPChainedAttributedFloatBlock block = ^WPMutableAttributedStringMaker *(CGFloat offset,NSRange range){
        [self baselineOffsetWithOffset:offset range:range];
        return self;
    };
    return block;
}
//文字倾斜度
- (WPChainedAttributedFloatBlock)obliqueness{
    WPChainedAttributedFloatBlock block = ^WPMutableAttributedStringMaker *(CGFloat offset,NSRange range){
        [self obliquenessWithOffset:offset range:range];
        return self;
    };
    return block;
}

//字体横向拉伸:正值拉伸，负值压缩
- (WPChainedAttributedFloatBlock)expansionWithOffset{
    WPChainedAttributedFloatBlock block = ^WPMutableAttributedStringMaker *(CGFloat offset,NSRange range){
        [self expansionWithOffset:offset range:range];
        return self;
    };
    return block;
}

@end
