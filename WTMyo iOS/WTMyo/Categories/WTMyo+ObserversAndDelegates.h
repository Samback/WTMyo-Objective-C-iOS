//
//  WTMyo+ObserversAndDelegates.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "WTMyoBridge.h"

@interface WTMyo (ObserversAndDelegates)
@property (nonatomic, readonly, strong) NSMutableArray *drawPoints;

- (void)addMyoObservers;

- (void)startRecordDraw;
- (void)finishRecordDraw;
- (BOOL)isDrawingNow;
@end
