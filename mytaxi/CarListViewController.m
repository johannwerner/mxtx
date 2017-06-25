//
//  ViewController.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "CarListViewController.h"
#import "CarListViewModel.h"
#import "CarListModel.h"
#import "CarTableViewCell.h"
#import "CarModel.h"
#import "UIStoryboard+StoryboardManager.h"
#import "MapViewController.h"
#import "UIViewController+Alerts.h"
#import "UIColor+ColorManager.h"
#import "MapViewModel.h"

@interface CarListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *carListTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property(strong, nonatomic) CarListViewModel *carListViewModel;

@end

@implementation CarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"CarTableViewCell" bundle:nil];
    
    [self.carListTableView registerNib:cellNib forCellReuseIdentifier:@"CarTableViewCell"];
    
    self.carListViewModel = [[CarListViewModel alloc] init];
    
    self.title = NSLocalizedString(@"VehiclesKey", nil);
    
    self.carListTableView.dataSource = self;
    self.carListTableView.delegate = self;

    UIBarButtonItem *mapViewButton = [[UIBarButtonItem alloc]
                                      initWithTitle:NSLocalizedString(@"MapViewKey", nil)
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(showMapView)];
    self.navigationItem.rightBarButtonItem = mapViewButton;
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.activityIndicator.color = [UIColor mainThemeColor];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor mainThemeColor];
    [self.refreshControl addTarget:self
                            action:@selector(getData)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.carListTableView addSubview:self.refreshControl];
    
    [self getData];
}

- (void)getData {
    CarListViewController*__weak weakSelf = self;
    
    [self.activityIndicator startAnimating];
    [self.carListViewModel
     fetchListCompletion:^(CarListModel *carListModel, NSError *error) {
         
         if (!error) {
             weakSelf.carListViewModel.carListModel = carListModel;
             [weakSelf.carListTableView reloadData];
         } else {
             [weakSelf displayAlertWithMessage:error.localizedDescription];
         }
         [weakSelf.refreshControl endRefreshing];
         [weakSelf.activityIndicator stopAnimating];
         
     }];
}

#pragma mark - CarListTableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carListViewModel.carListModel.carListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarTableViewCell" forIndexPath:indexPath];
    CarModel *carModel = self.carListViewModel.carListModel.carListArray[(NSUInteger) indexPath.row];
    cell.addressLabel.text = carModel.address;
    cell.interiorLabel.text = [NSString stringWithFormat:NSLocalizedString(@"InteriorKey", nil),carModel.interior];
    cell.exteriorLabel.text = [NSString stringWithFormat:NSLocalizedString(@"ExteriorKey", nil),carModel.exterior];
    cell.engineTypeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"EngineTypeKey", nil),carModel.engineType];
    cell.licensePlateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"NameKey", nil),carModel.name];
    return cell;
}

#pragma mark - CarListTableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapViewController* mapViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"MapViewController"];
    CarModel *carModel = self.carListViewModel.carListModel.carListArray[(NSUInteger) indexPath.row];
    MapViewModel *mapViewModel = [[MapViewModel alloc] initWithCarModels:@[carModel]];
    mapViewModel.mapType = MapTypeShowCarLocation;
    mapViewModel.navigationBarTitle = carModel.name;
    mapViewController.mapViewModel = mapViewModel;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Show Map View

- (void)showMapView {
    MapViewController* mapViewController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"MapViewController"];
    MapViewModel *mapViewModel = [[MapViewModel alloc] initWithCarModels:self.carListViewModel.carListModel.carListArray];
    mapViewModel.mapType = MapTypeShowUserLocation;
    mapViewModel.navigationBarTitle = NSLocalizedString(@"MapViewKey", nil);
    mapViewController.mapViewModel = mapViewModel;
    [self.navigationController pushViewController:mapViewController animated:YES];
}


@end
