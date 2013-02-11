//
//  LBNTwitterClient.h
//  Nerv
//
//  Created by Jonathan Long on 1/28/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBNTwitterClient : NSObject
+ (void)twitterSearchWithQuery:(NSString*)query andCompletion:( void(^)(NSArray* tweets) )completion andFailure:( void(^)(NSError* error) )failure;

@end
