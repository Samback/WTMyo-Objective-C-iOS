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

NSInteger const kLIMIT_NUMBER_OF_GESTURES = 10;

@implementation WTMyo (ObserversAndDelegates)


- (NSString *)stringOfHistory
{
    return  objc_getAssociatedObject(self, @selector(stringOfHistory));
}

- (void)setStringOfHistory:(NSString *)aStringOfHistory
{
    objc_setAssociatedObject(self, @selector(stringOfHistory), aStringOfHistory, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableArray *)poseHistory
{
    return  objc_getAssociatedObject(self, @selector(poseHistory));
}

- (void)setPoseHistory:(NSMutableArray *)aPoseHistory
{
    objc_setAssociatedObject(self, @selector(poseHistory), aPoseHistory, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableArray *)drawPoints
{
    return  objc_getAssociatedObject(self, @selector(drawPoints));
}

- (void)setDrawPoints:(NSMutableArray *)aDrawPoints
{
    objc_setAssociatedObject(self, @selector(drawPoints), aDrawPoints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)drawRecord
{
    return  objc_getAssociatedObject(self, @selector(drawRecord));
}

- (void)setDrawRecord:(NSNumber *)aDrawRecord
{
    objc_setAssociatedObject(self, @selector(drawRecord), aDrawRecord, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSValue *)oldPositionPoint
{
    return  objc_getAssociatedObject(self, @selector(oldPositionPoint));
}

- (void)setOldPositionPoint:(NSValue *)anOldPositionPoint
{
    objc_setAssociatedObject(self, @selector(oldPositionPoint), anOldPositionPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)startRecordDraw
{
    self.drawPoints = @[].mutableCopy;
    self.drawRecord = @(YES);
}

- (void)finishRecordDraw
{
    self.drawRecord = @(NO);
}

- (BOOL)isDrawingNow
{
    return self.drawRecord.boolValue;
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
        if ([self isDrawingNow]) {
            TLMEulerAngles *angle = [TLMEulerAngles anglesWithQuaternion:orientationEvent.quaternion];
            CGFloat xCoordinate =  200 - angle.yaw.radians/M_PI*100;
            CGFloat yCoordinate =  100 + angle.pitch.radians/M_PI*100;
            [self.drawPoints addObject:[NSValue valueWithCGPoint:CGPointMake(xCoordinate, yCoordinate)]];
        }
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
        if ([self isPosePatternsTrackNow]) {
            [self updatePoseHistoryWithPose:pose];
        }
        [self.delegate didReceivePoseChange:pose];
    }
}

#pragma mark - Pose methods
- (void)updatePoseHistoryWithPose:(TLMPose *)pose
{
    //Filter from garbage
    if (pose.type == TLMPoseTypeRest) {
        return;
    }
    if (!self.poseHistory) {
        self.poseHistory = @[].mutableCopy;
    }
    if (!self.stringOfHistory.length) {
        self.stringOfHistory = @"";
    }
    
    [self addToPoseHistoryNewPose:pose];
}

- (void)addToPoseHistoryNewPose:(TLMPose *)pose
{
    if (self.poseHistory.count > kLIMIT_NUMBER_OF_GESTURES) {
        [self.poseHistory removeObjectAtIndex:0];
        if (self.stringOfHistory.length > kLIMIT_NUMBER_OF_GESTURES) {
            self.stringOfHistory = [self.stringOfHistory substringFromIndex:1];
        }
        
    }
    [self.poseHistory addObject:pose];
    self.stringOfHistory = [self.stringOfHistory stringByAppendingString:[WTMyoHelper strinfFromPoseType:pose.type]];
    WTPosePattern *pattern = [self findPattern];
    if (pattern) {
        [self.delegate patternWasDetected:pattern];
    }
}

- (WTPosePattern *)findPattern
{
    if (!self.posePatterns.count) {
        return nil;
    }
    NSLog(@"String of history %@", self.stringOfHistory);
    for (WTPosePattern *pattern in self.posePatterns) {
        if ([self.stringOfHistory containsString:pattern.patternString]) {
            NSRange range = [self.stringOfHistory rangeOfString:pattern.patternString];
            NSArray *poses = [self.poseHistory subarrayWithRange:range];
            [self.poseHistory removeAllObjects];
            self.stringOfHistory = @"";
            return [WTPosePattern posePatternFromPoseList:poses withName:pattern.name];
        }
    }
    return nil;
}
@end

