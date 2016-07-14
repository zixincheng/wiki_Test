//
//  ApiWrapper.m
//  WikiTest
//
//  Created by zixin cheng on 2016-07-07.
//  Copyright © 2016 zixin. All rights reserved.
//

#import "ApiWrapper.h"

@implementation ApiWrapper

-(void) getArticle:(NSString *)keywords callback: (void (^) (NSArray * responseData)) callback{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *newkey = encodeByAddingPercentEscapes(keywords);
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=%@",newkey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            callback(NULL);
        } else {
            callback(responseObject);
            //NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

static NSString *encodeByAddingPercentEscapes(NSString *input) {
    NSString *encodedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                   kCFAllocatorDefault, (CFStringRef) input, NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8));
    return encodedValue;
}


@end
