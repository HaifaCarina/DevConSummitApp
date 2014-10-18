//
//  SpeakerProfileViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/6/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "SpeakerProfileViewController.h"
#import "UIImage+StackBlur.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation SpeakerProfileViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xfbfaf7);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x83ac25);
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
    UIImage *image = [UIImage imageNamed:@"haifa.jpg"];
    
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
    background.backgroundColor = UIColorFromRGB(0x6A4FFA);
    [scrollView addSubview:background];
    
    // #########################################
    //              Set Image View
    // #########################################
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    imageView.center = CGPointMake(self.view.bounds.size.width/2, 180);
    imageView.image = [UIImage imageNamed:@"haifa.jpg"];
    imageView.layer.borderColor = UIColorFromRGB(0x6A4FFA).CGColor;
    imageView.layer.borderWidth = 2;
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    [scrollView addSubview:imageView];
    
    // #########################################
    //              Set Name
    // #########################################
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.9, 40)];
    name.text = @"HAIFA CARINA BALUYOS";
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
    
    UILabel *affiliation = [[UILabel alloc]initWithFrame:CGRectMake(28, name.frame.origin.y + name.frame.size.height + 20, 200, 65)];
    affiliation.center = CGPointMake(self.view.bounds.size.width/2, affiliation.frame.origin.y);
    NSString *position = @"Software Engineer";
    NSString *company = @"DevCon";
    NSString *twitter = @"@haifacarina";
    NSString *website = @"http://haifacarina.com";
    
    affiliation.text = [NSString stringWithFormat:@"%@ at %@ \n%@ \n%@", position, company, twitter, website ];
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
    //              Set Event Role
    // #########################################
    
    UILabel *eventRole = [[UILabel alloc]initWithFrame:CGRectMake(0, 330, 300, 50)];
    eventRole.center = CGPointMake(self.view.bounds.size.width/2, eventRole.center.y);
    eventRole.textAlignment = NSTextAlignmentCenter;
    eventRole.text = @"Resource Speaker";
    eventRole.textColor = UIColorFromRGB(0x83ac25);
    eventRole.font = [UIFont fontWithName:@"PTSerif-Italic" size:14];
    [scrollView addSubview:eventRole];
    
    // EventRole - Resize Frame
    CGRect eventRoleFrame = [eventRole.text boundingRectWithSize:CGSizeMake(eventRole.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : eventRole.font } context:nil];
    eventRole.frame = CGRectMake(eventRole.frame.origin.x, eventRole.frame.origin.y, eventRole.frame.size.width, eventRoleFrame.size.height);
    
    // #########################################
    //              Set talkTitle
    // #########################################
    
    UILabel *talkTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 345, 300, 50)];
    talkTitle.center = CGPointMake(self.view.bounds.size.width/2, talkTitle.center.y);
    talkTitle.textAlignment = NSTextAlignmentCenter;
    talkTitle.text = @"Trends and Best Practices in Android Development";
    talkTitle.lineBreakMode = NSLineBreakByWordWrapping;
    talkTitle.numberOfLines = 0;
    talkTitle.font = [UIFont fontWithName:@"SourceSansPro-SemiBold" size:18];
    [scrollView addSubview:talkTitle];
    
    // talkTitle - Resize Frame
    CGRect talkTitleFrame = [talkTitle.text boundingRectWithSize:CGSizeMake(talkTitle.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : talkTitle.font } context:nil];
    talkTitle.frame = CGRectMake(talkTitle.frame.origin.x, talkTitle.frame.origin.y, talkTitle.frame.size.width, talkTitleFrame.size.height);

    // #########################################
    //              Set About Header
    // #########################################
 
    UILabel *aboutHeader = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, 300, 50)];
    aboutHeader.center = CGPointMake(self.view.bounds.size.width/2, aboutHeader.center.y);
    aboutHeader.textAlignment = NSTextAlignmentCenter;
    aboutHeader.text = @"About Haifa";
    aboutHeader.textColor = UIColorFromRGB(0x83ac25);
    aboutHeader.font = [UIFont fontWithName:@"PTSerif-Italic" size:14];
    [scrollView addSubview:aboutHeader];
    
    // aboutHeader - Resize Frame
    CGRect aboutHeaderFrame = [aboutHeader.text boundingRectWithSize:CGSizeMake(aboutHeader.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : aboutHeader.font } context:nil];
    aboutHeader.frame = CGRectMake(aboutHeader.frame.origin.x, aboutHeader.frame.origin.y, aboutHeader.frame.size.width, aboutHeaderFrame.size.height);
    
  
    // #########################################
    //              Set About Description
    // #########################################
    
    UILabel *aboutDescription = [[UILabel alloc]initWithFrame:CGRectMake(0, 430, 300, 50)];
    aboutDescription.center = CGPointMake(self.view.bounds.size.width/2, aboutDescription.center.y);
    aboutDescription.textAlignment = NSTextAlignmentJustified;
    aboutDescription.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, ";
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
@end
