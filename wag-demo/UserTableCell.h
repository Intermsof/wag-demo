//
//  UserTableCell.h
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#ifndef UserTableCell_h
#define UserTableCell_h


/* UserTableCell_h */
#import <UIkit/UIKit.h>
#import "User.h"

@interface UserTableCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
                 reuseIdentifier:(NSString *)reuseIdentifier;

//+ (UIImage *) gravatarLoadAnimation;
+ (UIImage *) goldBadge;
+ (UIImage *) silverBadge;
+ (UIImage *) bronzeBadge;
+ (void) notifyDisplayed : (NSNumber *) userID
                    cell : (UserTableCell *) cell;
+ (void) setImageFor : (User *) user;
- (void) setupWithUser: (User *) user;
- (void) prepareForReuse;



@end

#endif 
