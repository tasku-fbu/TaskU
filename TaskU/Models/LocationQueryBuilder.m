//
//  LocationQueryBuilder.m
//  TaskU
//
//  Created by rhaypapenfuzz on 8/7/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//
/*
#import "LocationQueryBuilder.h"
// [NSString stringWithFormat:@"client_id=%@&client_secret=%@&near=%@,%@&query=%@&v=20141020", clientID, clientSecret, city, state, query]
static NSString * const clientID;  // @"44AMDU33GRCGT1ZOPZAQDAG422E3AB4W51SNGHVF4WHEHUYG";
static NSString * const clientSecret;  //@"QUZTBM11UBAHE1KQVBISIF4CB1OWALMODUWMUCMFSKWNMXVQ";
static NSNumber * const venue = @20141020;

@implementation LocationQueryBuilder
- (instancetype)init {
    if (self = [init]) {
       // clientID = nil;
        //clientSecret = nil;
        self.city = @"";
        self.state = @"";
        self.query = @"";
    }
    return self;
}
@end

- (instancetype)initWithBuilder:(LocationQueryBuilder *)builder {
    if (self = [super init]) {
        self.city = builder.city;
        self.state = builder.state;
        self.query = builder.query;
    }
    return self;
}

- (LocationQueryBuilder *)makeBuilder {
    LocationQueryBuilder *builder = [LocationQueryBuilder new];
    builder.city = self.city;
    builder.state = self.state;
    builder.query = self.query;
    return builder;
}

- (instancetype)init {
    LocationQueryBuilder *builder = [LocationQueryBuilder new];
    return [self initWithBuilder:builder];
}

+ (instancetype)makeWithBuilder:(void (^)(LocationQueryBuilder *))updateBlock {
    LocationQueryBuilder *builder = [LocationQueryBuilder new];
    updateBlock(builder);
    return [[Location alloc] initWithBuilder:builder];
}

- (instancetype)update:(void (^)(LocationQueryBuilder *))updateBlock {
    LocationQueryBuilder *builder = [self makeBuilder];
    updateBlock(builder);
    return [[Location alloc] initWithBuilder:builder];
}
@end
*/
