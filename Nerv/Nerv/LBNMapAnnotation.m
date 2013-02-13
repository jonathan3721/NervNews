//
//  LBNMapAnnotation.m
//  Nerv
//
//  Created by Jonathan Long on 2/5/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNMapAnnotation.h"
@interface LBNMapAnnotation()
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation LBNMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate{
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
    }
    
    return self;
}

@end
