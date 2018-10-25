//
//  NSArray+CFSearch.m
//  HCSortAndSearch
//
//  Created by Shangen Zhang on 2018/9/21.
//  Copyright © 2018年 Caoyq. All rights reserved.
//

#import "NSArray+Search.h"
#import "NSString+ChineseInclude.h"
#import "NSString+TransformToPinyin.h"



@implementation CFSearchResult

- (instancetype)initWithRriginElemt:(id)originElemt
                       matchedRange:(NSRange)matchedRange
                    matchedProperty:(NSString *)matchedProperty {
    if (self = [super init]) {
        _originElemt = originElemt;
        _matchedRange = matchedRange;
        _matchedProperty = matchedProperty;
    }
    return self;
}
@end



@implementation NSArray (CFSearch)

- (NSArray <CFSearchResult *>*)searchWithSearchText:(NSString *)searchText byPropertyNames:(NSArray <NSString *>*)propertyNames error:(NSError **)error {
    
    if (self.count == 0) {
        return nil;
    }
    
    if (searchText.length == 0) {
        return self;
    }
    
    // 临时数组
    NSMutableArray *tempArrayM = [NSMutableArray array];
    
    // 搜索关键字是否包含中文
    BOOL isContianerChinese = searchText.sg_isIncludeChinese;
    
    for (NSInteger i = 0; i < self.count; i++) {
        id elemt = self[i];
        if ([elemt isKindOfClass:NSString.class]) {
            
            NSString * searchString = elemt;
            // 搜索关键字不包含中文 且被检索的字段包含中文  需要将中文拼音化
            if (!isContianerChinese && searchString.sg_isIncludeChinese) {
                // 转拼音后
                 searchString = [searchString transformToPinyin];
            }
            NSRange result= [searchString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (result.length) {
                CFSearchResult *resultObj = [[CFSearchResult alloc] initWithRriginElemt:elemt matchedRange:result matchedProperty:nil];
                [tempArrayM addObject:resultObj];
            }
            
        }else {
            // 模型或者字典
            //NSError **errorCatch = error;
            __block NSError *errorInfo = nil;
            [propertyNames enumerateObjectsUsingBlock:^(NSString * _Nonnull ivar, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString * searchString = nil;
                
                @try {
                    searchString = [NSString stringWithFormat:@"%@",[elemt valueForKey:ivar]] ;
                    if (!isContianerChinese && searchString.sg_isIncludeChinese) {
                        // 转拼音后
                        searchString = [searchString transformToPinyin];
                    }
                } @catch (NSException *exception) {
                    errorInfo  = [NSError errorWithDomain:@"不存在该属性" code:100 userInfo:@{@"elemt" : elemt, @"exception" : exception,@"index" : @(i)}];
                    
                } @finally {
                    searchString = [NSString stringWithFormat:@"%@",[elemt valueForKeyPath:ivar]] ;
                    if (!isContianerChinese && searchString.sg_isIncludeChinese) {
                        // 转拼音后
                        searchString = [searchString transformToPinyin];
                    }
                }
                
                NSRange result= [searchString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (result.length) {
                    CFSearchResult *resultObj = [[CFSearchResult alloc] initWithRriginElemt:elemt matchedRange:result matchedProperty:ivar];
                    [tempArrayM addObject:resultObj];
                    *stop = YES;
                }
            }];
            
            if (errorInfo && error) {
                *error = errorInfo;
            }
        }
    }
    
    
    if (tempArrayM.count) {
        return [NSArray arrayWithArray:tempArrayM];
    }
    
    
    return nil;
}
@end
