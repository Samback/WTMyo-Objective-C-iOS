//
//  WTMyo.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "WTMyo.h"
#import <MyoKit/MyoKit.h>


@implementation WTMyo
- (instancetype)initWithDelegate:(id<WTMyoDelegate>)aDelegate
{
    if (self = [super init]) {
        [self addMyoObservers];
        self.delegate = aDelegate;
    }
    return self;
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
    //Posted when a new gyroscope event is available from a TLMMyo. Notifications are posted at a rate of 50 Hz.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveGyroscopeEvent:)
                                                 name:TLMMyoDidReceiveGyroscopeEventNotification
                                               object:nil];
    
    // Posted when a new pose is available from a TLMMyo.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivePoseChange:)
                                                 name:TLMMyoDidReceivePoseChangedNotification
                                               object:nil];
}


#pragma mark - NSNotificationCenter Methods

- (void)didConnectDevice:(NSNotification *)notification
{
    [self.delegate didConnectDevice:notification.userInfo];
}

- (void)didDisconnectDevice:(NSNotification *)notification
{
    [self.delegate didDisconnectDevice:notification.userInfo];
}

- (void)didUnlockDevice:(NSNotification *)notification
{
    [self.delegate didUnlockDevice:notification.userInfo];
}

- (void)didLockDevice:(NSNotification *)notification
{
   [self.delegate didLockDevice:notification.userInfo];
}

- (void)didSyncArm:(NSNotification *)notification
{
    // Retrieve the arm event from the notification's userInfo with the kTLMKeyArmSyncEvent key.
    TLMArmSyncEvent *armEvent = notification.userInfo[kTLMKeyArmSyncEvent];
    [self.delegate didSyncArmWithEvent:armEvent];  
}

- (void)didUnsyncArm:(NSNotification *)notification
{
    [self.delegate didUnsyncArm:notification.userInfo];
}

- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    // Retrieve the orientation from the NSNotification's userInfo with the kTLMKeyOrientationEvent key.
    TLMOrientationEvent *orientationEvent = notification.userInfo[kTLMKeyOrientationEvent];
    [self.delegate didReceiveOrientationEvent:orientationEvent];
}

- (void)didReceiveAccelerometerEvent:(NSNotification *)notification {
    // Retrieve the accelerometer event from the NSNotification's userInfo with the kTLMKeyAccelerometerEvent.
    TLMAccelerometerEvent *accelerometerEvent = notification.userInfo[kTLMKeyAccelerometerEvent];
    [self.delegate didReceiveAccelerometerEvent:accelerometerEvent];    
}

- (void)didReceiveGyroscopeEvent:(NSNotification *)notification {
    // Retrieve the gyroscope event from the NSNotification's userInfo with the kTLMKeyGyroscopeEvent key.
    TLMGyroscopeEvent *gyroscopeEvent = notification.userInfo[kTLMKeyGyroscopeEvent];
    [self.delegate didReceiveGyroscopeEvent:gyroscopeEvent];
}

- (void)didReceivePoseChange:(NSNotification *)notification {
    // Retrieve the pose from the NSNotification's userInfo with the kTLMKeyPose key.
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    [self.delegate didReceivePoseChange:pose];
}







@end
