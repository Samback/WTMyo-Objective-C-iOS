//
//  WTPosePattern.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/24/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTPosePattern : NSObject
+ (instancetype)posePatternFromPoseList:(NSArray *)poses withName:(NSString *)name;
@property (nonatomic, readonly, strong) NSString *patternString;
@property (nonatomic, readonly, strong) NSString *name;
- (NSArray *)detectedPoses;
@end
