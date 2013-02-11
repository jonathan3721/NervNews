//
//  LBNMapAnnotation.h
//  Nerv
//
//  Created by Jonathan Long on 2/5/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface LBNMapAnnotation : NSObject <MKAnnotation>
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
