//
//  CMUDTemplate.m
//  CMUnistrokeDemo
//
//  Created by Chris Miles on 11/11/12.
//  Copyright (c) 2012 Chris Miles. All rights reserved.
//
//  MIT Licensed (http://opensource.org/licenses/mit-license.php):
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CMUDTemplate.h"
#import "CMUDStrokeTemplateView.h"

@interface CMUDTemplate ()

@property (copy, nonatomic, readwrite) NSString *name;
@property (copy, nonatomic, readwrite) NSArray *paths;
@property (strong, nonatomic, readwrite) CMUDStrokeTemplateView *strokeTemplateView;

@end


@implementation CMUDTemplate

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)addPath:(UIBezierPath *)path
{
    NSMutableArray *paths = [self.paths mutableCopy];
    if (paths == nil) {
	paths = [[NSMutableArray alloc] init];
    }
    [paths addObject:path];
    
    self.paths = paths;
}

- (CMUDStrokeTemplateView *)strokeTemplateView
{
    if (_strokeTemplateView == nil) {
	_strokeTemplateView = [[CMUDStrokeTemplateView alloc] initWithName:self.name bezierPath:self.paths[0]];
    }
    return _strokeTemplateView;
}

@end
