//
//  LBNLabelCollectionViewCell.m
//  Nerv
//
//  Created by Jonathan Long on 1/26/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNLabelCollectionViewCell.h"
#import "LBNGraphics.h"

@implementation LBNLabelCollectionViewCell

- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    switch (self.position) {
        case LBNCollectionViewCellPositionTop:
            [LBNGraphics drawTopOfRoundedRectInRect:rect
                                        withContext:currentContext
                                       cornerRadius:10.0f
                                        strokeColor:RGBA(60.0f, 179.0f ,113.0f, 0.25f)
                                          fillColor:RGB(247.0f, 247.0f, 247.0f)
                                          lineWidth:1.0f];
            break;
        case LBNCollectionViewCellPositionMiddle:
            [LBNGraphics drawBottomOfRectInRect:rect
                                    withContext:currentContext
                                    strokeColor:RGBA(60.0f, 179.0f ,113.0f, 0.25f)
                                      fillColor:RGB(247.0f, 247.0f, 247.0f)
                                      lineWidth:1.0f];
            
            break;
        case LBNCollectionViewCellPositionBottom:
            [LBNGraphics drawBottomOfRoundedRectInRect:rect
                                           withContext:currentContext
                                          cornerRadius:10.0f
                                           strokeColor:RGBA(60.0f, 179.0f, 113.0f, 0.25f)
                                             fillColor:RGB(247.0f, 247.0f, 247.0f)
                                             lineWidth:1.0f];
            break;
        default:
            [LBNGraphics drawTopOfRoundedRectInRect:rect
                                        withContext:currentContext
                                       cornerRadius:10.0f
                                        strokeColor:RGBA(60.0f, 179.0f ,113.0f, 0.25f)
                                          fillColor:RGB(247.0f, 247.0f, 247.0f)
                                          lineWidth:1.0f];
            break;
    }
    
    
}
@end
