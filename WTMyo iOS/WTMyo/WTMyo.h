//
//  WTMyo.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WTMyoBridge;
@class TLMArmSyncEvent;
@class TLMOrientationEvent;
@class TLMAccelerometerEvent;
@class TLMPose;
@class TLMGyroscopeEvent;

@protocol WTMyoDelegate <NSObject>
@optional
- (void)didConnectDevice:(NSDictionary *)userInfo;
- (void)didDisconnectDevice:(NSDictionary *)userInfo;
- (void)didUnlockDevice:(NSDictionary *)userInfo;
- (void)didLockDevice:(NSDictionary *)userInfo;
- (void)didSyncArmWithEvent:(TLMArmSyncEvent *)armEvent;
- (void)didUnsyncArm:(NSDictionary *)userInfo;
- (void)didReceiveOrientationEvent:(TLMOrientationEvent *)orientationEvent;
- (void)didReceiveAccelerometerEvent:(TLMAccelerometerEvent *)accelerometerEvent;
- (void)didReceiveGyroscopeEvent:(TLMGyroscopeEvent *)gyroscopeEvent;
- (void)didReceivePoseChange:(TLMPose *)pose;
@end

@interface WTMyo : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *gesturesHistory;
@property (nonatomic, weak) id <WTMyoDelegate> delegate;

- (instancetype)initWithDelegate:(id<WTMyoDelegate>)aDelegate;
@end
