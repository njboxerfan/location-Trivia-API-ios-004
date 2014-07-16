//
//  FISTrivia.m
//  locationTrivia-Objects
//
//  Created by Joe Burgess on 5/15/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISTrivia.h"

@implementation FISTrivia

- (id)initWithContent:(NSString *)content Likes:(NSInteger)likes
{
    self = [super init];

    if (self)
    {
        _content = content;
        _likes=likes;
    }

    return self;
}

- (instancetype)init
{
    return [self initWithContent:@"" Likes:0];
}
@end
