//
//  NewsContentViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/18/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "NewsContentViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface NewsContentViewController ()

@end

@implementation NewsContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x83ac25);
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"haifa.jpg"]];
    imageView.frame = CGRectMake(0, 0 + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height * 0.45);
    imageView.contentMode  = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    
    CGRect frame = CGRectMake(0, imageView.frame.origin.y + (imageView.frame.size.height * 0.65), self.view.frame.size.width, imageView.frame.size.height * 0.35);
    UIView *titleBG = [[UIView alloc]initWithFrame:frame];
    titleBG.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
    [self.view addSubview:titleBG];
    
    UILabel *title = [[UILabel alloc]initWithFrame: CGRectMake(10, frame.origin.y, frame.size.width, frame.size.height)];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.numberOfLines = 0;
    title.textColor = UIColorFromRGB(0x83ac25);
    title.font = [UIFont fontWithName:@"SourceSansPro-SemiBold" size:20];
    title.text = @"Meet our Android Speaker from Philippine Android Developers Community!";
    [self.view addSubview:title];
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(10, title.frame.origin.y + title.frame.size.height , self.view.frame.size.width - 20, 200)];
    content.lineBreakMode = NSLineBreakByWordWrapping;
    content.numberOfLines = 0;
    content.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, ";
    content.font = [UIFont fontWithName:@"Merriweather-Regular" size:14];
    
    [self.view addSubview:content];
    
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"FONT %@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
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
