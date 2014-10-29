//
//  RearViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MyManager.h"
#import "RearViewController.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "ProgramsViewController.h"
#import "SpeakersViewController.h"
#import "SponsorsViewController.h"
#import "NewsViewController.h"
#import "AttendeesViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface RearViewController () {
    NSDictionary *object;
    UIImage *profileImage;
}

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
    
    // Set global variable to use in this viewcontroller
    MyManager *globals = [MyManager sharedManager];
    object = globals.profileObject;
    profileImage = globals.profileImage;
    
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
    UIView *bgColorView = [[UIView alloc] init];
    
    switch ( indexPath.row )
    {
        case 0: {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 00, 90, 90)];
            
            imageView.image = profileImage; //[UIImage imageNamed:@"haifa.jpg"];
            imageView.center = CGPointMake(cell.contentView.center.x-(cell.contentView.center.x * 0.20), cell.contentView.center.y + (cell.contentView.center.y * 1.50));
            imageView.backgroundColor = [UIColor clearColor];
            
            
            CAShapeLayer *circle = [CAShapeLayer layer];
            
            // Make a circular shape
            UIBezierPath *circularPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height) cornerRadius:MAX(imageView.frame.size.width, imageView.frame.size.height)];
            circle.path = circularPath.CGPath;
            
            imageView.layer.mask=circle;
            
            
            NSLog(@"%f",cell.contentView.center.y);
            
            //cell.contentView.backgroundColor = [UIColor greenColor];
            
            
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"myprofile-background.png"]];
            
            [cell.contentView addSubview:imageView];
            //Set-up data
            NSDictionary *profileContent = [[object objectForKey:@"profile"] objectForKey:@"user"];
            
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
            name.text = [NSString stringWithFormat:@"%@ %@", [profileContent objectForKey:@"first_name"], [profileContent objectForKey:@"last_name"]];
            name.center = CGPointMake(cell.contentView.center.x -(cell.contentView.center.x * 0.20), cell.contentView.center.y + (cell.contentView.center.y * 4.50) );
            name.lineBreakMode = NSLineBreakByWordWrapping;
            name.numberOfLines = 0;
            name.textAlignment = NSTextAlignmentCenter;
            name.textColor = UIColorFromRGB(0x83ac25);
            name.font = [UIFont fontWithName:@"SourceSansPro-SemiBold" size:15];
            [cell.contentView addSubview:name];
            
            // Name - Resize Frame
            CGRect nameFrame = [name.text boundingRectWithSize:CGSizeMake(name.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : name.font } context:nil];
            name.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y, name.frame.size.width, nameFrame.size.height);
            
            ///
            UILabel *affiliation = [[UILabel alloc]initWithFrame:CGRectMake(28, name.frame.origin.y + name.frame.size.height , 200, 65)];
            NSString *position, *company, *specialty,*location = nil;
            
            // set-up position
            if ([profileContent objectForKey:@"position"] == (id)[NSNull null] || [[profileContent objectForKey:@"position"] isEqualToString:@""] ) {
                position = @"Jedi";
            } else {
                position = [profileContent objectForKey:@"position"];
            }
            
            // set-up company
            if ([profileContent objectForKey:@"company"] == (id)[NSNull null] || [[profileContent objectForKey:@"company"] isEqualToString:@""] ) {
                company = @"The Force";
            } else {
                company = [profileContent objectForKey:@"company"];
            }
            
            // set-up specialty
            if ([profileContent objectForKey:@"primary_technology"] == (id)[NSNull null] || [[profileContent objectForKey:@"primary_technology"] isEqualToString:@""]) {
                specialty = @"Awesome Language";
            } else {
                specialty = [profileContent objectForKey:@"primary_technology"];
            }
            
            // set-up location
            if ([profileContent objectForKey:@"location"] == (id)[NSNull null] || [[profileContent objectForKey:@"location"] isEqualToString:@""] ) {
                location = @"Philippines";
            } else {
                location = [profileContent objectForKey:@"location"];
            }
            
            affiliation.text = [NSString stringWithFormat:@"%@ at %@ \n%@ \n%@", position, company, specialty, location ];
            affiliation.lineBreakMode = NSLineBreakByWordWrapping;
            affiliation.numberOfLines = 0;
            affiliation.textAlignment = NSTextAlignmentCenter;
            affiliation.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:12];
            [cell.contentView addSubview:affiliation];
            
            
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: affiliation.attributedText];
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
            
            [affiliation setAttributedText: text];
            
            // affiliation - Resize Frame
            CGRect affiliationFrame = [affiliation.text boundingRectWithSize:CGSizeMake(affiliation.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : affiliation.font } context:nil];
            affiliation.frame = CGRectMake(affiliation.frame.origin.x, affiliation.frame.origin.y, affiliation.frame.size.width, affiliationFrame.size.height);
            
            break;
        }
        case 1: {
            text = @"News";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            bgColorView.backgroundColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 2: {
            text = @"Programs";
            cell.textLabel.textColor = UIColorFromRGB(0xdb6d2c);
            bgColorView.backgroundColor = UIColorFromRGB(0xdb6d2c);
            break;
        }
        case 3: {
            text = @"Speakers";
            cell.textLabel.textColor = UIColorFromRGB(0x6A4FFA);
            bgColorView.backgroundColor = UIColorFromRGB(0x6A4FFA);
            break;
        }
        case 4: {
            text = @"Attendees";
            cell.textLabel.textColor = UIColorFromRGB(0xe6c630);
            bgColorView.backgroundColor = UIColorFromRGB(0xe6c630);
            break;
        }
        case 5: {
            text = @"Sponsors";
            cell.textLabel.textColor = UIColorFromRGB(0x3DA6E5);
            bgColorView.backgroundColor = UIColorFromRGB(0x3DA6E5);
            break;
        }
        case 6: {
            text = @"Leaderboard";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            bgColorView.backgroundColor = UIColorFromRGB(0x83ac25);
            break;
        }
        case 7: {
            text = @"Engage";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            bgColorView.backgroundColor = UIColorFromRGB(0x83ac25);
            break;
        }
    }
    
    cell.textLabel.text = text;
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    [cell setSelectedBackgroundView:bgColorView];
    
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
    } else if (indexPath.row == 1) {
        NSLog(@"Should Display New");
        
        NewsViewController *newsController = [[NewsViewController alloc]init];
        frontController = [[UINavigationController alloc] initWithRootViewController:newsController];
        
    } else if (indexPath.row == 2) {
        NSLog(@"Should Display Programs");
        
        ProgramsViewController *programsController = [[ProgramsViewController alloc]init];
        frontController = [[UINavigationController alloc] initWithRootViewController:programsController];
        
    } else if (indexPath.row == 3) {
        NSLog(@"Should Display Speakers");
        
        SpeakersViewController *speakersController = [[SpeakersViewController alloc]init];
        frontController = [[UINavigationController alloc] initWithRootViewController:speakersController];
        
    } else if (indexPath.row == 4) {
        NSLog(@"Should Display Speakers");
        
        AttendeesViewController *attendeesController = [[AttendeesViewController alloc]init];
        frontController = [[UINavigationController alloc] initWithRootViewController:attendeesController];
        
    } else if (indexPath.row == 5) {
        NSLog(@"Should Display Sponsors");
        
        SponsorsViewController *sponsorsController = [[SponsorsViewController alloc]init];
        frontController = [[UINavigationController alloc] initWithRootViewController:sponsorsController];
        
    } else {
        FrontViewController *frontViewController = [[FrontViewController alloc] init];
        frontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    [revealController pushFrontViewController:frontController animated:YES];
    _presentedRow = row;  // <- store the presented row
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    } else {
        return 50;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
