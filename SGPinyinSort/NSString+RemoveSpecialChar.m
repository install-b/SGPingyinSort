//
//  NSString+RemoveSpecialChar.m
//  SGPinyinSort
//
//  Created by admin on 16/12/20.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "NSString+RemoveSpecialChar.h"

@implementation NSString (RemoveSpecialChar)
- (NSString *)removeSpecialCharacter {
    
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound){
        return [[self stringByReplacingCharactersInRange:urgentRange withString:@""] removeSpecialCharacter];
    }
    return self;
    
}

@end
