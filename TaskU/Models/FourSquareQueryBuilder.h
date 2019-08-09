//
//  LocationQueryBuilder.h
//  TaskU
//
//  Created by rhaypapenfuzz on 8/7/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FourSquareQueryBuilder : NSObject

- (instancetype)initWithClientID:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCity:(NSString *)city withState:(NSString *)state withVenue:(NSString *)venue;
- (void)setQuery:(NSString *)query ;

- (NSURL *)getQueryUrl;
@end
NS_ASSUME_NONNULL_END

