//
//  NSString+TransformToPinyin.h
//  PinYin4ObjcExample
//
//  Created by admin on 16/12/20.
//  Copyright © 2016年 kimziv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransformToPinyin)

// 获取拼音全拼
- (NSString *)transformToPinyin;

// 获取拼音索引
- (NSString *)transformToPinyinIndex;

// 获取首字母
- (NSString *)getFirstLetterWithIndex:(NSInteger)characterindex;

// 首字符是否为字母
- (BOOL)isLetterForFirsteCharater;

@end
