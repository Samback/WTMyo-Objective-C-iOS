//
//  NSArray+WTMPose.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/24/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "NSArray+WTMPose.h"
#import  <MyoKit/MyoKit.h>

@implementation NSArray (WTMPose)
- (NSString *)stringFromPoses
{
    NSString *posePattern = @"";
    if (!self.count) {
        return posePattern;
    }
    char c = 'a';
    for (NSNumber *pose in self) {
       posePattern = [posePattern stringByAppendingString:[NSString stringWithFormat:@"%c", (c + pose.intValue)]];
    }    
    return posePattern;
}

@end
