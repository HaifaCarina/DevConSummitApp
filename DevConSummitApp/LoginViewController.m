//
//  LoginViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/19/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "LoginViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *emailInput;
@property (nonatomic, strong) UITextField *passwordInput;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xe9e9e9);
    
    // DevCon Summit Logo View
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.95, self.view.frame.size.height * 0.3)];
    logoView.contentMode  = UIViewContentModeScaleAspectFit;
    //logoView.backgroundColor = [UIColor yellowColor];
    [logoView setImage:logo];
    logoView.center = self.view.center;
    
    // DevCon Summit Logo: Centering Horizontally the textfield
    CGRect frame = logoView.frame;
    frame.origin.y = self.view.frame.size.height * 0.15;
    [logoView setFrame:frame];
    [self.view addSubview:logoView];
    
    // Email Address TextField
    self.emailInput = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width * 0.75), (self.view.frame.size.height * 0.08))];
    self.emailInput.borderStyle = UITextBorderStyleRoundedRect;
    self.emailInput.backgroundColor = [UIColor whiteColor];
    self.emailInput.layer.cornerRadius=8.0f;
    self.emailInput.layer.masksToBounds=YES;
    self.emailInput.layer.borderColor = UIColorFromRGB(0x83ac25).CGColor;
    self.emailInput.layer.borderWidth= 1.0f;
    self.emailInput.delegate = self;
    self.emailInput.placeholder = @"Email Address";
    self.emailInput.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:self.emailInput];
    
    // Email Address Icon
    UIImageView *emailLogo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"email.png"]];
    emailLogo.frame = CGRectMake(0, 0, 30, 30);
    self.emailInput.leftViewMode = UITextFieldViewModeAlways;
    self.emailInput.leftView = emailLogo;
    
    // Icon Separator
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = UIColorFromRGB(0xe9e9e9).CGColor;
    sublayer.frame = CGRectMake(emailLogo.bounds.size.width, 0, 1, emailLogo.frame.size.height);
    [emailLogo.layer addSublayer:sublayer];
    
    // Email Address Center Position Horizontally
    self.emailInput.center = self.view.center;
    frame = self.emailInput.frame;
    frame.origin.y = self.view.frame.size.height * 0.55;
    [self.emailInput setFrame:frame];
    
    // Password Textfield
    self.passwordInput = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width * 0.75), (self.view.frame.size.height * 0.08))];
    self.passwordInput.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordInput.secureTextEntry = YES;
    self.passwordInput.layer.cornerRadius=8.0f;
    self.passwordInput.layer.masksToBounds=YES;
    self.passwordInput.layer.borderColor = UIColorFromRGB(0x83ac25).CGColor;
    self.passwordInput.layer.borderWidth= 1.0f;
    self.passwordInput.delegate = self;
    self.passwordInput.placeholder = @"Password";
    [self.view addSubview:self.passwordInput];
    
    
    // Password Icon
    UIImageView *passwordLogo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"password.png"]];
    passwordLogo.frame = CGRectMake(0, 0, 30, 30);
    self.passwordInput.leftViewMode = UITextFieldViewModeAlways;
    self.passwordInput.leftView = passwordLogo;
    
    //Icon Separator
    sublayer = [CALayer layer];
    sublayer.backgroundColor = UIColorFromRGB(0xe9e9e9).CGColor;
    sublayer.frame = CGRectMake(passwordLogo.bounds.size.width, 0, 1, passwordLogo.frame.size.height);
    [passwordLogo.layer addSublayer:sublayer];
    
    
    // Email Address Center Position Horizontally
    self.passwordInput.center = self.view.center;
    frame = self.passwordInput.frame;
    frame.origin.y = self.view.frame.size.height * 0.65;
    [self.passwordInput setFrame:frame];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    login.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.1);
    login.layer.cornerRadius=8.0f;
    login.backgroundColor = UIColorFromRGB(0x83ac25);
    [login addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:login];
    
    // Login Center Position Horizontally
    login.center = self.view.center;
    frame = login.frame;
    frame.origin.y = self.view.frame.size.height * 0.80;
    [login setFrame:frame];
}

- (void) buttonPressed {
    NSLog(@"button is pressed!");
    //MainViewController *mainViewController = [[MainViewController alloc]init];
    //mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self presentViewController:mainViewController animated:YES completion:nil];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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

@end
