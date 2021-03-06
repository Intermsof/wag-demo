//
//  HomeModel.m
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

@interface HomeModel()

@end

@implementation HomeModel

@synthesize users;

- (instancetype)init{
    self = [super init];
    self.users = [NSMutableArray array];
    return self;
};

- (BOOL) hasUsers {
    return users.count != 0;
}

@end

