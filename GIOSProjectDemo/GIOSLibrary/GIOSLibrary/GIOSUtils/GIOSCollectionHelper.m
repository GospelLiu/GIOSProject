//
//  GIOSCollectionHelper.m
//  GIOSLibrary
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import "GIOSCollectionHelper.h"

@implementation GIOS(DictionaryUtil)

+(id)getIdValueForKey:(NSString*)key defaultValue:(id)value formDic:(NSDictionary*)dic withType:(Class)type
{
    @try {
        if (!dic || !key ) return value;
        
        id reValue = [dic objectForKey:key];
        if (reValue && [reValue isKindOfClass:type]) {
            return reValue;
        }else{
            return value;
        }
    }
    @catch (NSException *exception) {
        return value;
    }
}

@end