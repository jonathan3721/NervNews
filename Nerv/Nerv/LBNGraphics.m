//
//  LBNGraphics.m
//  Nerv
//
//  Created by Jonathan Long on 2/3/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNGraphics.h"

@implementation LBNGraphics

+ (void)drawRoundedRectInRect:(CGRect)rect
                  withContext:(CGContextRef)currentContext
             WithCornerRadius:(CGFloat)radius
                  strokeColor:(UIColor*)strokeColor
                    fillColor:(UIColor*)fillColor
                    lineWidth:(CGFloat)lineWidth
{
    CGContextSaveGState(currentContext);
    CGContextSetFillColorWithColor(currentContext, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(currentContext, strokeColor.CGColor);
    CGRect insetRect = CGRectInset(rect, 0.5f, 0.5f);
    
    UIBezierPath* roundedPath = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:radius];
    [roundedPath setLineWidth:lineWidth];
    [roundedPath fill];
    [roundedPath stroke];
    
    CGContextRestoreGState(currentContext);
    
    
}

+ (void)drawTopOfRoundedRectInRect:(CGRect)rect
                          withContext:(CGContextRef)currentContext
                         cornerRadius:(CGFloat)radius
                          strokeColor:(UIColor*)strokeColor
                            fillColor:(UIColor*)fillColor
                            lineWidth:(CGFloat)lineWidth
{
    CGContextSaveGState(currentContext);
    CGContextSetFillColorWithColor(currentContext, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(currentContext, strokeColor.CGColor);
    CGRect insetRect = CGRectInset(rect, 0.5f, 0.5f);
    CGRect outOfBoundsRect = CGRectMake(insetRect.origin.x, insetRect.origin.y , insetRect.size.width, insetRect.size.height + lineWidth);
    UIBezierPath* roundedPath = [UIBezierPath bezierPathWithRoundedRect:outOfBoundsRect
                                                      byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                            cornerRadii:CGSizeMake(radius, radius)];
    CGContextClipToRect(currentContext, insetRect);
    [roundedPath addClip];
    [roundedPath setLineWidth:lineWidth];
    [roundedPath fill];
    [roundedPath stroke];
    
    CGContextRestoreGState(currentContext);
    
}

+ (void)drawBottomOfRoundedRectInRect:(CGRect)rect
                          withContext:(CGContextRef)currentContext
                         cornerRadius:(CGFloat)radius
                          strokeColor:(UIColor*)strokeColor
                            fillColor:(UIColor*)fillColor
                            lineWidth:(CGFloat)lineWidth
{
    CGContextSaveGState(currentContext);
    CGContextSetFillColorWithColor(currentContext, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(currentContext, strokeColor.CGColor);
    CGRect insetRect = CGRectInset(rect, 0.5f, 0.5f);
    CGRect outOfBoundsRect = CGRectMake(insetRect.origin.x, insetRect.origin.y - lineWidth , insetRect.size.width, insetRect.size.height + lineWidth);
    UIBezierPath* roundedPath = [UIBezierPath bezierPathWithRoundedRect:outOfBoundsRect byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(radius, radius)];
    CGContextClipToRect(currentContext, insetRect);
    [roundedPath addClip];
    [roundedPath setLineWidth:lineWidth];
    [roundedPath fill];
    [roundedPath stroke];
    
    CGContextRestoreGState(currentContext);
    
}

+ (void)drawBottomOfRectInRect:(CGRect)rect
                          withContext:(CGContextRef)currentContext
                          strokeColor:(UIColor*)strokeColor
                            fillColor:(UIColor*)fillColor
                            lineWidth:(CGFloat)lineWidth
{
    CGContextSaveGState(currentContext);
    CGContextSetFillColorWithColor(currentContext, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(currentContext, strokeColor.CGColor);
    CGRect insetRect = CGRectInset(rect, 0.5f, 0.5f);
    CGRect outOfBoundsRect = CGRectMake(insetRect.origin.x, insetRect.origin.y - lineWidth , insetRect.size.width, insetRect.size.height + lineWidth);
    UIBezierPath* rectPath = [UIBezierPath bezierPathWithRect:outOfBoundsRect];
    CGContextClipToRect(currentContext, insetRect);
    [rectPath addClip];
    [rectPath setLineWidth:lineWidth];
    [rectPath fill];
    [rectPath stroke];
    
    CGContextRestoreGState(currentContext);
    
}
@end
