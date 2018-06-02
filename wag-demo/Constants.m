//
//  Constants.m
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

//The id for UserTableCell reuse
NSString *USER_CELL_ID = @"userCell";

//The URL for the stackoverflow api broken into two parts
//Make a complete URL using [NSString stringWithFormat: @"%@%d%@",API_USER_BEGIN, pageNumber, API_USER_END]
NSString *API_USER_BEGIN = @"https://api.stackexchange.com/2.2/users?page=";
NSString *API_USER_END = @"&site=stackoverflow";

//Key for getting the users array
NSString *KEY_FOR_ITEMS = @"items";
//Keys for parsing a user
NSString *KEY_FOR_NAME = @"display_name";
NSString *KEY_FOR_BADGES = @"badge_counts";
NSString *KEY_FOR_STACKOVERFLOW_LINK = @"link";
NSString *KEY_FOR_WEBSITE = @"website_url";
NSString *KEY_FOR_GOLD = @"gold";
NSString *KEY_FOR_SILVER = @"silver";
NSString *KEY_FOR_BRONZE = @"bronze";
NSString *KEY_FOR_REPUTATION = @"reputation";
NSString *KEY_FOR_USERID = @"user_id";
NSString *KEY_FOR_USER_TYPE = @"user_type";
NSString *KEY_FOR_PROFILE_IMAGE_LINK = @"profile_image";
NSString *KEY_FOR_LOCATION = @"location";

//Relative path from home to the folder containing cached images
NSString *PATH_TO_IMAGES = @"/Library/Caches/";

//PI
float PI = 3.14159;
