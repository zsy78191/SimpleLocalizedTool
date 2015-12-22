//
//  AppDelegate.m
//  SimpleLocalizedTool
//
//  Created by 张超 on 15/12/21.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalizedStringHandle.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
  
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)application:(NSApplication *)sender openFiles:(NSArray<NSString *> *)filenames
{
//    NSLog(@"%@",filenames);
    
    NSString* fileName = filenames.firstObject;
    NSError* error;
    NSData* data = [NSData dataWithContentsOfFile:fileName options:NSDataReadingMappedAlways error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    else
    {
        NSString* content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [LocalizedStringHandle handleOriginFileContent:content];
    }

}

@end
