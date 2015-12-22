//
//  LocalizedStringHandle.m
//  SimpleLocalizedTool
//
//  Created by 张超 on 15/12/21.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import "LocalizedStringHandle.h"

@implementation LocalizedStringHandle

+ (NSDictionary *)handleOriginFileContent:(NSString *)content
{
 
    //((\s*@".*?"\s*,?\s*)|\s*nil\s*,?\s*){2,3}
    NSError* error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"NSLocalizedString\\s*\\(((\\s*@\".*?\"\\s*,?\\s*)|\\s*nil\\s*,?\\s*){2,3}\\)|NSLocalizedStringFromTable\\s*\\(((\\s*@\".*?\"\\s*,?\\s*)|\\s*nil\\s*,?\\s*){2,3}\\)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray* array = [regex matchesInString:content options:kNilOptions range:NSMakeRange(0, content.length)];
    NSMutableArray* results = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTextCheckingResult* result = obj;
        NSString* temp = [content substringWithRange:result.range];
        [results addObject:temp];
    }];
    
    NSMutableDictionary* final = [NSMutableDictionary dictionary];
    
    [results enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSError* error;
//        NSMutableString* string = [obj mutableCopy];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=@\").*?(?=((?<!\\\\)\"))|nil" options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray* array_temp = [regex matchesInString:obj options:kNilOptions range:NSMakeRange(0, obj.length)];
        
        NSLog(@"%@",obj);
        NSLog(@"%@",@(array_temp.count));
        if (array_temp.count == 2)
        {
            NSMutableArray* a = [final[@"Localizable"] mutableCopy];
            if (!a) {
                a = [NSMutableArray array];
            }
            NSTextCheckingResult* result_temp = array_temp[0];
            [a addObject:[obj substringWithRange:result_temp.range]];
            final[@"Localizable"] = a;
        }
        else if(array_temp.count == 3)
        {
            NSTextCheckingResult* result_temp0 = array_temp[0];
            NSTextCheckingResult* result_temp1 = array_temp[1];
            NSMutableArray* a = [final[[obj substringWithRange:result_temp1.range]] mutableCopy];
            if (!a) {
                a = [NSMutableArray array];
            }
            [a addObject:[obj substringWithRange:result_temp0.range]];
            final[[obj substringWithRange:result_temp1.range]] = a;
        }
        
    }];
    
    
    

    return [final copy];
}

@end
