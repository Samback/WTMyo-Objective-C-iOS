//
//  NSObject+Extensions.h
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extensions)
- (id)performSelectorIfResponds:(SEL)aSelector;
- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject;
@end
