//
//  LocationQueryBuilder.h
//  TaskU
//
//  Created by rhaypapenfuzz on 8/7/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//
/*
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// [NSString stringWithFormat:@"client_id=%@&client_secret=%@&near=%@,%@&query=%@&v=20141020", clientID, clientSecret, city, state, query]
@interface LocationQueryBuilder : NSObject
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *query;
@property (nonatomic, getter=isAlive) BOOL alive;

- (instancetype)init;
- (instancetype)initWithBuilder:(LocationQueryBuilder *)builder;
+ (instancetype)makeWithBuilder:(void (^)(LocationQueryBuilder *))updateBlock;
- (instancetype)update:(void (^)(LocationQueryBuilder *))updateBlock;
@end

@interface Location
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *query;
@property (nonatomic, readonly, getter = isAlive) BOOL alive;

@end
NS_ASSUME_NONNULL_END
*/
