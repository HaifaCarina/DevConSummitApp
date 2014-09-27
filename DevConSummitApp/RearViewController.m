//
//  RearViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "RearViewController.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface RearViewController ()

@end

@implementation RearViewController

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
    
    self.tableView.backgroundColor = UIColorFromRGB(0xfbfaf7);
    [[self navigationController] setNavigationBarHidden:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.contentView.backgroundColor = UIColorFromRGB(0xfbfaf7);
    
    NSString *text = nil;
    switch ( indexPath.row )
    {
        case 0: {
            text = @"My Profile";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
        }
        case 1: {
            text = @"News";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 2: {
            text = @"Programs";
            cell.textLabel.textColor = UIColorFromRGB(0xdb6d2c);
            break;
        }
        case 3: {
            text = @"Speakers";
            cell.textLabel.textColor = UIColorFromRGB(0x6A4FFA);
            break;
        }
        case 4: {
            text = @"Attendees";
            cell.textLabel.textColor = UIColorFromRGB(0xe6c630);
            break;
        }
        case 5: {
            text = @"Sponsors";
            cell.textLabel.textColor = UIColorFromRGB(0x3DA6E5);
            break;
        }
        case 6: {
            text = @"Leaderboard";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
        }
        case 7: {
            text = @"Engage";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
        }
    }
    
    cell.textLabel.text = text;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select %@", indexPath);
    
    
    
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    if ( row == _presentedRow )
    {
        NSLog(@"user chose same row");
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    
    UIViewController *frontController = nil;
    
    
    if (indexPath.row == 0) {
        NSLog(@"Should Display FrontViewController with My Profile");
        
        FrontViewController *frontViewController = [[FrontViewController alloc] init];
        frontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    } else {
        FrontViewController *frontViewController = [[FrontViewController alloc] init];
        frontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    [revealController pushFrontViewController:frontController animated:YES];
    _presentedRow = row;  // <- store the presented row
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
