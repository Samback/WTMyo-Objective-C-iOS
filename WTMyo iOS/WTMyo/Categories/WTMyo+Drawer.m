//
//  WTMyo+Drawer.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/26/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTMyo+Drawer.h"

@implementation WTMyo (Drawer)

- (UIBezierPath *)bezierPath
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    if (!self.drawPoints.count) {
        return nil;
    }
    NSValue *value = [self.drawPoints firstObject];
    
    [aPath moveToPoint:[value CGPointValue]];
    for (NSValue *value in self.drawPoints) {
        [aPath addLineToPoint:[value CGPointValue]];
    }
    [aPath closePath];
    return aPath;
}
@end
