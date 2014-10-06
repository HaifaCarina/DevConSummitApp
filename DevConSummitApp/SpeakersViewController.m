//
//  SpeakersViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/30/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SWRevealViewController.h"
#import "SpeakersTableViewCell.h"
#import "SpeakerProfileViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface SpeakersViewController () {
    SWRevealViewController *revealController;

}
@end

@implementation SpeakersViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};

    // Set-up navigation drawer
    revealController = [self revealViewController];
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Speakers";
    
    // Set-up tabs
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Speakers", @"Panelists", nil]];
    segmentedControl.frame = CGRectMake(10, 80, 300, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = UIColorFromRGB(0x83ac25);
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    // Set-up tableview
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
}


- (void)valueChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        //action for the first button (All)
    }else if(segment.selectedSegmentIndex == 1){
        //action for the second button (Present)
    }else if(segment.selectedSegmentIndex == 2){
        //action for the third button (Missing)
    }
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
    SpeakersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[SpeakersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.contentView.backgroundColor = UIColorFromRGB(0xfbfaf7);
    
    NSString *text = nil;
    UIView *bgColorView = [[UIView alloc] init];
    
    switch ( indexPath.row )
    {
        case 0: {
            text = @"Haifa Carina Baluyos";
            break;
        }
        case 1: {
            text = @"Terence Ponce";
            break;
            
        }
        case 2: {
            text = @"Lope Emano";
            break;
        }
        case 3: {
            text = @"Nathaniel Cailo";
            break;
        }
        case 4: {
            text = @"Kim Culango";
            break;
        }
        case 5: {
            text = @"Eric Luciano";
            break;
        }
        case 6: {
            text = @"Nicholo Katipunan";
            break;
        }
        case 7: {
            text = @"Melanie Taduan";
            break;
        }
    }
    
    cell.textLabel.text = text;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //Set image
    cell.imageView.image = [UIImage imageNamed:@"haifa.jpg"]; //tentative content
    
    
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
    
    SpeakerProfileViewController *profileView = [[SpeakerProfileViewController alloc] init];
    [self.navigationController pushViewController:profileView animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
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
