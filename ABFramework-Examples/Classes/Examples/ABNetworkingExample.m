//
//  ABNetworkingExample.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 4/1/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABNetworkingExample.h"

@interface ABNetworkingExample ()

@end

@implementation ABNetworkingExample

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
   // Simple GET request expecting JSON response
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/repos/ablfx/ABFramework"];
    
    [ABNetworking jsonRequestWithUrl:url post:nil completion:^(id response, NSInteger statusCode, NSDictionary *header, ABNetworkingError error) {
        
        if (error == ABNetworkingErrorNone)
        {
            ABLogInteger(statusCode);
            ABLogNSString(header);
            ABLogNSString(response);
        }
        else
        {
            ABLogNSString(@"Error occured");
        }
        
    }];
    
//    [ABNetworking performDownloadRequestWithUrl:@"http://ablfx.com/images/pastrypanic.png" postData:nil progress:^(NSInteger progress) {
//        //ABLogInteger(progress);
//    } completion:^(id response, NSInteger statusCode, NSDictionary *header, ABNetworkingError error) {
//        //
//        //ABLogInteger(statusCode);
//        //ABLogNSString(header);
//        ABLogNSString(response);
//        
//        if (error == ABNetworkingErrorNone)
//        {
//            [ABFileHelper movePath:response toPath:[ABFileHelper pathForFile:[response lastPathComponent] atPathInDocumentsFolder:@""]];
//        }
//        
//    }];
}

@end
