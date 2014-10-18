//
//  ProgramsViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "ProgramsViewController.h"
#import "SWRevealViewController.h"
#import "CustomTableViewCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface ProgramsViewController () {
    NSDictionary *program;
    NSArray *programTitles;
}
@end

@implementation ProgramsViewController

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
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Programs";
    
    program = @{@"9:00 AM" : @[@"Welcome Remarks | By DevCon Representative"],
                @"9:15 AM" : @[@"Sponsor Talks | By Deltek, Accenture"],
                @"10:30 AM" : @[@"The Big Picture for Pinoy Developers | Calen Martin Legaspi of PSIA"],
                @"11:00 AM" : @[@"Panel: Developer Opportunities | By Jobstreet, Freelancer, PSIA"],
                @"12:00 AM" : @[@"Lunch Break | Games + Networking"],
                @"1:00 PM" : @[@"Trends in Android Development | By Android Expert "]};
    
    programTitles = [[program allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [programTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [programTitles objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = UIColorFromRGB(0xdb6d2c); 
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [programTitles objectAtIndex:section];
    NSArray *sectionPrograms = [program objectForKey:sectionTitle];
    return [sectionPrograms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    cell.header.text = @"Haifa Baluyos. Software Engineer at DevCon";
    
    
    NSString *programTitle = [programTitles objectAtIndex:indexPath.section];
    NSArray *sectionProgram = [program objectForKey:programTitle];
    NSString *programs= [sectionProgram objectAtIndex: indexPath.row ];
    cell.textLabel.text = programs;
    cell.textLabel.textColor = UIColorFromRGB(0xdb6d2c);
    
    //SET IMAGEVIEW
    cell.imageView.image = [UIImage imageNamed:@"haifa.jpg"]; //tentative content
    
    
    // SET DETAILED TEXT LABEL
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"Panel Discussion";
            cell.detailTextLabel.text = @"Micael Diaz de River. OLX PH \nHaifa Baluyos. DEVCON \nTerence Ponce. Aelogica";
        }
            break;
            
        default:
            cell.detailTextLabel.text = @"This talk is all about awesomeness!";
            break;
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
