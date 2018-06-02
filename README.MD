# Wag Coding Challenge iOS

## Technical Information

- Language: Objective-C
- iOS10
- Developed in xCode 8.2.1. Tested to be functional in xCode 11.3
- Tested on iPhone 6, 6s, 7, 7s, iPad Pro simulators. iPhone 5 is not supported (Table rows overflow slightly).

## Functions implemented

- Connects to Stackoverflow API and retrieves first page of data. Scrolling all the way down the table will **retrieve more pages** of data.
- Gravatar, username, badges, location, user type, reputation is displayed.
- Before downloading gravatar, a check is made to see if the file /Library/Caches/{userid}.png exists. If it does, the app loads from file instead of downloading the image.
- Upon downloading gravatar, it is saved to /Library/Caches/{userid}.png
- A spinning/scaling box animation is displayed in place of the gravatar while it is being downloaded. Network connection must be relatively slow to see this feature.
- UI is always responsive.

## Architecture

- This application follows the standard <b>MVC architecture</b>. There are top level folders named Models, Views, Controllers. Within each, there is a folder for each page in the app that stores files relevant only to that page (only one in this case, called “Home”). Files that are used in multiple pages reside directly in Models, Views, Controllers.

## Class Overview 

### Home
- This class is the controller of the home page. It has methods for fetching API pages and fetching gravatars. 
```
- (void)fetchAPIPage: (int) pageNumber
- (void)getProfileImageForUser: (User *) user
```
- This class also contains delegate and datasource methods for the table displayed.
- There is a <b style=“color:#24b88e”>wagColor</b> property defined in this class meant to be used across the app;

### UserTableCell
- A custom table cell that programmatically sets up constraints in the constructor for all UILabels and gravatar UIImageView (by calling placeView method).
- Values for constraint related constants are defined as static variable at the beginning of the file.
— `- (void) setupWithUser: (User *) user ` takes a user and put all its information inside the UILabels.
- This class has a `+ (NSMutableDictionary *) cellsDisplayed` property. The purpose of this is to keep track of which users are currently being displayed on screen. This is necessary to update the gravatar after the image is successfully downloaded. There are two methods:

```
- (void) prepareForReuse
+ (void) notifyDisplayed : (NSNumber *) userID
                    cell : (UserTableCell *) cell
```
that maintains this dictionary. The first erases a user from the dictionary, the second adds the key value pair into the dictionary.

### User
- A simple user object

### HomeModel
- A model that is meant to contain everything needed by the Home controller to display its views. Only contains a list of users for now.