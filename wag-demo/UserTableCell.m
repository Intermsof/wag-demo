//
//  UserTableCell.m
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserTableCell.h"
#import "Constants.h"

//Font sizes for a user table cells
static int nameFontSize = 16;
static int subInfoFontSize = 12;
//pading for content on the right
static int contentPadding = 10;


//vertical separation of name label and sub info label
static int subInfoSeparation = 3;
//horizontal separation between userTypeLabel and locationLabel
static int typeLocationSeparation = 5;
//vertical separation between subInfo and badges
static int subInfoBadgeSeparation = 10;
//size of badge circles
static int badgeSize = 20;
//horizontal separation between badgeImage and badgeCount
static int badgeImageCountSeparation = 2;
//horizontal separation between second badgeImage from previous badgeCount
static int badgeSecondSeparation = 5;

@interface UserTableCell(){
    UIImageView *gravatar;

}

@end

@implementation UserTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
                 reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: USER_CELL_ID];

    return self;
}


+ (UIImage *) goldBadge {
    static UIImage *gold = nil;
    if(gold == nil){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(badgeSize, badgeSize), NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGRect rect = CGRectMake(0, 0, badgeSize, badgeSize);
        
        UIColor *goldColor = [UIColor colorWithRed:253.0/255.0 green:203.0/255.0 blue:1.0/255.0 alpha:1.0];
        
        CGContextSetFillColorWithColor(ctx, goldColor.CGColor);
        CGContextFillEllipseInRect(ctx, rect);
        
        CGContextRestoreGState(ctx);
        gold = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return gold;
}

+ (UIImage *) silverBadge {
    static UIImage *silver = nil;
    if(silver == nil){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(badgeSize, badgeSize), NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGRect rect = CGRectMake(0, 0, badgeSize, badgeSize);
        
        UIColor *silverColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0];
        
        
        CGContextSetFillColorWithColor(ctx, silverColor.CGColor);
        CGContextFillEllipseInRect(ctx, rect);
        
        CGContextRestoreGState(ctx);
        silver = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    return silver;
}

+ (UIImage *) bronzeBadge {
    static UIImage *bronze = nil;
    if(bronze == nil){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(badgeSize, badgeSize), NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGRect rect = CGRectMake(0, 0, badgeSize, badgeSize);
        
        UIColor *bronzeColor = [UIColor colorWithRed:202.0/255.0 green:152.0/255.0 blue:101.0/255.0 alpha:1.0];
        
        CGContextSetFillColorWithColor(ctx, bronzeColor.CGColor);
        CGContextFillEllipseInRect(ctx, rect);
        
        CGContextRestoreGState(ctx);
        bronze = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return bronze;
}


/*
+ (UIImage *) gravatarLoadAnimation {
    static UIImage *animation = nil;
    if (animation == nil) {
        animation = [[UIImage alloc] initWithCIImage:<#(nonnull CIImage *)#>]
    }
    return fooDict;
}
 */

- (void) setupWithName: (NSString *) name
          stackProfile: (NSString *) stackProfile
             userType : (NSString *) userType
                 gold : (NSNumber *) gold
               silver : (NSNumber *) silver
               bronze : (NSNumber *) bronze
           reputation : (NSNumber *) reputation {
    
    //initialize and setup constraints for gravatar
    gravatar = [[UIImageView alloc] init];
    gravatar.translatesAutoresizingMaskIntoConstraints = false;
    [gravatar.leftAnchor constraintEqualToAnchor: self.leftAnchor].active = YES;
    [gravatar.heightAnchor constraintEqualToAnchor: self.heightAnchor].active = YES;
    [gravatar.widthAnchor constraintEqualToAnchor: self.heightAnchor].active = YES;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = name;
    [nameLabel setFont:[UIFont boldSystemFontOfSize: nameFontSize]];
    [nameLabel.leftAnchor constraintEqualToAnchor: gravatar.rightAnchor constant: contentPadding].active = YES;
    [nameLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant:contentPadding].active = YES;
    
    UILabel *userTypeLabel = [[UILabel alloc] init];
    userTypeLabel.text = userType;
    [userTypeLabel setFont:[UIFont systemFontOfSize: subInfoFontSize]];
    [userTypeLabel.leftAnchor constraintEqualToAnchor:gravatar.rightAnchor constant:contentPadding].active = YES;
    [userTypeLabel.topAnchor constraintEqualToAnchor:nameLabel.bottomAnchor constant:subInfoSeparation].active = YES;
    
    UILabel *userLocationLabel = [[UILabel alloc] init];
    [userLocationLabel setFont: [UIFont systemFontOfSize:subInfoFontSize]];
    [userLocationLabel.leftAnchor constraintEqualToAnchor: userTypeLabel.rightAnchor constant:typeLocationSeparation].active = YES;
    [userLocationLabel.topAnchor constraintEqualToAnchor: nameLabel.bottomAnchor constant:subInfoSeparation].active = YES;
    
    UIImageView *goldImage = [[UIImageView alloc] initWithImage: UserTableCell.goldBadge];
    [goldImage.leftAnchor constraintEqualToAnchor: gravatar.rightAnchor constant: contentPadding].active = YES;
    [goldImage.topAnchor constraintEqualToAnchor: userTypeLabel.bottomAnchor constant: subInfoBadgeSeparation].active = YES;
    
    UILabel *goldAmount = [[UILabel alloc] init];
    goldAmount.text = [NSString stringWithFormat:@"%d",gold.intValue];
    [goldAmount.leftAnchor constraintEqualToAnchor:goldImage.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [goldAmount.topAnchor constraintEqualToAnchor:userTypeLabel.bottomAnchor constant: subInfoBadgeSeparation].active = YES;
    
    UIImageView *silverImage = [[UIImageView alloc] initWithImage: UserTableCell.silverBadge];
    [silverImage.leftAnchor constraintEqualToAnchor: goldAmount.rightAnchor constant: badgeSecondSeparation].active = YES;
    [silverImage.topAnchor constraintEqualToAnchor: userTypeLabel.bottomAnchor constant: subInfoBadgeSeparation].active = YES;
    
    UILabel *silverAmount = [[UILabel alloc] init];
    silverAmount.text = [NSString stringWithFormat:@"%d",silver.intValue];
    [silverAmount.leftAnchor constraintEqualToAnchor:silverImage.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [silverAmount.topAnchor constraintEqualToAnchor:userTypeLabel.bottomAnchor constant:subInfoBadgeSeparation].active = YES;
    

    UIImageView *bronzeImage = [[UIImageView alloc] initWithImage: UserTableCell.bronzeBadge];
    [bronzeImage.leftAnchor constraintEqualToAnchor:silverAmount.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [bronzeImage.topAnchor constraintEqualToAnchor:userTypeLabel.bottomAnchor constant:subInfoBadgeSeparation].active = YES;

    UILabel *bronzeAmount = [[UILabel alloc] init];
    bronzeAmount.text = [NSString stringWithFormat:@"%d",bronze.intValue];
    [bronzeAmount.leftAnchor constraintEqualToAnchor:bronzeImage.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [bronzeAmount.topAnchor constraintEqualToAnchor:userTypeLabel.bottomAnchor constant:subInfoBadgeSeparation].active = YES;
    
}

- (void) setupProfileImage: (UIImage *) profileImage {
    
}

- (void) setupLocation: (NSString *) location {
    
}

- (void) setupWebsite: (NSString *) website {
    
}

@end
