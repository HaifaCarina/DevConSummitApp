//
//  SponsorsViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/4/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MyManager.h"
#import "SponsorsViewController.h"
#import "SWRevealViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface SponsorsViewController () {
    NSDictionary *sponsorsImages;
}
@end

@implementation SponsorsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set global variable to use in this viewcontroller
    //MyManager *globals = [MyManager sharedManager];
    //object = globals.speakersObject;
    //sponsorsImages = globals.sponsorsImages;
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Sponsors & Partners";
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5; //[sponsorsList count];
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
            title = @"Contributing Partners";
            break;
        case 4:
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
        float logoWidth = cell.contentView.frame.size.width/2;
        float logoHeight = 60;
        
        switch (indexPath.section) {
            case 0: {
                UIImageView *copresenter1 = [[UIImageView alloc] init];
                copresenter1.contentMode  = UIViewContentModeScaleAspectFit;
                copresenter1.image = [UIImage imageNamed:@"Copresenter-Accenture.png"];
                copresenter1.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                copresenter1.center = CGPointMake(cell.contentView.frame.size.width/2 - copresenter1.frame.size.width/2, cell.contentView.frame.size.height/2 + 40 - copresenter1.frame.size.height/2);
                //copresenter1.backgroundColor = [UIColor yellowColor];
                [cell.contentView addSubview:copresenter1];
                
                UIImageView *copresenter2 = [[UIImageView alloc] init];
                copresenter2.contentMode  = UIViewContentModeScaleAspectFit;
                copresenter2.image = [UIImage imageNamed:@"Copresenter-Smart.png"];
                copresenter2.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                copresenter2.center = CGPointMake(cell.contentView.frame.size.width - copresenter2.frame.size.width/2, cell.contentView.frame.size.height/2  + 40 - logoHeight/2);
                //copresenter2.backgroundColor = [UIColor yellowColor];
                [cell.contentView addSubview:copresenter2];
                
                UIImageView *copresenter3 = [[UIImageView alloc] init];
                copresenter3.contentMode  = UIViewContentModeScaleAspectFit;
                copresenter3.image = [UIImage imageNamed:@"Copresenter-Deltek.png"];
                copresenter3.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                copresenter3.center = CGPointMake(cell.contentView.frame.size.width/2 , (cell.contentView.frame.size.height/2) + 40 + logoHeight/2 );
                //copresenter3.backgroundColor = [UIColor yellowColor];
                [cell.contentView addSubview:copresenter3];
                
                
                break;
            }
            case 1: {
                UIImageView *gold1 = [[UIImageView alloc] init];
                gold1.contentMode  = UIViewContentModeScaleAspectFit;
                gold1.image = [UIImage imageNamed:@"Gold-Microsoft.png"];
                gold1.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                gold1.center = CGPointMake(cell.contentView.frame.size.width/2 - logoWidth/2, cell.contentView.frame.size.height/2 + 40 - logoHeight/2);
                //gold1.backgroundColor = [UIColor yellowColor];
                [cell.contentView addSubview:gold1];
                
                UIImageView *gold2 = [[UIImageView alloc] init];
                gold2.contentMode  = UIViewContentModeScaleAspectFit;
                gold2.image = [UIImage imageNamed:@"Gold-Microsourcing.png"];
                gold2.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                gold2.center = CGPointMake(cell.contentView.frame.size.width - logoWidth/2, cell.contentView.frame.size.height/2  + 40 - logoHeight/2);
                [cell.contentView addSubview:gold2];
                
                UIImageView *gold3 = [[UIImageView alloc] init];
                gold3.contentMode  = UIViewContentModeScaleAspectFit;
                gold3.image = [UIImage imageNamed:@"Gold-Canva.png"];
                gold3.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                gold3.center = CGPointMake(cell.contentView.frame.size.width/2 , (cell.contentView.frame.size.height/2) + 40 + logoHeight/2 );
                [cell.contentView addSubview:gold3];
                
                
                break;
            }
            case 2: {
                UIImageView *silver1 = [[UIImageView alloc] init];
                silver1.contentMode  = UIViewContentModeScaleAspectFit;
                silver1.image = [UIImage imageNamed:@"Silver-Colab.png"];
                silver1.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                silver1.center = CGPointMake(cell.contentView.frame.size.width/2 - logoWidth/2 + 10, cell.contentView.frame.size.height/2 + 40 - logoHeight/2);
                [cell.contentView addSubview:silver1];
                
                UIImageView *silver2 = [[UIImageView alloc] init];
                silver2.contentMode  = UIViewContentModeScaleAspectFit;
                silver2.image = [UIImage imageNamed:@"Silver-Mozilla.png"];
                silver2.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                silver2.center = CGPointMake(cell.contentView.frame.size.width - logoWidth/2 + 10, cell.contentView.frame.size.height/2  + 40 - logoHeight/2);
                [cell.contentView addSubview:silver2];
                
                UIImageView *silver3 = [[UIImageView alloc] init];
                silver3.contentMode  = UIViewContentModeScaleAspectFit;
                silver3.image = [UIImage imageNamed:@"Silver-Novare.png"];
                silver3.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                silver3.center = CGPointMake(cell.contentView.frame.size.width/2 - logoWidth/2 + 10, (cell.contentView.frame.size.height/2) + 40 + logoHeight/2);
                [cell.contentView addSubview:silver3];
                
                UIImageView *silver4 = [[UIImageView alloc] init];
                silver4.contentMode  = UIViewContentModeScaleAspectFit;
                silver4.image = [UIImage imageNamed:@"Silver-ChikkaAPI.png"];
                silver4.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                silver4.center = CGPointMake(cell.contentView.frame.size.width - logoWidth/2 + 10, (cell.contentView.frame.size.height/2) + 40 + logoHeight/2);
                [cell.contentView addSubview:silver4];
                
                break;
            }
                
            case 3: {
                UIImageView *CP1 = [[UIImageView alloc] init];
                CP1.contentMode  = UIViewContentModeScaleAspectFit;
                CP1.image = [UIImage imageNamed:@"CP-StackOverflow.png"];
                CP1.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                CP1.center = CGPointMake(cell.contentView.frame.size.width/2 - logoWidth/2 + 10, cell.contentView.frame.size.height/2 + 40 - logoHeight/2);
                [cell.contentView addSubview:CP1];
                
                UIImageView *CP2 = [[UIImageView alloc] init];
                CP2.contentMode  = UIViewContentModeScaleAspectFit;
                CP2.image = [UIImage imageNamed:@"CP-GlobeLabs.png"];
                CP2.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                CP2.center = CGPointMake(cell.contentView.frame.size.width - logoWidth/2 , cell.contentView.frame.size.height/2  + 40 - logoHeight/2);
                [cell.contentView addSubview:CP2];
                
                UIImageView *CP3 = [[UIImageView alloc] init];
                CP3.contentMode  = UIViewContentModeScaleAspectFit;
                CP3.image = [UIImage imageNamed:@"CP-Uber.png"];
                CP3.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                CP3.center = CGPointMake(cell.contentView.frame.size.width/2 - logoWidth/2 + 10, (cell.contentView.frame.size.height/2) + 40 + logoHeight/2);
                [cell.contentView addSubview:CP3];
                
                UIImageView *CP4 = [[UIImageView alloc] init];
                CP4.contentMode  = UIViewContentModeScaleAspectFit;
                CP4.image = [UIImage imageNamed:@"CP-GitHub.png"];
                CP4.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                CP4.center = CGPointMake(cell.contentView.frame.size.width - logoWidth/2 + 10, (cell.contentView.frame.size.height/2) + 40 + logoHeight/2);
                [cell.contentView addSubview:CP4];
                
                break;
            }
            case 4: {
                UIImageView *media1 = [[UIImageView alloc] init];
                media1.contentMode  = UIViewContentModeScaleAspectFit;
                media1.image = [UIImage imageNamed:@"Media-WebGeek.png"];
                media1.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                media1.center = CGPointMake(cell.contentView.frame.size.width/2 - logoWidth/2 + 10, cell.contentView.frame.size.height/2 + 40 - logoHeight/2);
                [cell.contentView addSubview:media1];
                
                UIImageView *media2 = [[UIImageView alloc] init];
                media2.contentMode  = UIViewContentModeScaleAspectFit;
                media2.image = [UIImage imageNamed:@"Media-WhenInManila.png"];
                media2.frame = CGRectMake(0, 0, logoWidth, logoHeight);
                media2.center = CGPointMake(cell.contentView.frame.size.width - logoWidth/2 , cell.contentView.frame.size.height/2  + 40 - logoHeight/2);
                [cell.contentView addSubview:media2];
                
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
    
    return 140;
    
    
}
@end
