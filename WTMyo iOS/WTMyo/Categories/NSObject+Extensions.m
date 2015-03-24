//
//  NSObject+Extensions.m
//  WTMyo iOS
//
//  Created by Max Tymchiy on 3/23/15.
//  Copyright (c) 2015 Max Tymchiy. All rights reserved.
// http://stackoverflow.com/questions/1028934/why-do-unimplemented-optional-protocol-methods-cause-runtime-errors-when-that-me


#import "NSObject+Extensions.h"

@implementation NSObject (Extensions)
- (id)performSelectorIfResponds:(SEL)aSelector
{
    if ( [self respondsToSelector:aSelector] ) {
        return [self performSelector:aSelector];
    }
    return NULL;
}

- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject
{
    if ( [self respondsToSelector:aSelector] ) {
        return [self performSelector:aSelector withObject:anObject];
    }
    return NULL;
}

@end
