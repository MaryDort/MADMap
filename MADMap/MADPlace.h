//
//  MADPlace.h
//  MADMap
//
//  Created by Mariia Cherniuk on 20.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface MADPlace : NSObject <MKAnnotation>

@property (copy, nonatomic, readwrite) NSString *title;
@property (assign, nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate;


@end
