//
//  Header.h
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#ifndef User_h
#define User_h

@interface User : NSObject
- (instancetype)init;

//The Constructor takes in parameters that are guarenteed by the API to exist,
//While optional parameters should be set manually
- (void)setupWithName : (NSString *) name
         stackProfile : (NSString *) stackProfile
         profileImage : (NSString *) profileImage
             userType : (NSString *) userType
                 gold : (NSNumber *) gold
               silver : (NSNumber *) silver
               bronze : (NSNumber *) bronze
           reputation : (NSNumber *) reputation
               userID : (NSNumber *) userID;

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
