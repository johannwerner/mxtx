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
    
    /* NSURLRequest objects represent a URL load request in a manner independent of protocol and URL scheme.
     NSURLRequest encapsulates two basic data elements of a load request: the URL to load, and the policy to use 
     when consulting the URL content cache made available by the implementation.
     */
    NSString *endpoint = [NSString
                          stringWithFormat:@"%@%@", APIBaseURL, @"/car2go/vehicles.json"];
    [request setURL:[NSURL URLWithString:endpoint]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    /*
     The NSURLSession class and related classes provide an API for downloading content. 
     This API provides a rich set of delegate methods for supporting authentication and gives
     your app the ability to perform background downloads when your app is not running or, in iOS, while your app is suspended.
     
     An NSURLSessionConfiguration object defines the behavior and policies to use when uploading and downloading data using an
     
     NSURLSession
     object. When uploading or downloading data, creating a configuration object is always the first step you must take. You 
     use this object to configure the timeout values, caching policies, connection requirements, and other types of information
     that you intend to use with your NSURLSession object.
     
     An ephemeral session configuration object is similar to a default session configuration object except that the corresponding 
     session object does not store caches, credential stores, or any session-related data to disk. Instead, session-related data 
     is stored in RAM. The only time an ephemeral session writes data to disk is when you tell it to write the contents of a URL to a file.
     
     

     */
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration
                                            defaultSessionConfiguration]]; // Creates a session with the specified session configuration.
    
    /*
     Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
     
     
     */
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response,
                                    NSError *error) { /*The NSURLResponse class encapsulates the metadata associated with the response
                                                       to a a URL load request in a manner independent of protocol and URL scheme.*/
                    if (data != nil) {
                        NSDictionary *responseDictionary = //You use the NSJSONSerialization class to convert JSON to Foundation objects
                        
                        /* why kNilOptions
                         
                         NSJSONReadingMutableContainers
                         Specifies that arrays and dictionaries are created as mutable objects.
                         NSJSONReadingMutableLeaves
                         Specifies that leaf strings in the JSON object graph are created as instances of NSMutableString.
                         NSJSONReadingAllowFragments
                         Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary.
                         
                         */
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


/*&error
 
 NSError's fields are not settable. its interface is opaque and immutable. therefore, if you were to alloc/init an error, 
 the client could not populate it. thus, the approach is to return a new error (if applicable), also saving you from 
 allocs in every case.
 
 since the return type is already specified by the method, and the error is optional, it makes sense to take this 
 approach to returning the error in idiomatic c syntax.
 
 iow, the client may neither mutate what you pass nor return the error using :(NSError *)outError, 
 so the "out parameter" form :(NSError**)outError is applied.
 
 */



@end
