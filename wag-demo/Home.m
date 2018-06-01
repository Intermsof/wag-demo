//
//  Home.m
//  wag-demo
//
//  Created by Zhan Peng Pan on 5/31/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#import "Home.h"
#import "UserTableCell.h"
#import "Constants.h"
#import "HomeModel.h"
#import "User.h"

//Next step set up network layer

@interface Home (){
    HomeModel *homeModel;
    UITableView *usersTable;
}

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//1. set up dataTaskWithURL for shared URLSession to fetch the pageNumber-th page of the stackover flow API for a list of users
//2. parses the list of json users into instances of the User Class
//3. Appends the instances to the *end* of the users array in homeModel
//   Note that a consequence of this is that calling this method twice for the same pageNumber will cause undesireable behavior
//   The correct way to call this method is to call it with pageNumber = 0, = 1, = 2, = 3, ...
//4. Calls reloadData on the userTable in the UI Thread
- (void)fetchAPIPage: (int) pageNumber {
    
    NSURL *APIurl = [NSURL URLWithString: [NSString stringWithFormat:@"%@%d%@", API_USER_BEGIN, pageNumber, API_USER_END]];
    [NSURLSession.sharedSession dataTaskWithURL:APIurl completionHandler: ^
     (NSData *data, NSURLResponse *response, NSError *error){
         if(error){
             NSLog(@"%@", [NSString stringWithFormat:@"Could not fetch page %d", pageNumber]);
         }else{
             NSError *jsonError;
             NSArray *unparsedUsers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
             
             for(NSDictionary *unparsedUser in unparsedUsers){
                 User *user = [[User alloc] init];
                 [user setupWithName: [unparsedUser objectForKey: KEY_FOR_NAME]
                        stackProfile: [unparsedUser objectForKey: KEY_FOR_STACKOVERFLOW_LINK]
                       profileImage : [unparsedUser objectForKey: KEY_FOR_PROFILE_IMAGE_LINK]
                            userType: [unparsedUser objectForKey: KEY_FOR_USER_TYPE]
                                gold: [unparsedUser objectForKey: KEY_FOR_GOLD]
                              silver: [unparsedUser objectForKey: KEY_FOR_SILVER]
                              bronze: [unparsedUser objectForKey: KEY_FOR_BRONZE]
                          reputation: [unparsedUser objectForKey: KEY_FOR_REPUTATION]
                             userID : [unparsedUser objectForKey: KEY_FOR_USERID]];
                 
                 [homeModel.users addObject: user];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [usersTable reloadData];
             });
         }
     }];
    
}

- (void) viewWillAppear:(BOOL)animated {
    homeModel = [[HomeModel alloc] init];
    
    
    //Make the users table, register it, and add it to the view
    usersTable = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [usersTable registerClass: [UserTableCell class] forCellReuseIdentifier: USER_CELL_ID];
    usersTable.delegate = self;
    usersTable.dataSource = self;
    [self.view addSubview: usersTable];
    
    //Setup users table constraints
    [usersTable.leftAnchor constraintEqualToAnchor: self.view.leftAnchor];
    [usersTable.rightAnchor constraintEqualToAnchor: self.view.rightAnchor];
    [usersTable.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor];
    //TODO: Change
    [usersTable.topAnchor constraintEqualToAnchor: self.view.topAnchor];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(![homeModel hasUsers]){
        return 3;
    }else{
        return homeModel.users.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  0.25 * tableView.frame.size.height;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableCell *result = [tableView dequeueReusableCellWithIdentifier: USER_CELL_ID forIndexPath:indexPath];
    
    if([homeModel hasUsers]){
        //TODO: Add animation
    }else{
        //get the user for this row and set up the view
        User *user = homeModel.users[indexPath.row];
        [result setupWithName: user.name
                 stackProfile: user.stackProfile
                    userType : user.userType
                         gold: user.gold
                       silver: user.silver
                       bronze: user.bronze
                   reputation: user.reputation];
    }
    
    return result;
}
@end
