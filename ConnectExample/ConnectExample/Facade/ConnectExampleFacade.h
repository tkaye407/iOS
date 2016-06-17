//
//  ConnectExampleFacade.h
//  ConnectExample
//
//  Created by Sharma, Akhilesh on 6/16/16.
//  Copyright © 2016 Sharma, Akhilesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectExampleBaseModel.h"

@interface ConnectExampleFacade : NSObject

+ (id) sharedManager;
- (void) connectToService:(NSURL *) urlObject withBlock:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completionHandler;
@end
