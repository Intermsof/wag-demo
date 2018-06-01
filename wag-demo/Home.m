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

@interface Home (){
    HomeModel *homeModel;
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

- (void) viewWillAppear:(BOOL)animated {
    homeModel = [[HomeModel alloc] init];
    
    //Make the users table, register it, and add it to the view
    UITableView *usersTable = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [usersTable registerClass: [UserTableCell class] forCellReuseIdentifier: USERCELLID];
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
        return 2;
    }else{
        return homeModel.users.count;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableCell *result = [tableView dequeueReusableCellWithIdentifier: USERCELLID forIndexPath:indexPath];
    
    if([homeModel hasUsers]){
        //TODO: Add animation
    }else{
        User *user = homeModel.users[indexPath.row];
        
        [result setupWithName: user.name
                 stackProfile: user.stackProfile
                    userType : user.userType
                         gold: user.gold
                       silver: user.silver
                       bronze:user.bronze
                   reputation:user.reputation];
    }
    
    return result;
}
   
   /*)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;/*
tableView:cellForRowAtIndexPath:
Asks the data source for a cell to insert in a particular location of the table view.
Required.
numberOfSectionsInTableView:
Asks the data source to return the number of sections in the table view.
tableView:numberOfRowsInSection:
Tells the data source to return the number of rows in a given section of a table view.
Required.
*/

@end
