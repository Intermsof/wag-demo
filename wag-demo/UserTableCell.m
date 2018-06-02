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
#import "Circle.h"
#import "Home.h"

//Font sizes for a user table cells
static int nameFontSize = 18;
static int subInfoFontSize = 12;
//pading for content on the right
static int contentPadding = 10;


//vertical separation of name label and sub info label
static int subInfoSeparation = 4;
//vertical separation between subInfo and badges
static int subInfoBadgeSeparation = 15;
//size of badge circles
static int badgeSize = 10;
//horizontal separation between badgeImage and badgeCount
static int badgeImageCountSeparation = 3;
//horizontal separation between second badgeImage from previous badgeCount
static int badgeSecondSeparation = 10;
//horizontal separation between field labels and values
static int fieldSeparation = 6;

@interface UserTableCell(){
    UIImageView *gravatar;
    UILabel *nameLabel;
    UILabel *userTypeLabel;
    UILabel *userLocationLabel;
    UIImageView *goldImage;
    UILabel *goldAmount;
    UIImageView *silverImage;
    UILabel *silverAmount;
    UIImageView *bronzeImage;
    UILabel *bronzeAmount;
    
    //ID of the user this cell is displaying
    NSNumber *uID;
    
    //Animated circle to display when loading gravatar
    __block Circle *circle;

}

@end

@implementation UserTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
                 reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: USER_CELL_ID];
    [self placeViews];
    return self;
}

//This method creates the required views and setups up their constraints.
//This method is only called in the constructor. Use setupwithUser to set up the specific content to display
- (void) placeViews{
    gravatar = [[UIImageView alloc] init];
    //Add a circle view to the gravatar and start an animation
    
    
    [self addSubview:gravatar];
    gravatar.translatesAutoresizingMaskIntoConstraints = false;
    [gravatar.leftAnchor constraintEqualToAnchor: self.leftAnchor].active = YES;
    [gravatar.heightAnchor constraintEqualToAnchor: self.heightAnchor].active = YES;
    [gravatar.widthAnchor constraintEqualToAnchor: self.heightAnchor].active = YES;

    circle = [[Circle alloc] init];
    circle.color = [Home wagColor];
    circle.frame = CGRectMake(0, 0, gravatar.frame.size.width * 2, gravatar.frame.size.width * 2);
    [gravatar addSubview: circle];
    [UIView animateWithDuration: 0.5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        circle.frame = CGRectMake(0, 0, 0, 0);
    } completion:nil];
//gravatar.backgroundColor = [UIColor blueColor];
    
    nameLabel = [[UILabel alloc] init];
    [self addSubview: nameLabel];
    nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [nameLabel setFont:[UIFont boldSystemFontOfSize: nameFontSize]];
    [nameLabel.leftAnchor constraintEqualToAnchor: gravatar.rightAnchor constant: contentPadding].active = YES;
    [nameLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant:contentPadding].active = YES;
    
    //User type field label
    UILabel *typeText = [[UILabel alloc] init];
    typeText.text = @"User Type:";
    typeText.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:typeText];
    [typeText setFont: [UIFont boldSystemFontOfSize: subInfoFontSize]];
    [typeText.leftAnchor constraintEqualToAnchor:gravatar.rightAnchor constant:contentPadding].active = YES;
    [typeText.topAnchor constraintEqualToAnchor: nameLabel.bottomAnchor constant:subInfoSeparation].active = YES;
    
    //User type field value
    userTypeLabel = [[UILabel alloc] init];
    userTypeLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: userTypeLabel];
    [userTypeLabel setFont:[UIFont systemFontOfSize: subInfoFontSize]];
    [userTypeLabel.leftAnchor constraintEqualToAnchor:typeText.rightAnchor constant:fieldSeparation].active = YES;
    [userTypeLabel.centerYAnchor constraintEqualToAnchor:typeText.centerYAnchor].active = YES;
    
    //User location field label
    UILabel *locationText = [[UILabel alloc] init];
    locationText.text = @"Location:";
    locationText.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:locationText];
    [locationText setFont: [UIFont boldSystemFontOfSize: subInfoFontSize]];
    [locationText.leftAnchor constraintEqualToAnchor:gravatar.rightAnchor constant:contentPadding].active = YES;
    [locationText.topAnchor constraintEqualToAnchor: typeText.bottomAnchor constant:subInfoSeparation].active = YES;
    
    //User location field value
    userLocationLabel = [[UILabel alloc] init];
    userLocationLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: userLocationLabel];
    [userLocationLabel setFont: [UIFont systemFontOfSize:subInfoFontSize]];
    [userLocationLabel.leftAnchor constraintEqualToAnchor: locationText.rightAnchor constant:fieldSeparation].active = YES;
    [userLocationLabel.centerYAnchor constraintEqualToAnchor: locationText.centerYAnchor].active = YES;
    
    //badges
    goldImage = [[UIImageView alloc] initWithImage: UserTableCell.goldBadge];
    goldImage.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:goldImage];
    [goldImage.leftAnchor constraintEqualToAnchor: gravatar.rightAnchor constant: contentPadding].active = YES;
    [goldImage.topAnchor constraintEqualToAnchor: userLocationLabel.bottomAnchor constant: subInfoBadgeSeparation].active = YES;
    
    goldAmount = [[UILabel alloc] init];
    goldAmount.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: goldAmount];
    [goldAmount.leftAnchor constraintEqualToAnchor:goldImage.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [goldAmount.centerYAnchor constraintEqualToAnchor:goldImage.centerYAnchor].active = YES;
    
    silverImage = [[UIImageView alloc] initWithImage: UserTableCell.silverBadge];
    silverImage.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: silverImage];
    [silverImage.leftAnchor constraintEqualToAnchor: goldAmount.rightAnchor constant: badgeSecondSeparation].active = YES;
    [silverImage.topAnchor constraintEqualToAnchor: userLocationLabel.bottomAnchor constant: subInfoBadgeSeparation].active = YES;
    
    silverAmount = [[UILabel alloc] init];
    silverAmount.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: silverAmount];
    [silverAmount.leftAnchor constraintEqualToAnchor:silverImage.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [silverAmount.centerYAnchor constraintEqualToAnchor: silverImage.centerYAnchor].active = YES;
    
    
    bronzeImage = [[UIImageView alloc] initWithImage: UserTableCell.bronzeBadge];
    bronzeImage.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: bronzeImage];
    [bronzeImage.leftAnchor constraintEqualToAnchor:silverAmount.rightAnchor constant:badgeSecondSeparation].active = YES;
    [bronzeImage.topAnchor constraintEqualToAnchor:userLocationLabel.bottomAnchor constant:subInfoBadgeSeparation].active = YES;
    
    bronzeAmount = [[UILabel alloc] init];
    bronzeAmount.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: bronzeAmount];
    [bronzeAmount.leftAnchor constraintEqualToAnchor:bronzeImage.rightAnchor constant:badgeImageCountSeparation].active = YES;
    [bronzeAmount.centerYAnchor constraintEqualToAnchor:bronzeImage.centerYAnchor].active = YES;
}


- (void) setupWithUser: (User *) user{
    
    nameLabel.text = user.name;
    userTypeLabel.text = user.userType;
    userLocationLabel.text = user.location == nil? @"Unknown Location" : user.location;
    goldAmount.text = [NSString stringWithFormat:@"%d",user.gold.intValue];
    silverAmount.text = [NSString stringWithFormat:@"%d",user.silver.intValue];
    bronzeAmount.text = [NSString stringWithFormat:@"%d",user.bronze.intValue];
    uID = user.userID;
    
    if(user.gravatar != nil){
        NSLog(@"%@", [NSString stringWithFormat:@"%d",user.userID.intValue]);
       // gravatar.image = user.gravatar;
        [gravatar setNeedsDisplay];
        [self setNeedsDisplay];
       
    }
}

//A dictionary mapping usersIDs to instances of table cells that display the corresponding user
//Necessary for updating the gravatar once loading is finished.
+ (NSMutableDictionary *) cellsDisplayed {
    static NSMutableDictionary *dictionary = nil;
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return dictionary;
}

//Sets the image for user if that user is currently being displayed already.
//This method is called inside the completion handler for fetching gravatars.
+ (void) setImageFor : (User *) user {
    UserTableCell *tableCell = [UserTableCell.cellsDisplayed objectForKey:user.userID];
    if(tableCell != nil){
        [tableCell setupWithUser:user];
    }
}
//The following two methods keeps track of which user's are currently being
//displayed on the screen.
- (void) prepareForReuse{
    if([UserTableCell.cellsDisplayed objectForKey:uID] != nil){
        [UserTableCell.cellsDisplayed removeObjectForKey: uID];
    }
}
+ (void) notifyDisplayed : (NSNumber *) userID
                    cell : (UserTableCell *) cell{
    [UserTableCell.cellsDisplayed setObject:cell forKey:userID];
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




@end
