#WTMyo-Objective-C-iOS
Wrapper under MYO SDK for iOS. 
*You need to add the Myo.framework to the project -* [Download page](https://developer.thalmic.com/downloads)

##Info
This is a small wrapper that help you to controll gestures from Myo Device.
Observer functionality was change to delegates.

####WTMyoDelegate
#####Standart delegate methods
```
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
```
#####Custom delegate methods
```
- (void)patternWasDetected:(WTPosePattern *)pattern;
```

#####Steps to work
It's additional steps to basic steps that you can find at https://developer.thalmic.com/docs/api_reference/ios/_getting__started.html
```
self.wtmyo = [[WTMyo alloc] initWithDelegate:self];
```
#####Create patterns and add them to instance
```
NSArray *pattern =  @[@(TLMPoseTypeDoubleTap), @(TLMPoseTypeFingersSpread)];
NSArray *pattern1 =  @[@(TLMPoseTypeFingersSpread), @(TLMPoseTypeDoubleTap) ];
WTPosePattern *wtPattern = [WTPosePattern posePatternFromPoseList:pattern withName:@"Cool gesture"];
WTPosePattern *wtPattern1 = [WTPosePattern posePatternFromPoseList:pattern1 withName:@"Cool gesture1"];
[self.wtmyo addPosePattern:wtPattern];
[self.wtmyo addPosePattern:wtPattern1];
```
#####Remove pattern
```
[self.wtmyo removePosePatternByName:@"Cool gesture1"];
```

#####More information
Myo - https://www.thalmic.com/en/myo/
More bindings - https://developer.thalmic.com/forums/topic/541/?page=1



