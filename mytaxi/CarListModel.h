//
//  CarListModel.h
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarListModel : NSObject

@property(strong, nonatomic) NSArray *carListArray;

- (id)initWithArray:(NSArray *)array;

@end
