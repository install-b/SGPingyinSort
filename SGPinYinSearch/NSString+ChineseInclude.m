//
//  NSString+CFChineseInclude.m
//  HCSortAndSearch
//
//  Created by Shangen Zhang on 2018/9/21.
//  Copyright © 2018年 Caoyq. All rights reserved.
//

#import "NSString+ChineseInclude.h"

@implementation NSString (CFChineseInclude)
- (BOOL)sg_isIncludeChinese {
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
@end
