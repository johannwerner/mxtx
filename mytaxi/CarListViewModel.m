//
//  CarListViewModel.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "CarListViewModel.h"
#import "API.h"
#import "CarListModel.h"

@implementation CarListViewModel

- (void)fetchListCompletion:(void (^)(CarListModel *carListModel,
                                      NSError *error))completion {
    [API fetchListWithBrochuresCompletion:^(CarListModel *carListModel,
                                            NSError *error) {
        self.carListModel = carListModel;
        completion(carListModel, error);
    }];
}


@end
