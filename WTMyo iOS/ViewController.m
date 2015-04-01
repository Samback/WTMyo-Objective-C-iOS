//
//  ViewController.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import "ViewController.h"
#import "WTMyo/WTMyoBridge.h"
#import <QuartzCore/QuartzCore.h>
#import <CMUnistrokeGestureRecognizer/CMUnistrokeGestureRecognizer.h>

@interface ViewController ()<WTMyoDelegate>
@property (nonatomic, strong) WTMyo *wtmyo;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic) NSInteger number;
@property (weak, nonatomic) IBOutlet UILabel *recognizedTemplateLabel;
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
            [self configurateMyo];
        }];
    });
    
}

- (void)configurateMyo
{
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
    if (pose.type == TLMPoseTypeFist) {
        [self.wtmyo startRecordDraw];
    }
    
    if (pose.type == TLMPoseTypeDoubleTap) {
        [self drawPath:self.wtmyo.bezierPath];
        CMUnistrokeGestureResult *result = [self.wtmyo.unistrokeGestureRecognizer isUnistrokeRecognizedFromBezierPath:self.wtmyo.bezierPath];
        if (result) {
            self.recognizedTemplateLabel.text = [NSString stringWithFormat:@"Name %@, score %f", result.recognizedStrokeName, result.recognizedStrokeScore];
        } else {
            self.recognizedTemplateLabel.text = @"Not recognized";
        }
        NSLog(@"Name %@, score %f", result.recognizedStrokeName, result.recognizedStrokeScore);
    }
}



- (void)patternWasDetected:(WTPosePattern *)pattern
{
   // [self.wtmyo stopTrackPosePatterns];
    NSLog(@"Pattern name %@, pattern items %@", pattern.name, [pattern detectedPoses]);
}


- (void)drawPath:(UIBezierPath *)path
{
    if (self.imageView) {
        [self.imageView removeFromSuperview];
    }
    UIImageView *customView = [[UIImageView alloc] init];
    customView.frame=CGRectMake(50, 50, 450, 450);
    
    // create a new contex to draw
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(450, 450), NO, 0);
    [path stroke];
    
    customView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    self.imageView = customView;
    [self.view addSubview:self.imageView];    
}

@end

