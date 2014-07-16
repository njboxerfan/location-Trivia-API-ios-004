//
//  FISLocation.m
//  locationTrivia-Objects
//
//  Created by Joe Burgess on 5/15/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISLocation.h"

@implementation FISLocation

-(id)initWithName:(NSString *)name Latitude:(NSNumber *)latitude Longitude:(NSNumber *)longitude
{
    self = [super init];
    if (self) {
        _name=name;
        _latitude=latitude;
        _longitude=longitude;
        _trivia = [[NSMutableArray alloc] init];
    }

    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" Latitude:@0 Longitude:@0];
}

- (NSString *)shortenedNameToLength:(NSInteger)length
{
    if (length <0) {
        return self.name;
    }
    return [self.name substringToIndex:length];
}


-(BOOL)verifyLocation
{
    CGFloat lat = [self.latitude floatValue];
    CGFloat lng = [self.longitude floatValue];

    BOOL validLat = lat>=-90.0 && lat <=90.0;
    BOOL validLng = lng>=-180.0 && lng <=180.0;

    if (![self.name isEqualToString:@""]&& validLat && validLng) {
        return YES;
    }
    return NO;
}

- (FISTrivia *)topTrivia
{
    if ([self.trivia count]==0) {
        return nil;
    }
    FISTrivia *topTrivia = self.trivia[0];
    for (FISTrivia *trivium in self.trivia) {
        if (topTrivia.likes < trivium.likes) {
            topTrivia = trivium;
        }
    }
    return topTrivia;
}

-(NSString *)numberOfTriva
{
    return [NSString stringWithFormat:@"%d", [self.trivia count]];
}

@end
