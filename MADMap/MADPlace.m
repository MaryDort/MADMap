//
//  MADPlace.m
//  MADMap
//
//  Created by Mariia Cherniuk on 20.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADPlace.h"

@implementation MADPlace

- (instancetype)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    
    if (self) {
        _title = title;
        _coordinate = coordinate;
    }
    
    return self;
}

@end
