//
//  ViewController.m
//  FacebookDemo
//
//  Created by Le Thanh Hai on 4/1/16.
//  Copyright © 2016 goappable. All rights reserved.
//

#import "ViewController.h"
#import "FacebookService.h"

@interface ViewController ()
- (IBAction)facebookLoginBtnTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction on view

- (IBAction)facebookLoginBtnTapped:(id)sender {
    [FacebookService loginWithWritePermissions:@[@"publish_actions"]
                           fromViewController:self
                                      handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                          if (result && [FacebookService isSignInWithFacebook]) {
                                              [self performSegueWithIdentifier:@"goToUserView" sender:self];
                                          } else {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
    }];
}
@end
