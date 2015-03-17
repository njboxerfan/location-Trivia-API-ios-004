//
//  FISLocationsDataStore.h
//  locationTrivia-dataStore
//
//  Created by Joe Burgess on 6/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISConstants.h"
#import "FISLocation.h"
#import "FISTrivia.h"

@interface FISLocationsDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *locations;

+ (instancetype)sharedLocationsDataStore;

- (instancetype)init;

-(void)getLocations:(void (^)(void))completionBlock;

-(void)saveLocation:(FISLocation *)newLocation;

-(void)deleteLocation:(FISLocation *)newLocation withCompletion:(void (^)(void))completionBlock;

+(void)saveTrivia:(FISTrivia *)newTrivia forLocation:(FISLocation *)location;

+(void)deleteTrivia:(FISTrivia *)trivia forLocation:(FISLocation *)location withCompletion:(void (^)(void))completionBlock;

@end
