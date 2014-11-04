//
//  ProgramsViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MyManager.h"
#import "ProgramsViewController.h"
#import "SWRevealViewController.h"
#import "CustomTableViewCell.h"
#import "KeychainItemWrapper.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface ProgramsViewController () <NSURLConnectionDelegate>{
    NSDictionary *object;
    NSArray *programsImages;
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
    
    // Set global variable to use in this viewcontroller
    MyManager *globals = [MyManager sharedManager];
    object = globals.programsObject;
    programsImages = globals.programsImages;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    
    // #########################################
    //        Setup Navigation Drawer
    // #########################################
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Programs";
   
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[object objectForKey:@"programs"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[[object objectForKey:@"programs"] objectAtIndex:section] objectForKey:@"program"] objectForKey:@"start_at"];
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // #########################################
    //        Set Content Based On JSON Data
    // #########################################
    if (indexPath.section < [[object objectForKey:@"programs"] count]) {
        
        id programContent = [[[object objectForKey:@"programs"] objectAtIndex:indexPath.section] objectForKey:@"program"];
        
        // Set Head if category is Resource Talk
        if ([[[programContent objectForKey:@"category"] objectForKey:@"name" ] isEqualToString:@"Resource Talk"]) {
            
            NSDictionary *speaker = [[programContent objectForKey:@"speakers"]objectAtIndex:0];
            NSString *speakerName = [NSString stringWithFormat:@"%@ %@",[speaker objectForKey:@"first_name"],[speaker objectForKey:@"last_name"]];
            NSString *speakerPosition = [speaker objectForKey:@"position"];
            NSString *speakerCompany = [speaker objectForKey:@"company"];
            
            // Set Cell Content
            cell.header.text = [NSString stringWithFormat:@"%@ • %@ at %@", speakerName, speakerPosition, speakerCompany];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[programContent objectForKey:@"title"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[programContent objectForKey:@"description"]];
            
            //SET IMAGEVIEW
            cell.imageView.image =  [programsImages objectAtIndex:indexPath.section];
            
        } else {
           // Set Cell Content
            cell.header.text = @"";
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[programContent objectForKey:@"title"]];
            
            NSMutableString *panelists = [[NSMutableString alloc]initWithString:@""];
            for (NSDictionary *speaker in [programContent objectForKey:@"speakers"]) {
                [panelists appendFormat:@"\n%@ %@ • %@", [speaker objectForKey:@"first_name"], [speaker objectForKey:@"last_name"], [speaker objectForKey:@"company"]];
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ \n%@",[programContent objectForKey:@"description"], panelists];
            
            //SET IMAGEVIEW
            cell.imageView.image =  [programsImages objectAtIndex:indexPath.section];
            
        }
        
        
    }
    
    
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
    float height = 120;
    if (indexPath.section < [[object objectForKey:@"programs"] count]) {
        
        // #########################################
        //        Calculate Heights
        // #########################################
        id programContent = [[[object objectForKey:@"programs"] objectAtIndex:indexPath.section] objectForKey:@"program"];
        
        NSDictionary *speaker = [[programContent objectForKey:@"speakers"]objectAtIndex:0];
        NSString *headerText, *detailTextLabel;
        
            if ([[[programContent objectForKey:@"category"] objectForKey:@"name" ] isEqualToString:@"Resource Talk"]) {
                headerText = [NSString stringWithFormat:@"%@ %@ • %@ at %@", [speaker objectForKey:@"first_name"], [speaker objectForKey:@"last_name"], [speaker objectForKey:@"position"], [speaker objectForKey:@"company"]];
                detailTextLabel = [NSString stringWithFormat:@"%@",[programContent objectForKey:@"description"]];
            } else {
                headerText = @" ";
                NSMutableString *panelists = [[NSMutableString alloc]initWithString:@""];
                for (NSDictionary *speaker in [programContent objectForKey:@"speakers"]) {
                    [panelists appendFormat:@"\n%@ %@ • %@", [speaker objectForKey:@"first_name"],[speaker objectForKey:@"last_name"], [speaker objectForKey:@"company"]];
                    
                }
                detailTextLabel = [NSString stringWithFormat:@"%@ \n%@",[programContent objectForKey:@"description"],panelists];
            }
        NSString *textLabel  = [NSString stringWithFormat:@"%@",[programContent objectForKey:@"title"]];
        
            // Set Cell Content
        
        height = [self calculateLabelHeight: headerText textLabel:textLabel detailTextLabel:detailTextLabel];
        
    }
    return height;
    
}


- (float) calculateLabelHeight: (NSString *)headerText textLabel: (NSString *)textLabelText detailTextLabel: (NSString *) detailTextLabelText {
    
    // #########################################
    //        Calculate HEADER Heights
    // #########################################
    UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    header.text = headerText;
    header.lineBreakMode = NSLineBreakByWordWrapping;
    header.numberOfLines = 0;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: header.attributedText];
    
    // header - Set Font
    [text addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x83ac25) range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12] range:NSMakeRange(0, text.length)];
    [header setAttributedText: text];
    
    // header - Set Frame
    CGRect headerFrame = [header.text boundingRectWithSize:CGSizeMake(header.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : header.font } context:nil];
    header.frame = CGRectMake(header.frame.origin.x, header.frame.origin.y, header.frame.size.width, headerFrame.size.height);
    
    // #########################################
    //        Calculate textLabel Heights
    // #########################################
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    textLabel.text = textLabelText;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    
    NSMutableAttributedString *text1 = [[NSMutableAttributedString alloc] initWithAttributedString: textLabel.attributedText];
    
    // textLabel - Set Font
    [text1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xdb6d2c) range:NSMakeRange(0, text1.length)];
    [text1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:18] range:NSMakeRange(0, text1.length)];
    [textLabel setAttributedText: text1];
    
    // TEXT LABEL - Set Frame
    CGRect textLabelFrame = [textLabel.text boundingRectWithSize:CGSizeMake(textLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : textLabel.font } context:nil];
    
    
    // #########################################
    //        Calculate detailTextLabel Heights
    // #########################################
    UILabel *detailTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 230, 0)];
    detailTextLabel.text = detailTextLabelText;
    detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailTextLabel.numberOfLines = 0;
    
    
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithAttributedString: detailTextLabel.attributedText];
    
    // detailTextLabel - Set Font
    [text2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:12] range:NSMakeRange(0, text2.length)];
    [detailTextLabel setAttributedText: text2];
    
    
    // header - Set Frame
    CGRect detailTextLabelFrame = [detailTextLabel.text boundingRectWithSize:CGSizeMake(detailTextLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : detailTextLabel.font } context:nil];

    return headerFrame.size.height + textLabelFrame.size.height + detailTextLabelFrame.size.height + 20;//100;
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
