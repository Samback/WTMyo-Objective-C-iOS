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
- (NSMutableArray *)posePatterns
{
    return  objc_getAssociatedObject(self, @selector(posePatterns));
}

- (void)setPosePatterns:(NSMutableArray *)aPosePatterns
{
    objc_setAssociatedObject(self, @selector(posePatterns), aPosePatterns, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)posePatternsTrack
{
    return  objc_getAssociatedObject(self, @selector(posePatternsTrack));
}

- (void)setPosePatternsTrack:(NSNumber *)aPosePatternsTrack
{
    objc_setAssociatedObject(self, @selector(posePatternsTrack), aPosePatternsTrack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)addPosePattern:(WTPosePattern *)pattern
{
    if (!self.posePatterns.count) {
        self.posePatterns = @[].mutableCopy;
    }
    BOOL canBeAdded = [self canBeAdd:pattern];
    if (canBeAdded) {
        [self.posePatterns addObject:pattern];
    }
    return canBeAdded;
}

- (void)removePosePatternByName:(NSString *)poseName
{
    __block NSInteger posePosition = -1;
    [self.posePatterns enumerateObjectsUsingBlock:^(WTPosePattern *pattern, NSUInteger idx, BOOL *stop) {
        if ([pattern.name isEqualToString:poseName]) {
            posePosition = idx;
            *stop = YES;
        }
    }];
    if (posePosition != -1) {
        [self.posePatterns removeObjectAtIndex:posePosition];
    }
}

- (BOOL)canBeAdd:(WTPosePattern *)pattern
{
    NSUInteger inputPatternLength = pattern.patternString.length;
    NSUInteger currentPoseLength = 0;
    BOOL substringFlag = NO;
    for (WTPosePattern *posePattern in self.posePatterns) {
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


- (void)startTrackPosePatterns
{
    self.posePatternsTrack = @(YES);
}


- (void)stopTrackPosePatterns
{
    self.posePatternsTrack = @(NO);
}

- (BOOL)isPosePatternsTrackNow
{
    return self.posePatternsTrack.boolValue;
}

@end
