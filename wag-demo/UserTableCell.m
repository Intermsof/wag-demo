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

@interface UserTableCell()

@end

@implementation UserTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
                 reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: USERCELLID];
    
    return self;
}

- (void) setupWithName: (NSString *) name
          stackProfile: (NSString *) stackProfile
             userType : (NSString *) userType
                  gold: (int) gold
                silver: (int) silver
                bronze: (int) bronze
            reputation: (int) reputation{
    
}

- (void) setupLocation: (NSString *) location {
    
}

- (void) setupWebsite: (NSString *) website {
    
}

@end
