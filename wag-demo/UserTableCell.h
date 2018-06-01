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

@interface UserTableCell : UITableViewCell {

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style
                 reuseIdentifier:(NSString *)reuseIdentifier;

//+ (UIImage *) gravatarLoadAnimation;
+ (UIImage *) goldBadge;
+ (UIImage *) silverBadge;
+ (UIImage *) bronzeBadge;


- (void) setupWithName: (NSString *) name
          stackProfile: (NSString *) stackProfile
             userType : (NSString *) userType
                 gold : (NSNumber *) gold
               silver : (NSNumber *) silver
               bronze : (NSNumber *) bronze
           reputation : (NSNumber *) reputation;

- (void) setupProfileImage: (UIImage *) profileImage;
- (void) setupLocation: (NSString *) location;
- (void) setupWebsite: (NSString *) website;


@end

#endif 
