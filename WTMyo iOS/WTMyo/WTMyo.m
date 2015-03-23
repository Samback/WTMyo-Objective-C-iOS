//
//  WTMyo.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTMyo.h"
#import <MyoKit/MyoKit.h>
#import "WTMyoBridge.h"

@interface WTMyo ()
@property (nonatomic, readwrite, strong) NSMutableArray *gesturesHistory;

@end



@implementation WTMyo

#pragma mark - Lazy instantiation
- (instancetype)initWithDelegate:(id<WTMyoDelegate>)aDelegate
{
    if (self = [super init]) {
        [self addMyoObservers];
        self.delegate = aDelegate;
    }
    return self;
}

- (NSMutableArray *)gesturesHistory
{
    if (!_gesturesHistory) {
        _gesturesHistory = @[].mutableCopy;
    }
    return _gesturesHistory;
}










@end
