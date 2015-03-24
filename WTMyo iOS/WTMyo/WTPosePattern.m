//
//  WTPosePattern.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/24/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTPosePattern.h"
#import "NSArray+WTMPose.h"

@interface WTPosePattern ()
@property (nonatomic, readwrite, strong) NSString *patternString;
@end

@implementation WTPosePattern
+ (instancetype)posePatternFromPoseList:(NSArray *)poses
{
    WTPosePattern *pattern = [[WTPosePattern alloc] init];
    pattern.patternString = [poses stringFromPoses];
    return pattern;
}

@end
