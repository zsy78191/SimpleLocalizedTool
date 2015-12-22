//
//  ViewController.m
//  SimpleLocalizedTool
//
//  Created by 张超 on 15/12/21.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self.view registerForDraggedTypes:@[NSPasteboardTypeString]];
    
    __weak ViewController* weakSelf = self;
    NSMutableString* string = [NSMutableString string];
    
    [(DragView*)self.view setGetNewTextBlock:^(NSDictionary * dictionary,NSString* filepath) {
        __strong ViewController* strongSelf = weakSelf;
        
       
        [string appendFormat:@"//%@\n",filepath];
        [[dictionary allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            NSString* path = [[filepath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.strings",obj]];
            NSMutableString* stringWrite = [NSMutableString string];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                
                NSData* d = [NSData dataWithContentsOfFile:path];
                NSString* origin = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
                [stringWrite appendString:origin];
                
//                NSArray* originArray = [strongSelf findString:@"\".*?\"\\s*?=\\s*?\".*?\";" inString:origin];
            }
            else
            {
                [stringWrite insertString:[NSString stringWithFormat:@"//  SimpleLocalizedTool\n//\n//  Created by Gerinn on 15/12/21.\n//  Copyright © 2015年 gerinn. All rights reserved.\n//  Github : https://github.com/zsy78191/SimpleLocalizedTool \n\n"] atIndex:0];\
            }
            
            [string appendFormat:@"\n\n//%@.strings\n\n",obj];

            NSArray* array = dictionary[obj];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                [string appendFormat:@"\"%@\" = \"%@\";\n",obj2,obj2];
                [stringWrite appendFormat:@"\"%@\" = \"%@\";\n",obj2,obj2];
            }];
         
            NSData* data = [stringWrite dataUsingEncoding:NSUTF8StringEncoding];
            [data writeToFile:path atomically:YES];
        }];
        
        strongSelf.textView.string = string;
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (NSArray*)findString:(NSString*)string inString:(NSString*)origin
{
    NSError* error;
    //        NSMutableString* string = [obj mutableCopy];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:string options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray* array_temp = [regex matchesInString:origin options:kNilOptions range:NSMakeRange(0, origin.length)];
    return array_temp;
}


@end
