//
//  LBNTwitterClient.m
//  Nerv
//
//  Created by Jonathan Long on 1/28/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNTwitterClient.h"
#import <Social/Social.h>

//Base Request URLs
static NSString* const baseSearchURL = @"https://search.twitter.com/search.json";

//Search Keys
static NSString* const TWEET_LIST_KEY = @"results";

//parameters
static NSString* const TWEET_SEARCH_RPP = @"15";

@implementation LBNTwitterClient

+ (void)twitterSearchWithQuery:(NSString*)query andCompletion:( void(^)(NSArray* tweets) )completion andFailure:(void (^)(NSError *))failure{
    NSURL* url = [[NSURL alloc] initWithString:baseSearchURL];
    //http://search.twitter.com/search.json?q=from:#atx since:2013-02-04&rpp=100&include_entities=true&result_type=mixed
    NSString* sinceString = @" since:2013-02-06";
    
    NSDictionary* parameters = @{@"q" :[query stringByAppendingString:sinceString], @"rpp" : TWEET_SEARCH_RPP, @"include_entities" : @"true", @"result_type" : @"mixed"};
    SLRequest* request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:parameters];
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSError* err = nil;
        id responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
        if ([responseObject isKindOfClass:[NSDictionary class]]){
            NSLog(@"%@", (NSDictionary*)responseObject);
            NSDictionary* tweetsDictionary = (NSDictionary*)responseObject;
            
            if (completion) {
                completion(tweetsDictionary[TWEET_LIST_KEY]);
            }
        } else {
            if (failure) {
                failure(error);
            }
        }
        
    }];
}
@end
