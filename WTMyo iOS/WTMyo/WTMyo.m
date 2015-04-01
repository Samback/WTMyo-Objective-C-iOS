//
//  WTMyo.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//


#import "WTMyoBridge.h"
#import "WTMyo.h"
#import "CMUDTemplatePaths.h"
#import "CMUDTemplate.h"
//#import "CMUDDrawView.h"
#import <UIKit/UIKit.h>
#import <CMUnistrokeGestureRecognizer/CMUnistrokeGestureRecognizer.h>


@interface WTMyo ()<CMUnistrokeGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableDictionary *templates;
@property (strong, nonatomic, readwrite) CMUnistrokeGestureRecognizer *unistrokeGestureRecognizer;
@end

@implementation WTMyo

#pragma mark - Lazy instantiation
- (instancetype)initWithDelegate:(id<WTMyoDelegate>)aDelegate
{
    if (self = [super init]) {
        [self addMyoObservers];
        self.delegate = aDelegate;
        self.unistrokeGestureRecognizer = [[CMUnistrokeGestureRecognizer alloc] initWithTarget:self action:@selector(unistrokeGestureRecognizer:)];
        [self startTrackPosePatterns];
        [self initializeDefaultTemplates];
        [self setupStrokeTemplates];
    }
    return self;
}

- (void)setLockingPolicy:(TLMLockingPolicy)policy
{
    [[TLMHub sharedHub] setLockingPolicy:policy];
}

- (void)initializeDefaultTemplates
{
    NSMutableDictionary *templates = [NSMutableDictionary dictionary];
    
    for (unsigned int i=0; ; i++) {
        struct templatePath templatePath = templatePaths[i];
        if (templatePath.length == 0) break;
        
        UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
        [bezierPath moveToPoint:templatePath.points[0]];
        for (NSUInteger j=1; j<templatePath.length; j++) {
            [bezierPath addLineToPoint:templatePath.points[j]];
        }
        
        NSString *name = [NSString stringWithUTF8String:templatePath.name];
        
        CMUDTemplate *template = [templates valueForKey:name];
        if (template == nil) {
            template = [[CMUDTemplate alloc] initWithName:name];
            [templates setValue:template forKey:name];
        }
        [template addPath:bezierPath];
    }
    
    self.templates = templates;
}

- (void)setupStrokeTemplates
{
    [self addStrokeTemplates];
//    [self setupTemplatesScrollView];
//    [self clearRecognizedTemplateLabel];
}

- (void)addStrokeTemplates
{
    [self clearAllUnistrokes];
    
    for (CMUDTemplate *template in [self.templates allValues]) {
        for (UIBezierPath *path in template.paths) {
            [self registerUnistrokeWithName:template.name bezierPath:path];
        }
    }
}


- (void)unistrokeGestureRecognizer:(CMUnistrokeGestureRecognizer *)unistrokeGestureRecognizer
{
    // A stroke was recognized
    
    NSLog(@"Recognized template: %@ (%f)", unistrokeGestureRecognizer.result.recognizedStrokeName, unistrokeGestureRecognizer.result.recognizedStrokeScore);
    
//    self.drawPath = unistrokeGestureRecognizer.strokePath;
//    [self.delegate drawView:self didRecognizeUnistrokeWithName:unistrokeGestureRecognizer.result.recognizedStrokeName score:unistrokeGestureRecognizer.result.recognizedStrokeScore];
//    [self setNeedsDisplay];
}



#pragma mark - Unistroke registration

- (void)registerUnistrokeWithName:(NSString *)name bezierPath:(UIBezierPath *)path
{
    [self.unistrokeGestureRecognizer registerUnistrokeWithName:name bezierPath:path];
}

- (void)clearAllUnistrokes
{
    [self.unistrokeGestureRecognizer clearAllUnistrokes];
}


#pragma mark - CMUnistrokeGestureRecognizerDelegate

- (void)unistrokeGestureRecognizer:(CMUnistrokeGestureRecognizer *)unistrokeGestureRecognizer isEvaluatingStrokePath:(UIBezierPath *)strokePath
{
#pragma unused(unistrokeGestureRecognizer)
#pragma unused(strokePath)
    
//    self.drawPath = unistrokeGestureRecognizer.strokePath;
//    [self.delegate drawViewDidStartRecognizingStroke:self];
//    [self setNeedsDisplay];
     NSLog(@"isEvaluatingStrokePath unistrokeGestureRecognizer Recognized template: %@ (%f)", unistrokeGestureRecognizer.result.recognizedStrokeName, unistrokeGestureRecognizer.result.recognizedStrokeScore);
}

- (void)unistrokeGestureRecognizerDidFailToRecognize:(CMUnistrokeGestureRecognizer *)unistrokeGestureRecognizer
{
#pragma unused(unistrokeGestureRecognizer)
    
//    [self.delegate drawViewDidFailToRecognizeUnistroke:self];
     NSLog(@" unistrokeGestureRecognizerDidFailToRecognize Recognized template: %@ (%f)", unistrokeGestureRecognizer.result.recognizedStrokeName, unistrokeGestureRecognizer.result.recognizedStrokeScore);
}



@end
