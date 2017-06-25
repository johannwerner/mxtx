//
//  API.h
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarListModel;

@interface API : NSObject

+ (void)fetchListWithCarsCompletion:(void (^)(CarListModel *response,
                                                   NSError *error))completion;

@end
