//
//  WTMyo.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//
#import <MyoKit/MyoKit.h>

#import <Foundation/Foundation.h>

@class WTMyoBridge;
@class WTPosePattern;

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

- (void)patternWasDetected:(WTPosePattern *)pattern;
@end

@interface WTMyo : NSObject
@property (nonatomic, weak) id <WTMyoDelegate> delegate;
@property (nonatomic, readonly, strong) NSMutableArray *drawHistory;
- (instancetype)initWithDelegate:(id<WTMyoDelegate>)aDelegate;

- (void)setLockingPolicy:(TLMLockingPolicy)policy;



@property (nonatomic, readonly, strong) NSMutableArray *poseHistory; //limited 10 items
@end
