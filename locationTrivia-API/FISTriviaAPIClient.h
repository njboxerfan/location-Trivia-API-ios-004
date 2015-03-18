//
//  FISGithubAPIClient.h
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISLocation.h"

NSString *const GITHUB_API_URL;

@interface FISTriviaAPIClient : NSObject

///---------------------
/// @name Class Methods
///---------------------

+(void)getLocationsWithCompletion:(void (^)(NSArray *locationDictionaries))completionBlock;
+(void)saveLocation:(FISLocation *)newLocation withCompletion:(void (^)(NSDictionary *responseObject))completionBlock;
+(void)deleteLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock;
+(void)saveTrivia:(FISTrivia *)newTrivia forLocation:(FISLocation *)location withCompletion:(void (^)(NSDictionary *responseObject))completionBlock;
+(void)deleteTrivia:(FISTrivia *)trivia forLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock;

@end
