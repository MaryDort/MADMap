//
//  MADLocationSearchTableViewController.h
//  MADMap
//
//  Created by Mariia Cherniuk on 20.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface MADLocationSearchTableViewController : UITableViewController <UISearchResultsUpdating>

@property (strong, nonatomic, readwrite) MKMapView *mapView;

@end
