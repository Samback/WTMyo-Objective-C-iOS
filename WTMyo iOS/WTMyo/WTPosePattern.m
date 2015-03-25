//
//  WTPosePattern.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/24/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTPosePattern.h"
#import "WTMyoBridge.h"


@interface WTPosePattern ()
@property (nonatomic, readwrite, strong) NSString *patternString;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, strong) NSArray *poses;
@end

@implementation WTPosePattern
+ (instancetype)posePatternFromPoseList:(NSArray *)poses withName:(NSString *)name
{
    if (poses.count < 2) {
        return nil;
    }
    WTPosePattern *pattern = [[WTPosePattern alloc] init];
    NSArray *posesTypes = @[];
    if ([poses[0] isKindOfClass:[TLMPose class]]) {
        posesTypes = [poses valueForKey:@"type"];
        pattern.poses = poses;
    } else {
        posesTypes = poses;
    }
    pattern.name = name;
    pattern.patternString = [posesTypes stringFromPoses];
    return pattern;
}


- (NSArray *)detectedPoses
{
    return self.poses;
}
@end
