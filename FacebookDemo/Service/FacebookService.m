//
//  FacebookService.m
//  LetsShuga
//
//  Created by Le Thanh Hai on 10/5/15.
//  Copyright © 2015 goappable. All rights reserved.
//

#import "FacebookService.h"

@implementation FacebookService

+ (void) loginWithReadPermissions: (NSArray*) permissions
               fromViewController: (UIViewController*) controller
                          handler: (void(^)(FBSDKLoginManagerLoginResult *result, NSError *error)) completion {
    if (![FacebookService isSignInWithFacebook]) {
        FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
        [manager logInWithReadPermissions:permissions
                       fromViewController:controller
                                  handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                      completion(result, error);
                                  }];
    }
}

+ (void) loginWithWritePermissions:(NSArray *)permissions fromViewController:(UIViewController *)controller handler:(void (^)(FBSDKLoginManagerLoginResult *, NSError *))completion {
    if (![FacebookService isSignInWithFacebook]) {
        FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
        [manager logInWithPublishPermissions:permissions fromViewController:controller handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            completion(result, error);
        }];
    }
}

+ (BOOL)isSignInWithFacebook {
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)retrieveUserDataWithHandler:(void (^)(id, NSError *))completion {
    if ([FacebookService isSignInWithFacebook]) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=email,id,name,bio,first_name,middle_name,last_name" parameters:nil];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            completion(result, error);
        }];
    }
}

+ (void)logoutFromFacebook {
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* facebookCookies = [cookies cookiesForURL:
                                [NSURL URLWithString:@"http://login.facebook.com"]];
    for (NSHTTPCookie* cookie in facebookCookies) {
        [cookies deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([FacebookService isSignInWithFacebook]) {
        FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
        [manager logOut];
    }
}

+ (BOOL) hasPublishPermission {
    if ([FacebookService isSignInWithFacebook]) {
        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

+ (void)shareImage:(UIImage *)image withText:(NSString *)text handler:(void (^)(BOOL, NSError *))completion {
    if ([FacebookService isSignInWithFacebook]) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[image, text] forKeys:@[@"picture", @"caption"]];
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/photos" parameters:dict HTTPMethod:@"POST"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            completion(result, error);
        }];
    }
}

@end
