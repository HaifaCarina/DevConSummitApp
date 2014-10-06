//
//  SponsorsViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/4/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "SponsorsViewController.h"
#import "SWRevealViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface SponsorsViewController () {

}
@end

@implementation SponsorsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    
    SWRevealViewController *revealController = [self revealViewController];
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Sponsors & Partners";
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6; //[sponsorsList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    //return [[sponsorsList objectAtIndex:section]  allKeys][0];
    NSString *title;
    switch (section) {
        case 0:
            title = @"Co-Presenter";
            break;
        case 1:
            title = @"Gold Sponsors";
            break;
        case 2:
            title = @"Silver Sponsors";
            break;
        case 3:
            title = @"Community Partners";
            break;
        case 4:
            title = @"Contributing Partners";
            break;
        case 5:
            title = @"Media Partners";
            break;
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = UIColorFromRGB(0x3DA6E5);
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
        switch (indexPath.section) {
            case 0: {
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.contentMode  = UIViewContentModeScaleAspectFit;
                imageView1.image = [UIImage imageNamed:@"Gold-accenture.png"];
                imageView1.frame = CGRectMake(40, 10, 100, 80);
                [cell.contentView addSubview:imageView1];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.contentMode  = UIViewContentModeScaleAspectFit;
                imageView2.image = [UIImage imageNamed:@"Gold-Canva.png"];
                imageView2.frame = CGRectMake(160, 10, 100, 80);
                [cell.contentView addSubview:imageView2];
                
                break;
            }
            case 1: {
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.contentMode  = UIViewContentModeScaleAspectFit;
                imageView1.image = [UIImage imageNamed:@"CP-uber.png"];
                imageView1.frame = CGRectMake(40, 10, 100, 80);
                [cell.contentView addSubview:imageView1];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.contentMode  = UIViewContentModeScaleAspectFit;
                imageView2.image = [UIImage imageNamed:@"CP-GitHub.png"];
                imageView2.frame = CGRectMake(160, 10, 100, 80);
                [cell.contentView addSubview:imageView2];
                
                break;
            }
            case 2: {
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.contentMode  = UIViewContentModeScaleAspectFit;
                imageView1.image = [UIImage imageNamed:@"Gold-accenture.png"];
                imageView1.frame = CGRectMake(40, 10, 100, 80);
                [cell.contentView addSubview:imageView1];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.contentMode  = UIViewContentModeScaleAspectFit;
                imageView2.image = [UIImage imageNamed:@"Gold-Canva.png"];
                imageView2.frame = CGRectMake(160, 10, 100, 80);
                [cell.contentView addSubview:imageView2];
                
                break;
            }
                
            case 3: {
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.contentMode  = UIViewContentModeScaleAspectFit;
                imageView1.image = [UIImage imageNamed:@"Gold-accenture.png"];
                imageView1.frame = CGRectMake(40, 10, 100, 80);
                [cell.contentView addSubview:imageView1];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.contentMode  = UIViewContentModeScaleAspectFit;
                imageView2.image = [UIImage imageNamed:@"Gold-Canva.png"];
                imageView2.frame = CGRectMake(160, 10, 100, 80);
                [cell.contentView addSubview:imageView2];
                
                break;
            }
            case 4: {
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.contentMode  = UIViewContentModeScaleAspectFit;
                imageView1.image = [UIImage imageNamed:@"Gold-accenture.png"];
                imageView1.frame = CGRectMake(40, 10, 100, 80);
                [cell.contentView addSubview:imageView1];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.contentMode  = UIViewContentModeScaleAspectFit;
                imageView2.image = [UIImage imageNamed:@"Gold-Canva.png"];
                imageView2.frame = CGRectMake(160, 10, 100, 80);
                [cell.contentView addSubview:imageView2];
                
                break;
            }
            case 5: {
                UIImageView *imageView1 = [[UIImageView alloc] init];
                imageView1.contentMode  = UIViewContentModeScaleAspectFit;
                imageView1.image = [UIImage imageNamed:@"Gold-accenture.png"];
                imageView1.frame = CGRectMake(40, 10, 100, 80);
                [cell.contentView addSubview:imageView1];
                
                UIImageView *imageView2 = [[UIImageView alloc] init];
                imageView2.contentMode  = UIViewContentModeScaleAspectFit;
                imageView2.image = [UIImage imageNamed:@"Gold-Canva.png"];
                imageView2.frame = CGRectMake(160, 10, 100, 80);
                [cell.contentView addSubview:imageView2];
                
                break;
            }
        }
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"tableView willDisplayCell %@", indexPath);
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  NSLog(@"did select %@", indexPath);
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
    
}
@end
