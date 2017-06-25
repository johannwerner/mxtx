//
//  MapViewModel.m
//  mxtaxi
//
//  Created by Johann Werner on 25.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "MapViewModel.h"

@implementation MapViewModel

- (id)initWithCarModels:(NSArray*)carModels {
    self = [super init];
    if (self) {
        self.carModels = carModels;
    }
    return self;
}

@end
