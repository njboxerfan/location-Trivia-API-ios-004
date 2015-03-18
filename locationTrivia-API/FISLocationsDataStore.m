//
//  FISLocationsDataStore.m
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISLocationsDataStore.h"
#import "FISTriviaAPIClient.h"
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
    [FISTriviaAPIClient getLocationsWithCompletion:^(NSArray *locationDictionaries) {
        
        for ( NSDictionary *locationDictionary in locationDictionaries )
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
    }];
}

-(void)saveLocation:(FISLocation *)newLocation
{
    [FISTriviaAPIClient saveLocation:newLocation withCompletion:^(NSDictionary *responseObject) {
        
        NSDictionary *response = responseObject;
        
        newLocation.locationID = response[@"id"];
        
        [self.locations addObject:newLocation];
        
        //notify FISLocationsTableViewController
        [[NSNotificationCenter defaultCenter] postNotificationName:@"locationReload" object:nil];
    }];
}

-(void)deleteLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock
{
    [FISTriviaAPIClient deleteLocation:location withCompletion:^{
        
        [self.locations removeObject:location];
        
        completionBlock();
    }];
}

+(void)saveTrivia:(FISTrivia *)newTrivia forLocation:(FISLocation *)location
{
    [FISTriviaAPIClient saveTrivia:newTrivia forLocation:location withCompletion:^(NSDictionary *responseObject) {
        
        NSDictionary *response = responseObject;
        
        newTrivia.triviaID = response[@"id"];
        
        [location.trivia addObject:newTrivia];
        
        //notify FISTriviaTableViewController
        [[NSNotificationCenter defaultCenter] postNotificationName:@"triviaReload" object:nil];
    }];
}

+(void)deleteTrivia:(FISTrivia *)trivia forLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock
{
    [FISTriviaAPIClient deleteTrivia:trivia forLocation:location withCompletion:^ {
        
        [location.trivia removeObject:trivia];
        
        completionBlock();
    }];
}

@end
