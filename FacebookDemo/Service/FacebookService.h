//
//  FacebookService.h
//  LetsShuga
//
//  Created by Le Thanh Hai on 10/5/15.
//  Copyright © 2015 goappable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKCoreKit/FBSDKGraphRequest.h>

@interface FacebookService : NSObject

+ (void) loginWithReadPermissions: (NSArray*) permissions
               fromViewController: (UIViewController*) controller
                          handler: (void(^)(FBSDKLoginManagerLoginResult *result, NSError *error)) completion;

+ (void) loginWithWritePermissions: (NSArray*) permissions
                fromViewController: (UIViewController*) controller
                           handler: (void(^)(FBSDKLoginManagerLoginResult *result, NSError *error)) completion;
+ (BOOL) isSignInWithFacebook;
+ (void) retrieveUserDataWithHandler: (void(^)(id result, NSError *error)) completion;
+ (void) logoutFromFacebook;
+ (BOOL) hasPublishPermission;

+ (void) shareImage: (UIImage*) image withText: (NSString*) text handler: (void(^)(BOOL result, NSError *error)) completion;

@end
