//
//  MainViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MyManager.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "RearViewController.h"
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
@interface MainViewController () <SWRevealViewControllerDelegate>

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KeychainItemWrapper *loginKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    NSLog(@"MAINVIEW CREDS %@,%@", [loginKeychain objectForKey:(__bridge id)kSecAttrAccount], [[NSString alloc] initWithData:[loginKeychain objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding]);
    
    MyManager *globals = [MyManager sharedManager];
    globals.someProperty = @"Haifa";
    
    FrontViewController *frontViewController = [[FrontViewController alloc] init];
    RearViewController *rearViewController = [[RearViewController alloc] init];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    UINavigationController *rearNavigationController = [[UINavigationController alloc]initWithRootViewController:rearViewController];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    mainRevealController.delegate = self;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.window.rootViewController = mainRevealController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
