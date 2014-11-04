//
//  FrontViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyManager.h"
#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "UIImage+StackBlur.h"
#import "EditMyProfileViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface FrontViewController () <UIActionSheetDelegate> {
    NSDictionary *object;
    UIImage *profileImage;
    UILabel *affiliation;
}

@end

@implementation FrontViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void) requestButton {
    NSLog(@"button is pressed!");
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Edit My Profile", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        EditMyProfileViewController *editMyProfileView = [[EditMyProfileViewController alloc] init];
        [self.navigationController pushViewController:editMyProfileView animated:YES];
    }
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for(UIButton *view in self.view.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self performSelectorOnMainThread:@selector(loadContent) withObject:nil waitUntilDone:NO];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewdidload called");
    
}

- (void) loadContent {
    [super viewDidLoad];
    
    // Set global variable to use in this viewcontroller
    MyManager *globals = [MyManager sharedManager];
    object = globals.profileObject;
    profileImage = globals.profileImage;
    
    NSLog(@"loadContent");
    NSLog(@"POSITION: %@", affiliation.text);
    self.navigationItem.title = @"My Profile";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    self.view.backgroundColor = UIColorFromRGB(0xfbfaf7);
    
    
    // #########################################
    //          Set-up Navigation Drawer
    // #########################################
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    // #########################################
    //          Set-up Settings Button
    // #########################################
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"settings-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(requestButton)];
    
    self.navigationItem.rightBarButtonItem = settingsButtonItem;
    
    
    // #########################################
    //          Set-up ScrollView
    // #########################################
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, -40, 320, self.view.frame.size.height + 40)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
    // #########################################
    // Set Image for cell bottom half background
    // #########################################
    UIImage *image = profileImage; //[UIImage imageNamed:@"haifa.jpg"];
    
    // Slice image into half
    CGImageRef imageToSplit = image.CGImage;
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(imageToSplit, CGRectMake(0,0,image.size.width, image.size.height/2));
    UIImage *partOfImage = [UIImage imageWithCGImage:partOfImageAsCG];
    
    // Blur image
    UIImage *blurredImage = [partOfImage stackBlur:55];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:blurredImage];
    imageView1.frame = CGRectMake(0, 0, self.view.frame.size.width, 180);
    
    [scrollView addSubview:imageView1];
    [scrollView sendSubviewToBack:imageView1];
    
    UIView *background = [[UIView alloc]initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 140)];
    background.backgroundColor = UIColorFromRGB(0xe6c630);
    [scrollView addSubview:background];
    
    // #########################################
    //              Set Image View
    // #########################################
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    imageView.center = CGPointMake(self.view.bounds.size.width/2, 180);
    imageView.image = profileImage; //[UIImage imageNamed:@"haifa.jpg"];
    imageView.layer.borderColor = UIColorFromRGB(0xe6c630).CGColor;
    imageView.layer.borderWidth = 2;
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    [scrollView addSubview:imageView];
    
    //Set-up data
    NSDictionary *profileContent = [[object objectForKey:@"profile"] objectForKey:@"user"];
    
    // #########################################
    //              Set Name
    // #########################################
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.9, 40)];
    name.text = [NSString stringWithFormat:@"%@ %@", [profileContent objectForKey:@"first_name"], [profileContent objectForKey:@"last_name"]];
    name.center = CGPointMake(self.view.bounds.size.width/2, 260);
    name.lineBreakMode = NSLineBreakByWordWrapping;
    name.numberOfLines = 0;
    name.textAlignment = NSTextAlignmentCenter;
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont fontWithName:@"SourceSansPro-SemiBold" size:20];
    [scrollView addSubview:name];
    
    // Name - Resize Frame
    CGRect nameFrame = [name.text boundingRectWithSize:CGSizeMake(name.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : name.font } context:nil];
    name.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y, name.frame.size.width, nameFrame.size.height);
    
    
    // #########################################
    //              Set Affiliation
    // #########################################
    
    affiliation = [[UILabel alloc]initWithFrame:CGRectMake(28, name.frame.origin.y + name.frame.size.height + 20, 200, 65)];
    affiliation.center = CGPointMake(self.view.bounds.size.width/2, affiliation.frame.origin.y);
    //NSString *position, *company, *specialty,*location = nil;
    NSString *position, *company, *location = nil;
    
    // set-up position
    if ([profileContent objectForKey:@"position"] == (id)[NSNull null] || [[profileContent objectForKey:@"position"] isEqualToString:@""] ) {
        position = @"Jedi";
    } else {
        position = [profileContent objectForKey:@"position"];
    }
    NSLog(@"Done with position");
    // set-up company
    if ([profileContent objectForKey:@"company"] == (id)[NSNull null] || [[profileContent objectForKey:@"company"] isEqualToString:@""] ) {
        company = @"The Force";
    } else {
        company = [profileContent objectForKey:@"company"];
    }
    NSLog(@"Done with pcompany");
   /* //TEMPORARILY DISABLED
    // set-up specialty
    if ([[profileContent objectForKey:@"primary_technology"] objectForKey:@"name"] == (id)[NSNull null] || [[[profileContent objectForKey:@"primary_technology"]objectForKey:@"name"] isEqualToString:@""]) {
        specialty = @"Awesome Language";
        
    } else {
        specialty = [[profileContent objectForKey:@"primary_technology"]objectForKey:@"name"];
    }
    */
   // NSLog(@"Done with specialty %@", [[profileContent objectForKey:@"primary_technology"] objectForKey:@"name"]);
    
    
    // set-up location
    if ([profileContent objectForKey:@"location"] == (id)[NSNull null] || [[profileContent objectForKey:@"location"] isEqualToString:@""] ) {
        location = @"Philippines";
    } else {
        location = [profileContent objectForKey:@"location"];
    }
    NSLog(@"Done with location");
    
    //affiliation.text = [NSString stringWithFormat:@"%@ at %@ \n%@ \n%@", position, company, location, specialty ];
    affiliation.text = [NSString stringWithFormat:@"%@ at %@ \n%@", position, company, location ];
    affiliation.lineBreakMode = NSLineBreakByWordWrapping;
    affiliation.numberOfLines = 0;
    affiliation.textAlignment = NSTextAlignmentCenter;
    affiliation.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:12];
    affiliation.textColor = [UIColor whiteColor];
    [scrollView addSubview:affiliation];
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: affiliation.attributedText];
    // Company - Set Font
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12]
                 range:NSMakeRange(position.length+4, company.length)];
    
    [affiliation setAttributedText: text];
    
    // #########################################
    //              Technology Stack
    // #########################################
    
    UILabel *technologyStack = [[UILabel alloc]initWithFrame:CGRectMake(0, 330, 300, 50)];
    technologyStack.center = CGPointMake(self.view.bounds.size.width/2, technologyStack.center.y);
    technologyStack.textAlignment = NSTextAlignmentCenter;
    technologyStack.text = @"Technology Stack";
    technologyStack.textColor = UIColorFromRGB(0x83ac25);
    technologyStack.font = [UIFont fontWithName:@"PTSerif-Italic" size:14];
    [scrollView addSubview:technologyStack];
    
    // technologyStack - Resize Frame
    CGRect technologyStackFrame = [technologyStack.text boundingRectWithSize:CGSizeMake(technologyStack.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : technologyStack.font } context:nil];
    technologyStack.frame = CGRectMake(technologyStack.frame.origin.x, technologyStack.frame.origin.y, technologyStack.frame.size.width, technologyStackFrame.size.height);
    
    // #########################################
    //      Set Technology Stack Content
    // #########################################
    NSString *technologies = nil;
    // Get content for technology stack
    if ([profileContent objectForKey:@"technologies"] == (id)[NSNull null] || [[profileContent objectForKey:@"technologies"] count] == 0 ) {
        technologies = @" ";//@"Objective-C • JavaScript • PHP • CSS • MySQL • PostgreSQL • CakePHP";
    } else {
        technologies = @"compiled list of technologies";
    }
    
    UILabel *technologyStackContent = [[UILabel alloc]initWithFrame:CGRectMake(0, 345, 300, 50)];
    technologyStackContent.center = CGPointMake(self.view.bounds.size.width/2, technologyStackContent.center.y);
    technologyStackContent.textAlignment = NSTextAlignmentCenter;
    technologyStackContent.text = technologies;
    technologyStackContent.lineBreakMode = NSLineBreakByWordWrapping;
    technologyStackContent.numberOfLines = 0;
    technologyStackContent.font = [technologyStackContent.font fontWithSize:12];//[UIFont fontWithName:@"SourceSansPro-SemiBold" size:18];
    [scrollView addSubview:technologyStackContent];
    
    // technologyStackContent - Resize Frame
    CGRect technologyStackContentFrame = [technologyStackContent.text boundingRectWithSize:CGSizeMake(technologyStackContent.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : technologyStackContent.font } context:nil];
    technologyStackContent.frame = CGRectMake(technologyStackContent.frame.origin.x, technologyStackContent.frame.origin.y + 10, technologyStackContent.frame.size.width, technologyStackContentFrame.size.height);
    
    // #########################################
    //              Set About Header
    // #########################################
    
    UILabel *aboutHeader = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, 300, 50)];
    aboutHeader.center = CGPointMake(self.view.bounds.size.width/2, aboutHeader.center.y);
    aboutHeader.textAlignment = NSTextAlignmentCenter;
    aboutHeader.text = @"About Me";
    aboutHeader.textColor = UIColorFromRGB(0x83ac25);
    aboutHeader.font = [UIFont fontWithName:@"PTSerif-Italic" size:14];
    [scrollView addSubview:aboutHeader];
    
    // aboutHeader - Resize Frame
    CGRect aboutHeaderFrame = [aboutHeader.text boundingRectWithSize:CGSizeMake(aboutHeader.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : aboutHeader.font } context:nil];
    aboutHeader.frame = CGRectMake(aboutHeader.frame.origin.x, aboutHeader.frame.origin.y, aboutHeader.frame.size.width, aboutHeaderFrame.size.height);
    
    
    NSString *aboutText = nil;
    // Get content for technology stack
    if ([profileContent objectForKey:@"description"] == (id)[NSNull null] || [[profileContent objectForKey:@"description"] isEqualToString:@""]  ) {
        aboutText = @"The about section is to be filled soon!";
    } else {
        aboutText = [profileContent objectForKey:@"description"];
    }
    
    UILabel *aboutDescription = [[UILabel alloc]initWithFrame:CGRectMake(0, 430, 300, 50)];
    aboutDescription.center = CGPointMake(self.view.bounds.size.width/2, aboutDescription.center.y);
    aboutDescription.textAlignment = NSTextAlignmentJustified;
    aboutDescription.text = aboutText;
    aboutDescription.font = [aboutDescription.font fontWithSize:12];
    aboutDescription.lineBreakMode = NSLineBreakByWordWrapping;
    aboutDescription.numberOfLines = 0;
    [scrollView addSubview:aboutDescription];
    
    // aboutDescription - Resize Frame
    CGRect aboutDescriptionFrame = [aboutDescription.text boundingRectWithSize:CGSizeMake(aboutDescription.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : aboutDescription.font } context:nil];
    aboutDescription.frame = CGRectMake(aboutDescription.frame.origin.x, aboutDescription.frame.origin.y, aboutDescription.frame.size.width, aboutDescriptionFrame.size.height);
    
    
    // #########################################
    //              Set ScrollView Content
    // #########################################
    
    float sizeOfContent = 0;
    UIView *lLast = [scrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    
    sizeOfContent = wd+ht;
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, sizeOfContent + 10);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
