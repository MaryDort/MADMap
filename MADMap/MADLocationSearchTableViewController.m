//
//  MADLocationSearchTableViewController.m
//  MADMap
//
//  Created by Mariia Cherniuk on 20.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADLocationSearchTableViewController.h"
#import "MADPlace.h"

@interface MADLocationSearchTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tabelView;
@property (strong, nonatomic, readwrite) NSArray *objects;
@property (strong, nonatomic, readwrite) CLGeocoder *geocoder;
@property (strong, nonatomic, readwrite) NSMutableSet *annotations;
@property (strong, nonatomic, readwrite) MADPlace *annotation;
@property (strong, nonatomic, readwrite) CLPlacemark *placemark;
@property (assign, nonatomic, readwrite) CLLocationDistance regionRadius;
@property (strong, nonatomic, readwrite) CLLocation *initialLocation;

@end

@implementation MADLocationSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabelView.backgroundColor = [UIColor clearColor];
    _annotations = [[NSMutableSet alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    _placemark = _objects[indexPath.row];
    
    cell.textLabel.text = _placemark.name;
    cell.detailTextLabel.text = [self parseAddress];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_mapView removeAnnotation:_annotation];
    [self configureMap];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_geocoder geocodeAddressString:searchController.searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", [error description]);
        } else {
            _objects = placemarks;
            
            [_tabelView reloadData];
        }
    }];
}

#pragma mark - Private

- (NSString *)parseAddress {
    NSMutableArray *address = [[NSMutableArray alloc] init];
    
    if (_placemark.subThoroughfare) {
        [address addObject:[NSString stringWithFormat:@"%@", _placemark.subThoroughfare]];
    }
    if (_placemark.thoroughfare) {
        [address addObject:[NSString stringWithFormat:@"%@", _placemark.thoroughfare]];
    }
    
    if (_placemark.locality) {
        [address addObject:[NSString stringWithFormat:@"%@", _placemark.locality]];
    }
    if (![_placemark.administrativeArea isEqualToString:_placemark.locality] && _placemark.administrativeArea) {
        [address addObject:[NSString stringWithFormat:@"%@", _placemark.administrativeArea]];
    }
    
    if (address.count == 0) {
        return @"";
    }
    
    return [address componentsJoinedByString:@", "];
}

- (void)configureMap {
    _annotation = [[MADPlace alloc] initWithTitle:_placemark.name coordinate:_placemark.location.coordinate];
    _initialLocation = _placemark.location;
    _regionRadius = _placemark.region.radius;
    
    [self showRegion];
    [_mapView addAnnotation:_annotation];
}

- (void)showRegion {
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(_initialLocation.coordinate, _regionRadius * 2, _regionRadius * 2);
    
    _mapView.region = coordinateRegion;
}

@end
