//
//  CarModel.h
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *engineType;
@property (strong, nonatomic) NSString *exterior;
@property (strong, nonatomic) NSString *interior;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic)  NSNumber *longitude;
@property (strong, nonatomic)  NSNumber *latitude;

- (id)initWithDictionary:(NSDictionary *)attributes;

@end
