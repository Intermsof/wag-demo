//
//  HomeModel.h
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#ifndef HomeModel_h
#define HomeModel_h


@interface HomeModel : NSObject
- (instancetype)init;
@property NSArray *users;

- (BOOL) hasUsers;

@end
#endif /* HomeModel_h */
