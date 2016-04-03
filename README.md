##Facebook Service


This library will help you to minimize the tasks of logging in with Facebook, request publish permission and share text/image on Facebook Timeline by using Open Graph API.

To be able to use this library, you need to set up the environment. Please follow steps below:

Steps:

1. Set up Facebook application [here] (https://developers.facebook.com/), remember to configure your .plist file in your iOS project.
2. Add some Facebook testers in the Facebook application Roles setting.
3. Add 2 files (FacebookService.h and FacebookService.m) to your project. Now you are ready to use.

##How to use

###Import header file
Remember to import FacebookService.h at any class you would like to use this service

The library provides you many methods:

###Login Facebook
There are 2 methods to login with Facebook. One with read permission and one with publish permission. To be able to login with Facebook, create a button and connect it with an IBAction:

	[FacebookService loginWithWritePermissions:@[@"publish_actions"]
                           fromViewController:self
                                      handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    	}
    }];

In the complete handler, you can check the login result and move to next screen or show the error message.

###Retrieve user information
After logging in successfully, you can use this library to retrieve user information like Facebook ID, name, biography from Facebook, by using this method **retrieveUserDataWithHandler**:

	[FacebookService retrieveUserDataWithHandler:^(id result, NSError *error) {
    }];
    
###Share text/image on Facebook Timeline using Open Graph API
The library provides a method to let user share text or image immediately by using Open Graph. For more information about Open Graph, you can view on this [link] (https://developers.facebook.com/docs/graph-api)

	[FacebookService shareImage:[UIImage imageNamed:@"apple-logo.png"] withText:@"Sample text" handler:^(BOOL result, NSError *error) {
    }];
    
###Sign out from Facebook
To sign out from Facebook, simply call this method **logoutFromFacebook**

	[FacebookService logoutFromFacebook];
	
##Improvements
Anyone can fork to modify this project. If you want me to add/improve this project, please post to the Issue.
	
##Licences
All source files are licensed under MIT license.