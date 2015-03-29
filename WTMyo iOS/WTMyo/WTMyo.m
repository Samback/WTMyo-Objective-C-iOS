//
//  WTMyo.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//


#import "WTMyoBridge.h"
#import "WTMyo.h"

@interface WTMyo ()
@end

@implementation WTMyo

#pragma mark - Lazy instantiation
- (instancetype)initWithDelegate:(id<WTMyoDelegate>)aDelegate
{
    if (self = [super init]) {
        [self addMyoObservers];
        self.delegate = aDelegate;
        [self startTrackPosePatterns];
    }
    return self;
}

- (void)setLockingPolicy:(TLMLockingPolicy)policy
{
    [[TLMHub sharedHub] setLockingPolicy:policy];
}

@end
