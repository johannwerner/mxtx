//
//  CarListModel.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "CarListModel.h"
#import "CarModel.h"

@implementation CarListModel

- (id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        NSMutableArray* carListMutableArray = [@[] mutableCopy];
        for (NSDictionary *dictionary in array) {
            CarModel *carModel =
            [[CarModel alloc] initWithDictionary:dictionary];
            [carListMutableArray addObject:carModel];
        }
        self.carListArray = [carListMutableArray copy];
    }
    return self;
}

@end
