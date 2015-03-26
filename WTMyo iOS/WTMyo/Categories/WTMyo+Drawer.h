//
//  WTMyo+Drawer.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/26/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTMyo.h"
#import "WTMyoBridge.h"

@interface WTMyo (Drawer)
@property (nonatomic, readonly, strong) NSMutableArray *drawPoints;

- (void)startRecordDraw;
- (void)finishRecordDraw;
- (BOOL)isDrawingNow;
- (UIBezierPath *)bezierPath;
@end
