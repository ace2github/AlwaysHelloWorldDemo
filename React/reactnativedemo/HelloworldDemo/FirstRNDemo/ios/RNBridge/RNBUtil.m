//
//  RNBUtil.m
//  dsbridge
//
//  Created by ChaohuiChen on 2021/5/14.
//  Copyright © 2021 杜文. All rights reserved.
//

#import "RNBUtil.h"
#import <objc/runtime.h>

@implementation RNBUtil
+ (NSString *)objToJsonString:(id)dict {
    NSString *jsonString = nil;
    NSError *error;
    
    if (![NSJSONSerialization isValidJSONObject:dict]) {
        return @"{}";
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    if (!jsonData) {
        return @"{}";
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id)jsonStringToObject:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}


//get this class all method
+ (NSArray *)allMethodFromClass:(Class)class {
    NSMutableArray *methods = [NSMutableArray array];
    while (class) {
        unsigned int count = 0;
        Method *method = class_copyMethodList(class, &count);
        for (unsigned int i = 0; i < count; i++) {
            SEL name1 = method_getName(method[i]);
            const char *selName= sel_getName(name1);
            NSString *strName = [NSString stringWithCString:selName encoding:NSUTF8StringEncoding];
            [methods addObject:strName];
        }
        free(method);
        
        Class cls = class_getSuperclass(class);
        class = [NSStringFromClass(cls) isEqualToString:NSStringFromClass([NSObject class])] ? nil : cls;
    }
    
    return [NSArray arrayWithArray:methods];
}


//return method name for xxx: or xxx:handle:
+ (NSString *)methodByNameArg:(NSInteger)argNum
                      selName:(NSString *)selName
                          cls:(Class)cls
{
    NSString *result = nil;
    if(cls){
        NSArray *arr = [self allMethodFromClass:cls];
        for (int i=0; i<arr.count; i++) {
            NSString *method = arr[i];
            NSArray *tmpArr = [method componentsSeparatedByString:@":"];
            NSRange range = [method rangeOfString:@":"];
            if (range.length > 0) {
                NSString *methodName = [method substringWithRange:NSMakeRange(0, range.location)];
                if ([methodName isEqualToString:selName] && tmpArr.count == (argNum + 1)) {
                    result = method;
                    return result;
                }
            }
        }
    }
    return result;
}


+ (NSArray *)parseNamespace:(NSString *)method{
    NSRange range=[method rangeOfString:@"." options:NSBackwardsSearch];
    NSString *namespace=@"";
    if(range.location!=NSNotFound){
        namespace=[method substringToIndex:range.location];
        method=[method substringFromIndex:range.location+1];
    }
    return @[namespace,method];
}

+ (NSString *)callResult:(NSInteger)callCode data:(id)data {
    NSDictionary *resDic = @{@"code":@(callCode), @"data":data ? : @""};
    NSString *valueStr = [self objToJsonString:resDic];
    valueStr = [valueStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return valueStr;
}
@end
