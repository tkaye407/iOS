//
//  ConnectExampleFacade.m
//  ConnectExample
//
//  Created by Sharma, Akhilesh on 6/16/16.
//  Copyright © 2016 Sharma, Akhilesh. All rights reserved.
//

#import "ConnectExampleFacade.h"
#import "ConnectExampleBaseModel.h"

@implementation ConnectExampleFacade

+ (id) sharedManager {
    static ConnectExampleFacade *facadeObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        facadeObject = [[ConnectExampleFacade alloc] init];
    });
    
    
    
    return facadeObject;
}

- (void) connectToService:(NSURL *) urlObject withBlock:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completionHandler{
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //Create the Model Objects.
    if(urlObject != nil) {
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL: urlObject completionHandler:completionHandler];
        [dataTask resume];

    } else {
        NSLog(@"URL Object is empty");
    }
}

@end
