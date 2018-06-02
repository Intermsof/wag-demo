//
//  User.m
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface User()

@end

@implementation User

- (instancetype) initWithName : (NSString *) name
                 stackProfile : (NSString *) stackProfile
                 profileImage : (NSString *) profileImage
                     userType : (NSString *) userType
                     location : (NSString *) location
                      website : (NSString *) website
                         gold : (NSNumber *) gold
                       silver : (NSNumber *) silver
                       bronze : (NSNumber *) bronze
                   reputation : (NSNumber *) reputation
                       userID : (NSNumber *) userID{
    self = [super init];
    _website = website;
    _location = location;
    _name = name;
    _stackProfile = stackProfile;
    _profileImage = profileImage;
    _userType = userType;
    _gold = gold;
    _silver = silver;
    _bronze = bronze;
    _reputation = reputation;
    _userID = userID;
    _gravatar = nil;
    return self;
};


@end

