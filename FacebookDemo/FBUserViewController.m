//
//  FBUserViewController.m
//  FacebookDemo
//
//  Created by Le Thanh Hai on 4/2/16.
//  Copyright © 2016 goappable. All rights reserved.
//

#import "FBUserViewController.h"
#import "FacebookService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define FACEBOOK_AVATAR_URL @"https://graph.facebook.com/%@/picture?type=large"

@interface FBUserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fbNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *fbAboutLbl;
@property (weak, nonatomic) IBOutlet UIImageView *fbAvatarImgView;

- (IBAction)shareBtnTapped:(id)sender;

- (IBAction)logoutBtnTapped:(id)sender;
@end

@implementation FBUserViewController
@synthesize fbAboutLbl, fbAvatarImgView, fbNameLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FacebookService retrieveUserDataWithHandler:^(id result, NSError *error) {
        NSLog(@"result: %@", result);
        if (result) {
            NSString *name = [result objectForKey:@"name"];
            NSString *bio = [result objectForKey:@"bio"];
            NSString *fbId = [result objectForKey:@"id"];
            NSString *avatar = [NSString stringWithFormat:FACEBOOK_AVATAR_URL, fbId];
            
            fbNameLbl.text = name;
            fbAboutLbl.text = bio;
            [fbAvatarImgView sd_setImageWithURL:[NSURL URLWithString:avatar]];
        } else {
            //error
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - IBAction on view
- (IBAction)shareBtnTapped:(id)sender {
    [FacebookService shareImage:[UIImage imageNamed:@"apple-logo.png"] withText:@"Sample text" handler:^(BOOL result, NSError *error) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Success" message:@"The message has been shared successfully" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
    }];
}

- (IBAction)logoutBtnTapped:(id)sender {
    [FacebookService logoutFromFacebook];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
