//
//  Constants.h
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//The id for UserTableCell reuse
extern NSString *USER_CELL_ID;

//The URL for the stackoverflow api broken into two parts
//Make a complete URL using [NSString stringWithFormat: @"%@%d%@",APIUSERBEGIN, pageNumber, APIUSEREND]
extern NSString *API_USER_BEGIN;
extern NSString *API_USER_END;

//Key for getting the users array
extern NSString *KEY_FOR_ITEMS;

//Keys for parsing a user
extern NSString *KEY_FOR_NAME;
extern NSString *KEY_FOR_BADGES;
extern NSString *KEY_FOR_STACKOVERFLOW_LINK;
extern NSString *KEY_FOR_WEBSITE;
extern NSString *KEY_FOR_LOCATION;
extern NSString *KEY_FOR_GOLD;
extern NSString *KEY_FOR_SILVER;
extern NSString *KEY_FOR_BRONZE;
extern NSString *KEY_FOR_REPUTATION;
extern NSString *KEY_FOR_USERID;
extern NSString *KEY_FOR_USER_TYPE;
extern NSString *KEY_FOR_PROFILE_IMAGE_LINK;


//Relative path from home to the folder containing cached images
extern NSString *PATH_TO_IMAGES;

//PI
extern float PI;

#endif /* Constants_h */
