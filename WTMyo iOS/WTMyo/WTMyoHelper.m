//
//  WTMyoHelper.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/25/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTMyoBridge.h"
#import "WTMyoHelper.h"

@implementation WTMyoHelper
+ (NSString *)strinfFromPoseType:(TLMPoseType)poseType
{
    char c = 'a';
    return [NSString stringWithFormat:@"%c", (int)(c + poseType)];
}
@end
