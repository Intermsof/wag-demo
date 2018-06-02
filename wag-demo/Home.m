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

//The percentage of the entire height of the screen to use in a cell landscape mode
static float tableRowHeightPercentage = 0.2;
//A flag for tracking whether we are loading API. Initialized as true because we start out loading
static bool isLoading = true;

+ (UIColor *) wagColor {
    static UIColor *wag = nil;
    if(wag == nil){
        wag = [UIColor colorWithRed: 36.0/255.0 green:184.0/255.0 blue:142.0/255.0 alpha:1];
    }
    return wag;
};


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 A method that first checks the file system in "/library/caches/{userid}.png" for the user's gravatar.
 If unsuccessful, fetches the image over the network. Once the image arrives, it saves the data to
 the mentioned path, and updates the cells to display this image.
 */
- (void)getProfileImageForUser: (User *) user {
    NSURL *homeURL = [NSURL fileURLWithPath: NSHomeDirectory()];
    NSURL *imageURL = [homeURL URLByAppendingPathComponent: [NSString stringWithFormat: @"%@%d.png",PATH_TO_IMAGES,user.userID.intValue]];

    NSData *savedData = [NSData dataWithContentsOfURL: imageURL];
    if(savedData != nil){
        UIImage *image = [[UIImage alloc] initWithData:savedData];
        user.gravatar = image;
        [UserTableCell setImageFor: user];
    }else{
        NSURL *profileURL = [NSURL URLWithString: user.profileImage];
        //Start request for profile image
        [[NSURLSession.sharedSession dataTaskWithURL: profileURL completionHandler: ^
          (NSData *data, NSURLResponse *response, NSError *error){
              if(error){
                  NSLog(@"Could not get profile image for a user");
              }else{
                  UIImage *image = [UIImage imageWithData:data];
                  user.gravatar = image;
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [UserTableCell setImageFor: user];
                  });
                  NSData *imageData = UIImagePNGRepresentation(image);
                  [imageData writeToURL:imageURL atomically:YES];
              }
          }] resume];
    }
}

/*
    1. set up dataTaskWithURL for shared URLSession to fetch the pageNumber-th page of the stackover flow API for a list of users
    2. parses the list of json users into instances of the User Class
    3. Appends the instances to the *end* of the users array in homeModel
       Note that a consequence of this is that calling this method twice for the same pageNumber will cause undesireable behavior
       The correct way to call this method is to call it with pageNumber = 0, = 1, = 2, = 3, ...
    4. Calls reloadData on the userTable in the UI Thread 
*/
- (void)fetchAPIPage: (int) pageNumber {
    
    NSURL *APIurl = [NSURL URLWithString:[NSString stringWithFormat: @"%@%d%@",API_USER_BEGIN, pageNumber, API_USER_END]];
    [[NSURLSession.sharedSession dataTaskWithURL:APIurl completionHandler: ^
     (NSData *data, NSURLResponse *response, NSError *error){
         if(error){
             NSLog(@"%@", [NSString stringWithFormat:@"Could not fetch page %d", pageNumber]);
         }else{
             NSError *jsonError;
             NSDictionary *unparsedUsers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
             
             
             for(NSDictionary *unparsedUser in [unparsedUsers objectForKey : KEY_FOR_ITEMS]){
                 User *user = [[User alloc] initWithName:[unparsedUser objectForKey: KEY_FOR_NAME]
                                            stackProfile:[unparsedUser objectForKey: KEY_FOR_STACKOVERFLOW_LINK]
                                            profileImage:[unparsedUser objectForKey: KEY_FOR_PROFILE_IMAGE_LINK]
                                                userType:[unparsedUser objectForKey: KEY_FOR_USER_TYPE]
                                               location :[unparsedUser objectForKey: KEY_FOR_LOCATION]
                                                 website:[unparsedUser objectForKey: KEY_FOR_WEBSITE]
                                                    gold:[[unparsedUser objectForKey: KEY_FOR_BADGES] objectForKey: KEY_FOR_GOLD]
                                                  silver:[[unparsedUser objectForKey: KEY_FOR_BADGES] objectForKey: KEY_FOR_SILVER]
                                                  bronze:[[unparsedUser objectForKey: KEY_FOR_BADGES] objectForKey: KEY_FOR_BRONZE]
                                              reputation:[unparsedUser objectForKey: KEY_FOR_REPUTATION]
                                                  userID:[unparsedUser objectForKey: KEY_FOR_USERID]];
                 
                 
                 [self getProfileImageForUser: user];
                 
                 [homeModel.users addObject: user];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [usersTable reloadData];
                 isLoading = false;
             });
         }
     }] resume];
    
}

- (void) viewWillAppear:(BOOL)animated {
    isLoading = true;
    homeModel = [[HomeModel alloc] init];
    //Add a colored background for status bar
    UIView *statusBar = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBar.backgroundColor = Home.wagColor;
    [self.view addSubview: statusBar];
    
    //Make the users table, register it, and add it to the view
    usersTable = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [usersTable registerClass: [UserTableCell class] forCellReuseIdentifier: USER_CELL_ID];
    usersTable.delegate = self;
    usersTable.dataSource = self;
    
    [self.view addSubview: usersTable];
    
    usersTable.backgroundColor = Home.wagColor;
    usersTable.translatesAutoresizingMaskIntoConstraints = false;
    [usersTable.topAnchor constraintEqualToAnchor: statusBar.bottomAnchor].active = YES;
    [usersTable.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor].active = YES;
    [usersTable.leftAnchor constraintEqualToAnchor: self.view.leftAnchor].active = YES;
    [usersTable.rightAnchor constraintEqualToAnchor: self.view.rightAnchor].active = YES;
    
    [self fetchAPIPage:1];
    
}


//An implementation to add more pages to the end of the table when scrolled to the end
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat threshold = 200.0;
    static int lastPageLoaded = 1;
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (!isLoading && (maximumOffset - contentOffset <= threshold)){
        isLoading = true;
        lastPageLoaded++;
        NSLog(@"In here %d", lastPageLoaded);
        [self fetchAPIPage: lastPageLoaded];
     }
}


//Tableview functions
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < homeModel.users.count){
        return tableRowHeightPercentage * tableView.frame.size.height;
    }else{
        return 0.1 * tableView.frame.size.height;
    }
    
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row < homeModel.users.count){
        UserTableCell *result = [tableView dequeueReusableCellWithIdentifier: USER_CELL_ID forIndexPath:indexPath];
        User *user = homeModel.users[indexPath.row];
        [UserTableCell notifyDisplayed:user.userID cell:result];
        [result setupWithUser: user];
        return result;
    }else{
        UITableViewCell *result = [[UITableViewCell alloc] init];
        result.backgroundColor = [UIColor grayColor];
        return result;
    }
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isLoading){
        return homeModel.users.count + 1;
    }
    return homeModel.users.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
