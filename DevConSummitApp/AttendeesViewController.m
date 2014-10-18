//
//  AttendeesViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/6/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "AttendeesViewController.h"
#import "SWRevealViewController.h"
#import "AttendeesTableViewCell.h"
#import "AttendeeProfileViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation AttendeesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Attendees";
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    AttendeesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[AttendeesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    NSString *name = @"Haifa Carina Baluyos";
    NSString *position = @"Software Engineer";
    NSString *company = @"Developers Connect";
    NSString *specialty = @"Objective-C";
    NSString *location = @"Metro Manila";
    UIImage *image = [UIImage imageNamed:@"haifa.jpg"];
    
    cell.imageView.image = image;
    cell.textLabel.text = name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ at %@ \n%@ • %@", position, company, specialty, location ];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:12];
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: cell.detailTextLabel.attributedText];
    // Company - Set Font
    [text addAttribute:NSForegroundColorAttributeName
                 value:UIColorFromRGB(0x83ac25)
                 range:NSMakeRange(position.length+4, company.length)];
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12]
                 range:NSMakeRange(position.length+4, company.length)];
    
    // Specialty - Set Font
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12]
                 range:NSMakeRange(position.length+ company.length +6, specialty.length)];
    
    [cell.detailTextLabel setAttributedText: text];
    

    
    
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
      NSLog(@"did select %@", indexPath);
    
    AttendeeProfileViewController *profileView = [[AttendeeProfileViewController alloc] init];
    [self.navigationController pushViewController:profileView animated:YES];

    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
    
}
@end
