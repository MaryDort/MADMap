//
//  MADStartViewController.m
//  MADMap
//
//  Created by Mariia Cherniuk on 20.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADStartViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MADLocationSearchTableViewController.h"

@interface MADStartViewController () <UISearchBarDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic, readwrite) CLLocationManager *locationManager;
@property (strong, nonatomic, readwrite) UISearchController *searchController;
@property (strong, nonatomic, readwrite) UISearchBar *searchBar;
@property (strong, nonatomic, readwrite) MADLocationSearchTableViewController *resultSearchController;

@end

@implementation MADStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    
    _resultSearchController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MADLocationSearchTableViewController"];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultSearchController];
    _searchController.searchResultsUpdater = _resultSearchController;
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    self.definesPresentationContext = YES;
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar = _searchController.searchBar;
    _searchBar.placeholder = @"Search for places";
    _resultSearchController.mapView = _mapView;
    self.navigationItem.titleView = _searchBar;
}

@end
