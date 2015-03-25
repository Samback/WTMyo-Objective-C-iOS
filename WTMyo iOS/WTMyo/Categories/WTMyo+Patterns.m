//
//  WTMyo+Patterns.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/24/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//


#import "WTMyo+Patterns.h"
#import "WTPosePattern.h"
#import <objc/runtime.h>

@implementation WTMyo (Patterns)
- (NSMutableArray *)posePattern
{
    return  objc_getAssociatedObject(self, @selector(posePattern));
}

- (void)setPosePattern:(NSMutableArray *)aPosePattern
{
    objc_setAssociatedObject(self, @selector(posePattern), aPosePattern, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)addPosePattern:(WTPosePattern *)pattern
{
    if (!self.posePattern.count) {
        self.posePattern = @[].mutableCopy;
    }
    BOOL canBeAdded = [self canBeAdd:pattern];
    if (canBeAdded) {
        [self.posePattern addObject:pattern];
    }
    return canBeAdded;
}

- (BOOL)canBeAdd:(WTPosePattern *)pattern
{
    NSUInteger inputPatternLength = pattern.patternString.length;
    NSUInteger currentPoseLength = 0;
    BOOL substringFlag = NO;
    for (WTPosePattern *posePattern in self.posePattern) {
        currentPoseLength = posePattern.patternString.length;
        if (currentPoseLength > inputPatternLength) {
            substringFlag = [posePattern.patternString containsString:pattern.patternString];
        } else {
            substringFlag = [posePattern.patternString containsString:pattern.patternString];
        }
        
        if (substringFlag) {
            return NO;
        }
    }
    return YES;
}


- (void)patternWasFired:(WTPosePattern *)parrent
{
    
}

@end
