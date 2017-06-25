//
//  CarListViewModel.h
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CarListModel;

@interface CarListViewModel : NSObject

@property(strong, nonatomic) CarListModel *carListModel;

- (void)fetchListCompletion:(void (^)(CarListModel *carListModel,
                                      NSError *error))completion;

@end
