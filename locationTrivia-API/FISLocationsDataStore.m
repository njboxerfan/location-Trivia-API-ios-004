//
//  FISLocationsDataStore.m
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISLocationsDataStore.h"
#import <AFNetworking.h>

@implementation FISLocationsDataStore


+ (instancetype)sharedLocationsDataStore {
    static FISLocationsDataStore *_sharedLocationsDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationsDataStore = [[FISLocationsDataStore alloc] init];
    });

    return _sharedLocationsDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locations = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)getLocations:(void (^)(void))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations.json?key=%@",TRIVIA_API_URL,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:triviaURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        //NSLog(@"%@", responseObject);
        for ( NSDictionary *locationDictionary in responseObject )
        {
            FISLocation *location = [[FISLocation alloc] initWithName:locationDictionary[@"name"]
                                                              Latitude:locationDictionary[@"latitude"]
                                                             Longitude:locationDictionary[@"longitude"]];
            
            location.locationID = locationDictionary[@"id"];
            
            for ( NSDictionary *triviaDictionary in locationDictionary[@"trivia"] )
            {
                FISTrivia *trivia = [[FISTrivia alloc] initWithContent:triviaDictionary[@"content"] Likes:0];
                
                [location.trivia addObject:trivia];
            }
            
            [self.locations addObject:location];
        }
        
        completionBlock();
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

-(void)saveLocation:(FISLocation *)newLocation
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations.json?key=%@",TRIVIA_API_URL,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"location[name]":newLocation.name,
                                 @"location[latitude]":newLocation.latitude,
                                 @"location[longitude]":newLocation.longitude};
    
    [manager POST:triviaURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //NSLog(@"%@", responseObject);
         NSDictionary *response = responseObject;
         
         newLocation.locationID = response[@"id"];
         
         [self.locations addObject:newLocation];
         
         //notify FISLocationsTableViewController
         [[NSNotificationCenter defaultCenter] postNotificationName:@"locationReload" object:nil];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

-(void)deleteLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations/%@.json?key=%@",TRIVIA_API_URL,location.locationID,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager DELETE:triviaURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        [self.locations removeObject:location];

        completionBlock();
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+(void)saveTrivia:(FISTrivia *)newTrivia forLocation:(FISLocation *)location
{
    NSString *triviaURL = [NSString stringWithFormat:@"%@/locations/%@/trivia.json?key=%@",TRIVIA_API_URL,location.locationID,TRIVIA_API_KEY];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"trivium[content]":newTrivia.content};
    
    [manager POST:triviaURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //NSLog(@"%@", responseObject);
         NSDictionary *response = responseObject;
         
         newTrivia.triviaID = response[@"id"];
         
         [location.trivia addObject:newTrivia];
         
         //notify FISTriviaTableViewController
         [[NSNotificationCenter defaultCenter] postNotificationName:@"triviaReload" object:nil];
         
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
         [location.trivia removeObject:trivia];
         
         completionBlock();
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

@end
