//
//  Header.h
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#ifndef User_h
#define User_h

#include <UIKit/UIKit.h>

//Simple User model

@interface User : NSObject

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
                       userID : (NSNumber *) userID;

@property UIImage *gravatar;
@property NSString *name;
@property NSString *stackProfile;
@property NSString *profileImage;
@property NSString *userType;
@property NSNumber *gold;
@property NSNumber *silver;
@property NSNumber *bronze;
@property NSNumber *reputation;
@property NSNumber *userID;

//optionals
@property NSString *location;
@property NSString *website;

@end

#endif /* User_h */
