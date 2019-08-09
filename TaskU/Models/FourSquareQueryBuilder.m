//
//  LocationQueryBuilder.m
//  TaskU
//
//  Created by rhaypapenfuzz on 8/7/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "FourSquareQueryBuilder.h"

NSString *const kClientIDKey = @"client_id";
NSString *const kClientSecretKey = @"client_secret";
NSString *const kVenueKey = @"v";
NSString *const kNearKey = @"near";
NSString *const kQueryKey = @"query";
NSString *const kBaseURLString = @"https://api.foursquare.com/v2/venues/search?";

@implementation FourSquareQueryBuilder
{
NSMutableDictionary *queryMap;
NSMutableString *queryString;

}

- (instancetype)initWithClientID:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCity:(NSString *)city withState:(NSString *)state withVenue:(NSString *)venue {
    
    if (self = [super init]) {
        queryMap = [[NSMutableDictionary alloc] init];
        [queryMap setObject: clientID forKey:kClientIDKey];
        [queryMap setObject: clientSecret forKey:kClientSecretKey];
        [self setNearWithCity:city state:state];
        [queryMap setObject: venue forKey:kVenueKey];
    }
    return self;
}

- (void)setQuery:(NSString *)query {
     queryMap[kQueryKey] = query;
}

- (void)setNearWithCity:(NSString *)city state:(NSString *)state
{
    queryMap[kNearKey] = [NSString stringWithFormat:@"%@,%@",city,state];
}

- (NSString *) buildQueryString {
    queryString = [[NSMutableString alloc] init];
    for (NSString *key in queryMap.allKeys) {
        NSString *temp = [queryString stringByAppendingString:
         [NSString stringWithFormat:@"%@=%@&", key, queryMap[key]]];
        queryString = [temp mutableCopy];
    }
    NSString *temp = [queryString substringToIndex:[queryString length]-1];
    queryString = [temp mutableCopy];
    
    return queryString;
}


- (NSURL *)getQueryUrl{
    NSString *baseURLString = @"https://api.foursquare.com/v2/venues/search?";
    [self buildQueryString];
    queryString = [[queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] mutableCopy];
    NSURL *url = [NSURL URLWithString:[baseURLString stringByAppendingString:queryString]];
    return url;
}
                                  
@end

