//
//  FISGithubAPIClient.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISTriviaAPIClient.h"
#import "FISConstants.h"
#import <AFNetworking.h>

@implementation FISTriviaAPIClient

+(void)getLocationsWithCompletion:(void (^)(NSArray *))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations.json?key=%@",TRIVIA_API_URL,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:triviaURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //NSLog(@"%@", responseObject);
         
         completionBlock(responseObject);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

+(void)saveLocation:(FISLocation *)newLocation withCompletion:(void (^)(NSDictionary *responseObject))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations.json?key=%@",TRIVIA_API_URL,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"location[name]":newLocation.name,
                                 @"location[latitude]":newLocation.latitude,
                                 @"location[longitude]":newLocation.longitude};
    
    [manager POST:triviaURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //NSLog(@"%@", responseObject);
         
         completionBlock(responseObject);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

+(void)deleteLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations/%@.json?key=%@",TRIVIA_API_URL,location.locationID,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager DELETE:triviaURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         completionBlock();
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

+(void)saveTrivia:(FISTrivia *)newTrivia forLocation:(FISLocation *)location withCompletion:(void (^)(NSDictionary *responseObject))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations/%@/trivia.json?key=%@",TRIVIA_API_URL,location.locationID,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"trivium[content]":newTrivia.content};
    
    [manager POST:triviaURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //NSLog(@"%@", responseObject);
         
         completionBlock(responseObject);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

+(void)deleteTrivia:(FISTrivia *)trivia forLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations/%@/trivia/%@.json?key=%@",TRIVIA_API_URL,location.locationID,trivia.triviaID,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager DELETE:triviaURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         completionBlock();
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

@end
