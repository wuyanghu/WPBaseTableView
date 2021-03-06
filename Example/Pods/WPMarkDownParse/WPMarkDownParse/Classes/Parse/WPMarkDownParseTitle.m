//
//  WPMarkDownParseTitleModel.m
//  NoteAPP
//
//  Created by wupeng on 2020/1/18.
//  Copyright © 2020 wupeng. All rights reserved.
//

#import "WPMarkDownParseTitle.h"
#import "WPMarkDownParseBaseModel.h"
#import "NSMutableAttributedString+WPAddAttributed.h"

@interface WPMarkDownParseTitle()
@property (nonatomic,assign) WPMarkDownParseLevelTitleType level;
@end

@implementation WPMarkDownParseTitle

- (instancetype)initWithLevel:(WPMarkDownParseLevelTitleType)level{
    self = [super init];
    if (self) {
        self.level = level;
    }
    return self;
}

#pragma mark - priveate method

- (void)setLevel:(WPMarkDownParseLevelTitleType)level{
    int i = 0;
    self.symbol = @"#";
    while (i<level) {
        self.symbol = [NSString stringWithFormat:@"%@#",self.symbol];
        i++;
    }
    _level = level;
}

#pragma mark - 策略

- (void)segmentString:(NSArray *)separatedArray text:(NSString *)text{
    
    for (int i = 0; i<separatedArray.count-1; i++) {
        if ([self wp_isBackslash:separatedArray[i]]) {
            continue;
        }
        //匹配到第一个\n
        NSString * rightText = separatedArray[i+1];
        NSRange range = [rightText rangeOfString:@"\n"];
        
        WPMarkDownParseTitleModel * titleModel = [[WPMarkDownParseTitleModel alloc] initWithSymbol:self.symbol];
        if (range.location != NSNotFound) {
            titleModel.text = [rightText substringToIndex:range.location];
        }else{
            titleModel.text = rightText;
        }
        [self.segmentArray addObject:titleModel];
    }
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString{
    if (attributedString.length == 0) {
        return;
    }
    NSString * text = attributedString.string;
    
    [self.segmentArray enumerateObjectsUsingBlock:^(WPMarkDownParseTitleModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [text rangeOfString:obj.text];
        [attributedString wp_makeAttributed:^(WPMutableAttributedStringMaker * _Nullable make) {
            CGFloat fontSize = self.defaultFontSize+6-self.level;
            make.textBoldFont(fontSize,range);
            make.textColor([UIColor blackColor],range);
        }];
    }];
}

@end
