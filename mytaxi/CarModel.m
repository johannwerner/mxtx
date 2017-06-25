//
//  CarModel.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

- (id)initWithDictionary:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.address = attributes[@"address"];
        NSArray *coordinates = attributes[@"coordinates"];
        if (coordinates.count > 1) {
            self.longitude = coordinates[0];
            self.latitude = coordinates[1];
        }
        self.engineType = attributes[@"engineType"];
        self.exterior = attributes[@"exterior"];
        self.interior = attributes[@"interior"];
        self.name = attributes[@"name"];
    }
    return self;
}

@end
