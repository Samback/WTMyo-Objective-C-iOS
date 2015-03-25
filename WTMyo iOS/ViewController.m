//
//  ViewController.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "ViewController.h"
#import "WTMyo/WTMyoBridge.h"

@interface ViewController ()<WTMyoDelegate>
@property (nonatomic, strong) WTMyo *wtmyo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UINavigationController *controller = [TLMSettingsViewController settingsInNavigationController];
        // Present the settings view controller modally.
        [self presentViewController:controller animated:YES completion:^{
            self.wtmyo = [[WTMyo alloc] initWithDelegate:self];
            [self.wtmyo setLockingPolicy:TLMLockingPolicyNone];
            NSArray *pattern =  @[@(TLMPoseTypeDoubleTap), @(TLMPoseTypeFingersSpread)];
            NSArray *pattern1 =  @[@(TLMPoseTypeFingersSpread), @(TLMPoseTypeDoubleTap) ];
            WTPosePattern *wtPattern = [WTPosePattern posePatternFromPoseList:pattern withName:@"Cool gesture"];
            WTPosePattern *wtPattern1 = [WTPosePattern posePatternFromPoseList:pattern1 withName:@"Cool gesture1"];
            [self.wtmyo addPosePattern:wtPattern];
            [self.wtmyo addPosePattern:wtPattern];
            [self.wtmyo addPosePattern:wtPattern1];
            [self.wtmyo removePosePatternByName:@"Cool gesture1"];
            
        }];
    });
   }


- (void)didReceiveOrientationEvent:(TLMOrientationEvent *)orientationEvent
{

}

- (void)didReceiveAccelerometerEvent:(TLMAccelerometerEvent *)accelerometerEvent
{
    
}

- (void)didReceiveGyroscopeEvent:(TLMGyroscopeEvent *)gyroscopeEvent
{
    
}

- (void)didReceivePoseChange:(TLMPose *)pose
{
}


- (void)patternWasDetected:(WTPosePattern *)pattern
{
    NSLog(@"Pattern name %@, pattern items %@", pattern.name, [pattern detectedPoses]);
}
@end
