//
//  MapViewModel.h
//  mxtaxi
//
//  Created by Johann Werner on 25.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"

typedef NS_ENUM(NSUInteger, MapType) {
    MapTypeShowUserLocation,
    MapTypeShowCarLocation
};

@interface MapViewModel : NSObject

@property (strong, nonatomic) NSArray *carModels;
@property (nonatomic) enum MapType mapType;
@property (nonatomic, assign) NSString *navigationBarTitle;

- (id)initWithCarModels:(NSArray*)carModels;

@end
