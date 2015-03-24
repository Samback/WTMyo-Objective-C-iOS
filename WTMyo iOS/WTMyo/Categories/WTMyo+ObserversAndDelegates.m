//
//  WTMyo+ObserversAndDelegates.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//
#import <objc/runtime.h>
#import "WTMyo+ObserversAndDelegates.h"
#import "WTMyoBridge.h"
#import "NSObject+Extensions.h"

NSInteger const kLIMIT_NUMBER_OF_GESTURES = 10;

@implementation WTMyo (ObserversAndDelegates)

- (NSMutableArray *)gesturesHistory
{
    return  objc_getAssociatedObject(self, @selector(gesturesHistory));
}

- (void)setGesturesHistory:(NSMutableArray *)aGesturesHistory
{
    objc_setAssociatedObject(self, @selector(gesturesHistory), aGesturesHistory, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)addMyoObservers
{
    // Data notifications are received through NSNotificationCenter.
    // Posted whenever a TLMMyo connects
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didConnectDevice:)
                                                 name:TLMHubDidConnectDeviceNotification
                                               object:nil];
    // Posted whenever a TLMMyo disconnects.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisconnectDevice:)
                                                 name:TLMHubDidDisconnectDeviceNotification
                                               object:nil];
    // Posted whenever the user does a successful Sync Gesture.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSyncArm:)
                                                 name:TLMMyoDidReceiveArmSyncEventNotification
                                               object:nil];
    // Posted whenever Myo loses sync with an arm (when Myo is taken off, or moved enough on the user's arm).
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUnsyncArm:)
                                                 name:TLMMyoDidReceiveArmUnsyncEventNotification
                                               object:nil];
    // Posted whenever Myo is unlocked and the application uses TLMLockingPolicyStandard.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUnlockDevice:)
                                                 name:TLMMyoDidReceiveUnlockEventNotification
                                               object:nil];
    // Posted whenever Myo is locked and the application uses TLMLockingPolicyStandard.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didLockDevice:)
                                                 name:TLMMyoDidReceiveLockEventNotification
                                               object:nil];
    // Posted when a new orientation event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveOrientationEvent:)
                                                 name:TLMMyoDidReceiveOrientationEventNotification
                                               object:nil];
    // Posted when a new accelerometer event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveAccelerometerEvent:)
                                                 name:TLMMyoDidReceiveAccelerometerEventNotification
                                               object:nil];
//    Posted when a new gyroscope event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveGyroscopeEvent:)
                                                 name:TLMMyoDidReceiveGyroscopeEventNotification
                                               object:nil];
    
//     Posted when a new pose is available from a TLMMyo.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivePoseChange:)
                                                 name:TLMMyoDidReceivePoseChangedNotification
                                               object:nil];
}


#pragma mark - NSNotificationCenter Methods

- (void)didConnectDevice:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(didConnectDevice:)]) {
        [self.delegate didConnectDevice:notification.userInfo];
    }
}

- (void)didDisconnectDevice:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(didDisconnectDevice:)]) {
        [self.delegate didDisconnectDevice:notification.userInfo];
    }
}

- (void)didUnlockDevice:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(didUnlockDevice:)]) {
        [self.delegate didUnlockDevice:notification.userInfo];
    }
}

- (void)didLockDevice:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(didLockDevice:)]) {
        [self.delegate didLockDevice:notification.userInfo];
    }
}

- (void)didSyncArm:(NSNotification *)notification
{
    // Retrieve the arm event from the notification's userInfo with the kTLMKeyArmSyncEvent key.
    if ([self.delegate respondsToSelector:@selector(didSyncArmWithEvent:)]) {
        TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
        [self.delegate didSyncArmWithEvent:armEvent];
    }
}

- (void)didUnsyncArm:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(didUnsyncArm:)]) {
        [self.delegate didUnsyncArm:notification.userInfo];
    }
}

- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    // Retrieve the orientation from the NSNotification's userInfo with the kTLMKeyOrientationEvent key.
    if ([self.delegate respondsToSelector:@selector(didReceiveOrientationEvent:)]) {
        TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
        [self.delegate didReceiveOrientationEvent:orientationEvent];
    }
}

- (void)didReceiveAccelerometerEvent:(NSNotification *)notification {
    // Retrieve the accelerometer event from the NSNotification's userInfo with the kTLMKeyAccelerometerEvent.
    if ([self.delegate respondsToSelector:@selector(didReceiveAccelerometerEvent:)]) {
        TLMAccelerometerEvent *accelerometerEvent = notification.userInfo[kTLMKeyAccelerometerEvent];
        [self.delegate didReceiveAccelerometerEvent:accelerometerEvent];
    }
}

- (void)didReceiveGyroscopeEvent:(NSNotification *)notification {
    // Retrieve the gyroscope event from the NSNotification's userInfo with the kTLMKeyGyroscopeEvent key.
    if ([self.delegate respondsToSelector:@selector(didReceiveGyroscopeEvent:)]) {
        TLMGyroscopeEvent *gyroscopeEvent = notification.userInfo[kTLMKeyGyroscopeEvent];
        [self.delegate didReceiveGyroscopeEvent:gyroscopeEvent];
    }
}

- (void)didReceivePoseChange:(NSNotification *)notification {
    // Retrieve the pose from the NSNotification's userInfo with the kTLMKeyPose key.
    if ([self.delegate respondsToSelector:@selector(didReceivePoseChange:)]) {
        TLMPose *pose = notification.userInfo[kTLMKeyPose];
        [self updateGesturesHistoryWithPose:pose];
        [self.delegate didReceivePoseChange:pose];
    }
}

#pragma mark - Pose methods
- (void)updateGesturesHistoryWithPose:(TLMPose *)pose
{
    if (!self.gesturesHistory) {
        self.gesturesHistory = @[].mutableCopy;
    }
    if (self.gesturesHistory.count > kLIMIT_NUMBER_OF_GESTURES) {
        [self.gesturesHistory removeObjectAtIndex:0];
    }
    [self.gesturesHistory addObject:pose];
}

@end
