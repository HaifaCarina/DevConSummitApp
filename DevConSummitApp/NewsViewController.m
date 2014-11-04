//
//  NewsViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/5/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MyManager.h"
#import "NewsViewController.h"
#import "SWRevealViewController.h"
#import "NewsTableViewCell.h"
#import "NewsContentViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface NewsViewController () {
    NSDictionary *object;
    NSArray *newsImages;
}
@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set global variable to use in this viewcontroller
    MyManager *globals = [MyManager sharedManager];
    globals.someProperty = @"Haifa";
    object = globals.newsObject;
    newsImages = globals.newsImages;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"reveal-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"News";


}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[object objectForKey:@"news"] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // #########################################
    //        Set Content Based On JSON Data
    // #########################################
    if (indexPath.row < [[object objectForKey:@"news"] count]) {
        id newsContent = [[[object objectForKey:@"news"] objectAtIndex:indexPath.row] objectForKey:@"news"];
        
        cell.header.text = [[newsContent objectForKey:@"category"] objectForKey:@"name"];
        cell.imageView.image = [newsImages objectAtIndex:indexPath.row];
        cell.textLabel.text = [newsContent objectForKey:@"title"];
        cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithData: [[newsContent objectForKey:@"html_content"] dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: nil];
        
        // Customize header color per category
        if ([cell.header.text isEqualToString:@"Speakers"]) {
            cell.header.backgroundColor = UIColorFromRGB(0x83ac25);
        } else if ([cell.header.text isEqualToString:@"Promos"]) {
            cell.header.backgroundColor = UIColorFromRGB(0xdb6d2c);
        } else if ([cell.header.text isEqualToString:@"Program"]) {
            cell.header.backgroundColor = UIColorFromRGB(0x6A4FFA);
        } else if ([cell.header.text isEqualToString:@"Miscellaneous"]) {
            cell.header.backgroundColor = UIColorFromRGB(0xe6c630);
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
    
    NewsContentViewController *viewController = [[NewsContentViewController alloc]init];
    viewController.selection = indexPath.row;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
    
}



@end
