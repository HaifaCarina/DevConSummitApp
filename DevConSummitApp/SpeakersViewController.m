//
//  SpeakersViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/30/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MyManager.h"
#import "SpeakersViewController.h"
#import "SWRevealViewController.h"
#import "SpeakersTableViewCell.h"
#import "SpeakerProfileViewController.h"
#import "KeychainItemWrapper.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface SpeakersViewController () <NSURLConnectionDelegate> {
    SWRevealViewController *revealController;
    NSDictionary *object;
    NSArray *speakersImages;
    
}
@property (nonatomic, strong) UITableView *tableView;
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
    // Set global variable to use in this viewcontroller
    MyManager *globals = [MyManager sharedManager];
    object = globals.speakersObject;
    speakersImages = globals.speakersImages;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};

    // Set-up navigation drawer
    revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Speakers";
    
    // Set-up tabs
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Speakers", @"Panelists", nil]];
    segmentedControl.frame = CGRectMake(10, 80, 300, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = UIColorFromRGB(0x83ac25);
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    //[self.view addSubview:segmentedControl];
    
    // Set-up tableview
    //self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[object objectForKey:@"speakers"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SpeakersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[SpeakersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.contentView.backgroundColor = UIColorFromRGB(0xfbfaf7);
    
    NSString *name, *position, *company, *description, *photo, *website, *twitter, *category, *title = nil;
    // #########################################
    //        Set Content Based On Speakers Data
    // #########################################
    if (indexPath.row < [[object objectForKey:@"speakers"] count]) {
        
        id speakerContent = [[[object objectForKey:@"speakers"] objectAtIndex:indexPath.row] objectForKey:@"speaker"];
        
        name = [NSString stringWithFormat:@"%@ %@",[speakerContent objectForKey:@"first_name"], [speakerContent objectForKey:@"last_name"]];
        position = [speakerContent objectForKey:@"position"];
        company = [speakerContent objectForKey:@"company"];
        description = [speakerContent objectForKey:@"description"];
        photo = [speakerContent objectForKey:@"photo_url"];
        twitter = [speakerContent objectForKey:@"twitter_handle"];
        website = [speakerContent objectForKey:@"website"];
        
       
        cell.imageView.image =  [speakersImages objectAtIndex:indexPath.row];

        int count = (int)[[speakerContent objectForKey:@"category"] count];
        
        if ( count > 1 ) {
            NSMutableString *categorySummary = [[NSMutableString alloc]init];
            
            for (int i=0; i < count ; i++) {
                if (i>0) [categorySummary appendString:@", "];
                [categorySummary appendFormat:@"%@", [[speakerContent objectForKey:@"category"] objectAtIndex:i]];
            }
            
            category = categorySummary;
            title = [[speakerContent objectForKey:@"talk"] objectAtIndex:0];
            
        } else {
            category = @"TBA";
            title = @"TBA";
        }
        
    }
    cell.header.text = category;
    cell.textLabel.text = name;
    cell.affiliation.text = [NSString stringWithFormat:@"%@ at %@",position, company];
    cell.title.text = title;
    cell.detailTextLabel.text = @"";
    
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
    profileView.selection = (int) indexPath.row;
    [self.navigationController pushViewController:profileView animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
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
