//
//  NSArray+CFSearch.h
//  HCSortAndSearch
//
//  Created by Shangen Zhang on 2018/9/21.
//  Copyright © 2018年 Caoyq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CFSearchResult : NSObject

/* 匹配 */
@property (nonatomic,assign) NSRange matchedRange;

/* 原始的对象 */
@property (nonatomic,strong) id originElemt;

/* 匹配属性 字符 */
@property (nonatomic,strong) NSString * matchedProperty;

@end




@interface NSArray (CFSearch)

/**
 模糊搜索

 @param searchText 搜索关键字
 @param propertyNames 模型属性或字典的key
 @param error 异常捕获
 @return 搜索结果 （未进行优先级排序）
 */
- (NSArray <CFSearchResult *>*)searchWithSearchText:(NSString *)searchText
                                    byPropertyNames:(NSArray <NSString *>*)propertyNames
                                              error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
