//
//  LBNGraphics.h
//  Nerv
//
//  Created by Jonathan Long on 2/3/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBNGraphics : NSObject
+ (void)drawRoundedRectInRect:(CGRect)rect
                  withContext:(CGContextRef)currentContext
                 cornerRadius:(CGFloat)radius
                  strokeColor:(UIColor*)strokeColor
                    fillColor:(UIColor*)fillColor
                    lineWidth:(CGFloat)lineWidth;

+ (void)drawTopOfRoundedRectInRect:(CGRect)rect
                       withContext:(CGContextRef)currentContext
                      cornerRadius:(CGFloat)radius
                       strokeColor:(UIColor*)strokeColor
                         fillColor:(UIColor*)fillColor
                         lineWidth:(CGFloat)lineWidth;

+ (void)drawBottomOfRoundedRectInRect:(CGRect)rect
                          withContext:(CGContextRef)currentContext
                         cornerRadius:(CGFloat)radius
                          strokeColor:(UIColor*)stokeColor
                            fillColor:(UIColor*)fillColor
                            lineWidth:(CGFloat)lineWidth;

+ (void)drawBottomOfRectInRect:(CGRect)rect
                   withContext:(CGContextRef)currentContext
                   strokeColor:(UIColor*)stokeColor
                     fillColor:(UIColor*)fillColor
                     lineWidth:(CGFloat)lineWidth;

@end
