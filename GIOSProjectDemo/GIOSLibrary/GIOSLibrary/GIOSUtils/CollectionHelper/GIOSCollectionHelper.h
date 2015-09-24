//
//  GIOSCollectionHelper.h
//  GIOSLibrary
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIOSDefine.h"

@interface GIOS(DictionaryUtil): NSObject

+(id)getIdValueForKey:(NSString*)key defaultValue:(id)value formDic:(NSDictionary*)dic withType:(Class)type;
@end