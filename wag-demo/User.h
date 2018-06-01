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


@property NSString *name;
@property NSString *stackProfile;
@property NSString *userType;
@property int gold;
@property int silver;
@property int bronze;
@property int reputation;

//optionals
@property NSString *location;

@end

#endif /* User_h */
