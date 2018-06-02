//
//  HomeModel.h
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#ifndef HomeModel_h
#define HomeModel_h

//Simple home model with only an array of user.
//Can be expanded as page become more complicated.

@interface HomeModel : NSObject
- (instancetype)init;
@property NSMutableArray *users;

- (BOOL) hasUsers;

@end
#endif /* HomeModel_h */
