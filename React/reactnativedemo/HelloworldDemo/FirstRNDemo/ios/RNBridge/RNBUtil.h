//
//  RNBUtil.h
//  dsbridge
//
//  Created by ChaohuiChen on 2021/5/14.
//  Copyright © 2021 杜文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNBUtil : NSObject
+ (NSString *_Nullable)objToJsonString:(id _Nonnull)dict;

+ (id _Nullable)jsonStringToObject:(NSString *_Nonnull)jsonString;

+ (NSString *_Nullable)methodByNameArg:(NSInteger)argNum
                               selName:(NSString *_Nullable)selName
                                   cls:(Class _Nonnull)cls;

+ (NSArray *_Nonnull)parseNamespace:(NSString *_Nonnull)method;

+ (NSString *_Nullable)callResult:(NSInteger)callCode data:(id)data;
@end

