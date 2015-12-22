//
//  DragView.m
//  SimpleLocalizedTool
//
//  Created by 张超 on 15/12/21.
//  Copyright © 2015年 gerinn. All rights reserved.
//

#import "DragView.h"

#import "LocalizedStringHandle.h"

@implementation DragView

@dynamic isHighlighted;

- (void)awakeFromNib
{
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    NSLog(@"%@",[pboard types]);
    
    inView = YES;

    [self setHighlighted:YES];
    return NSDragOperationEvery;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender
{
    if (inView) {
        NSPasteboard *pboard = [sender draggingPasteboard];
        NSArray *paths = [pboard propertyListForType:NSFilenamesPboardType];
        NSLog(@"%@",paths);
        NSLog(@"end");
        
        
        NSString* fileName = paths.firstObject;
        
        if ([fileName hasSuffix:@".m"]||[fileName hasSuffix:@".mm"]) {
            NSError* error;
            NSData* data = [NSData dataWithContentsOfFile:fileName options:NSDataReadingMappedAlways error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            else
            {
                NSString* content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary* final = [LocalizedStringHandle handleOriginFileContent:content];
                if (self.getNewTextBlock) {
                    self.getNewTextBlock(final,fileName);
                }
                
            }
        }
        else
        {
            NSLog(@"文件格式不支持");
        }
    }
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    [self setHighlighted:NO];
    
    inView = NO;
}


- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender  {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    [self setHighlighted:NO];
    return YES;
}
- (BOOL)isHighlighted {
    return isHighlighted;
}

- (void)setHighlighted:(BOOL)value {
    isHighlighted = value;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSLog(@"%@",@(isHighlighted));
    if (isHighlighted) {
        [NSBezierPath setDefaultLineWidth:6.0];
        [[NSColor keyboardFocusIndicatorColor] set];
        [NSBezierPath strokeRect:self.frame];
    }
}

@end
