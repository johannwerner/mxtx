//
//  API.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "API.h"
#import "Constants.h"
#import "CarListModel.h"

@implementation API

+ (void)fetchListWithCarsCompletion:(void (^)(CarListModel *response,
                                                   NSError *error))completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *endpoint = [NSString
                          stringWithFormat:@"%@%@", APIBaseURL, @"/car2go/vehicles.json"];
    [request setURL:[NSURL URLWithString:endpoint]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration
                                            defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response,
                                    NSError *error) {
                    if (data != nil) {
                        NSDictionary *responseDictionary =
                        [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:&error];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            CarListModel *carListModel = [[CarListModel alloc]
                                                        initWithArray:responseDictionary[@"placemarks"]];
                            completion(carListModel, error);
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(nil, error);
                        });
                    }
                }] resume];
}



@end
