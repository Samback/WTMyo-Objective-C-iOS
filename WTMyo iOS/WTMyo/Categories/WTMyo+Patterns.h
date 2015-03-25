//
//  WTMyo+Patterns.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/24/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTMyo.h"

@interface WTMyo (Patterns)

@property (nonatomic, readonly, strong) NSMutableArray *posePatterns;
- (BOOL)addPosePattern:(WTPosePattern *)pattern;

@end
