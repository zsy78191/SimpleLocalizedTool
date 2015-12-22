//
//  DragView.h
//  SimpleLocalizedTool
//
//  Created by 张超 on 15/12/21.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DragView : NSView {
    BOOL        isHighlighted;
    BOOL        inView;
}

@property (assign, setter=setHighlighted:) BOOL isHighlighted;

@property (nonatomic, strong) void (^ getNewTextBlock)(NSDictionary* final, NSString* filepath);

@end
