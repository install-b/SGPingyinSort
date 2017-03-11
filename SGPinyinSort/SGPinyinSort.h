//
//  SGPinyinSort.h
//  SGPinyinSort
//
//  Created by admin on 16/12/20.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SGPinYinSortTypeByIndex = 0, // 拼音首字母排序
    SGPinYinSortTypeByFull,        // 拼音全拼排序
} SGPinYinSortType;

@interface SGPinyinSort : NSObject
/**
 *  设置排序类型（默认是全拼）
 *
 @param sortType 排序类型
 */
+ (void)setPinyinSortType:(SGPinYinSortType)sortType;
#pragma mark - -----------字符串数组排序------------
/**
 *  排序后的首字母用于tableView的右侧索引
 *
 *  @param stringArr 需要排序的字符数组
 *
 *  @return 排序后的首字母
 */
+ (NSMutableArray *)indexStingArray:(NSArray <NSString *> *)stringArr;


/**
 * 不进行分组排序
 
 @param stringArr 字符串数组
 @return 排序后字符串数组
 */
+ (NSMutableArray *)fullStringSortArray:(NSArray <NSString *> *)stringArr;

/**
 *  返回全拼排序
 *
 *  @param stringArr 需要排序的字符数组
 *
 *  @return 根据具首字母排序后的字符数组
 */
+ (NSMutableArray *)letterStringSortArray:(NSArray <NSString*> *)stringArr;
#pragma mark - --------------对象数组排序---------------
/**
 *  排序后的首字母（不重复）用于tableView的右侧索引
 *
 *  @param objectArray  需要排序的对象数组
 *  @param key          需要比较的对象的字段（必传）
 *
 *  @return 排序后的首字母（不重复）
 */
+ (NSMutableArray *)indexObjectArray:(NSArray *)objectArray Key:(NSString *)key;

/**
 *  给对象数组排序
 *
 *  @param objectArray 需要排序的对象数组
 *  @param key       需要比较的对象的字段（必传）
 *
 *  @return 根据字段排序后的对象数组(同首写字母的在一个数组中)
 */
+ (NSMutableArray *)letterObjectArray:(NSArray *)objectArray Key:(NSString *)key;

/**
 *  给对象数组排序
 *
 *  @param objectArray 需要排序的对象数组
 *  @param key       需要比较的对象的字段（必传）
 *
 *  @return 根据字段排序后的对象数组(不进行分组)
 */
+ (NSMutableArray *)fullObjectArray:(NSArray *)objectArray Key:(NSString *)key;
@end
