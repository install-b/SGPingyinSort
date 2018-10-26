//
//  SGPinyinSort.m
//  SGPinyinSort
//
//  Created by admin on 16/12/20.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "SGPinyinSort.h"
#import "NSString+TransformToPinyin.h"
#import "NSString+RemoveSpecialChar.h"

@interface SGPinyinSort ()
//进行比较的字符串，
@property(strong,nonatomic)NSString *string;
//字符串对应的拼音
@property(strong,nonatomic)NSString *pinYin;
//需要比较的对象
@property (strong , nonatomic) id object;

@end

static SGPinYinSortType _sortType = SGPinYinSortTypeByFull;

@implementation SGPinyinSort
+ (void)setPinyinSortType:(SGPinYinSortType)sortType {
    _sortType = sortType;
}
#pragma mark - ==============给 NSString数组 排序==================
+(NSMutableArray*)indexStingArray:(NSArray <NSString *>*)stringArr{
    NSMutableArray *tempArray = [self returnSortObjectArrar:stringArr key:nil];
    NSMutableArray *A_Result = [NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray) {
        NSString *pinyin = [((SGPinyinSort*)object).pinYin substringToIndex:1];
        char h = pinyin.UTF8String[0];
        if (h < 'A' || h > 'z') {
            pinyin = @"#";
        }
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

+ (NSMutableArray*)fullStringSortArray:(NSArray <NSString *>*)stringArray{
    
    NSMutableArray *tempArray = [self returnSortObjectArrar:stringArray key:nil];
    
    NSMutableArray *LetterResult = [NSMutableArray array];
    
    for (SGPinyinSort * object in tempArray) {
        [LetterResult addObject:object.string];
    }
    return LetterResult;
    
}

+ (NSMutableArray*)letterStringSortArray:(NSArray <NSString *>*)stringArr{
    NSMutableArray *tempArray = [self returnSortObjectArrar:stringArr key:nil];
    NSMutableArray *LetterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    //拼音分组
    for (NSString* object in tempArray) {
        
        NSString *pinyin = [((SGPinyinSort*)object).pinYin substringToIndex:1];
        char h = pinyin.UTF8String[0];
        if (h < 'A' || h > 'z') {
            pinyin = @"#";
        }
        NSString *string = ((SGPinyinSort*)object).string;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:string];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:string];
        }
    }
    return LetterResult;
}

#pragma mark - ==============给 对象数组 根据某个属性 排序==================
+ (NSMutableArray *)indexObjectArray:(NSArray*)objectArray Key:(NSString *)key{
    NSMutableArray *tempArray = [self returnSortObjectArrar:objectArray key:key];
    NSMutableArray *A_Result = [NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((SGPinyinSort*)object).pinYin substringToIndex:1];
        char h = pinyin.UTF8String[0];
        if (h < 'A' || h > 'z') {
            pinyin = @"#";
        }
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

//给对象数组排序
+ (NSMutableArray *)letterObjectArray:(NSArray*)objectArray Key:(NSString *)key{
    NSMutableArray *tempArray = [self returnSortObjectArrar:objectArray key:key];
    NSMutableArray *LetterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    //拼音分组
    for (SGPinyinSort* object in tempArray) {
        
        NSString *pinyin = [object.pinYin substringToIndex:1];
        char h = pinyin.UTF8String[0];
        if (h < 'A' || h > 'z') {
            pinyin = @"#";
        }
        id obj = object.object;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:obj];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:obj];
        }
    }
    return LetterResult;
}

+ (NSMutableArray *)fullObjectArray:(NSArray*)objectArray Key:(NSString *)key {
    NSMutableArray *tempArray = [self returnSortObjectArrar:objectArray key:key];
    NSMutableArray *LetterResult = [NSMutableArray array];
    
    for (SGPinyinSort* object in tempArray) {
        id obj = object.object;
        [LetterResult addObject:obj];
    }
    return LetterResult;
}


#pragma mark - sort
+ (BOOL)sg_hasEmojiPrefxWithString:(NSString *)str {
    if (str.length) {
        unichar ch = [str characterAtIndex:0];
        if (0x4e00 > ch  || ch > 0x9fff) {
            return true;
        }
    }
    return NO;
}
+(NSMutableArray*)returnSortObjectArrar:(NSArray*)stringArr key:(NSString *)key {
    
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++){
        SGPinyinSort *chineseString = [[SGPinyinSort alloc]init];
        
        if (key) { // 对象
            //获取对象对应字段的字符串
            id temp = [stringArr objectAtIndex:i];
            NSString *originStr = [NSString stringWithFormat:@"%@",[temp valueForKeyPath:key]];
            
            chineseString.string = originStr;
            chineseString.object = temp;
            
            // #号处理
            if ([self sg_hasEmojiPrefxWithString:originStr]) {
                NSData *uniData = [[NSString stringWithUTF8String:originStr.UTF8String] dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                NSString *goodStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding] ;
                if (![goodStr isEqualToString:originStr]) {
                    goodStr = @"#";
                    chineseString.pinYin = @"#";
                }
            }
            
        }else { // 字符串
            chineseString.string = [NSString stringWithString:[stringArr objectAtIndex:i]];
        }
        
        
        if(chineseString.string == nil){
            chineseString.string = @"";
        }
        
        //去除两端空格和回车
        chineseString.string  = [chineseString.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //这里我自己写了一个递归过滤指定字符串   RemoveSpecialCharacter
        chineseString.string = [chineseString.string removeSpecialCharacter];
        
        if ([chineseString.pinYin isLetterForFirsteCharater]) { // 判断首字母是否为大写
            
            //首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString] ;
        }else{
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult = [NSString string];
                NSString *singlePinyinLetter = nil;
                
                for(int j=0;j<chineseString.string.length;j++){
                    
                    if (_sortType == SGPinYinSortTypeByFull) { // 全屏
                        static NSRange range;
                        range = NSMakeRange(j, 1);
                        
                        singlePinyinLetter = [[[chineseString.string substringWithRange:range] transformToPinyin] uppercaseString];
                        //singlePinyinLetter = [[chineseString.string substringWithRange:range] getFirstLetterWithIndex:0];
                        [singlePinyinLetter stringByAppendingString:@" "];
                    } else { // 首字母
                        
                        singlePinyinLetter = [chineseString.string getFirstLetterWithIndex:j];
                        singlePinyinLetter = [singlePinyinLetter uppercaseString];
                    }
                    
                    pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
                    
                }
                
                chineseString.pinYin = pinYinResult;
                
            }else{
                chineseString.pinYin = @"#";
            }
        }
        [chineseStringsArray addObject:chineseString];
        
    }
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}


@end
