//
//  EditMyProfileViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/7/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "EditMyProfileViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface EditMyProfileViewController ()
@property (nonatomic, strong) UITextField *positionField;
@property (nonatomic, strong) UITextField *companyField;
@property (nonatomic, strong) UITextField *locationField;
@property (nonatomic, strong) UITextView *aboutField;
@property (nonatomic, strong) UITextField *specialtyField;
@property (nonatomic, strong) UITextView *technologiesField;
@property (nonatomic, strong) UITextField *websiteField;
@property (nonatomic, strong) UITextField *twitterField;
@property (nonatomic, strong) UITextField *facebookField;

@end

@implementation EditMyProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Edit My Profile";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x83ac25);
    self.tableView.backgroundColor = UIColorFromRGB(0xfbfaf7);
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSString *text = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch ( indexPath.row )
    {
        case 0: {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 00, 90, 90)];
            
            imageView.image = [UIImage imageNamed:@"haifa.jpg"];
            imageView.center = CGPointMake(cell.contentView.frame.size.width/2, cell.contentView.center.y + (cell.contentView.center.y * 1.50));
            imageView.backgroundColor = [UIColor clearColor];
            imageView.layer.cornerRadius = 5.0;
            imageView.layer.masksToBounds = YES;
            
            [cell.contentView addSubview:imageView];
            
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
            name.text = @"HAIFA CARINA BALUYOS";
            name.center = CGPointMake(cell.contentView.frame.size.width/2, cell.contentView.center.y + (cell.contentView.center.y * 4.50) );
            name.lineBreakMode = NSLineBreakByWordWrapping;
            name.numberOfLines = 0;
            name.textAlignment = NSTextAlignmentCenter;
            name.textColor = UIColorFromRGB(0x83ac25);
            name.font = [UIFont fontWithName:@"SourceSansPro-SemiBold" size:12];
            [cell.contentView addSubview:name];
            
            // Name - Resize Frame
            CGRect nameFrame = [name.text boundingRectWithSize:CGSizeMake(name.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : name.font } context:nil];
            name.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y, name.frame.size.width, nameFrame.size.height);
            return cell;
            break;
        }
        case 1: {
            text = @"User Information";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 2: {
            self.positionField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.positionField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.positionField.placeholder = @"Company Role/Position";
            [self.positionField setFont:[UIFont systemFontOfSize:12]];
            self.positionField.delegate = self;
            [cell.contentView addSubview:self.positionField];
            return cell;
            break;
        }
        case 3: {
            self.companyField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.companyField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.companyField.placeholder = @"Company Name";
            [self.companyField setFont:[UIFont systemFontOfSize:12]];
            self.companyField.delegate = self;
            [cell.contentView addSubview:self.companyField];
            return cell;
            break;
        }
        case 4: {
            self.locationField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.locationField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.locationField.placeholder = @"Location";
            [self.locationField setFont:[UIFont systemFontOfSize:12]];
            self.locationField.delegate = self;
            [cell.contentView addSubview:self.locationField];
            return cell;
            break;
        }
        case 5: {
            text = @"About Me";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 6: {
            self.aboutField = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, cell.contentView.frame.size.width-35, 80 )];
            [self.aboutField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [self.aboutField setFont:[UIFont systemFontOfSize:12]];
            self.aboutField.delegate = self;
            self.aboutField.text = @"Enter short description of yourself";
            self.aboutField.textColor = [UIColor lightGrayColor];
            self.aboutField.tag = 1;
            [cell.contentView addSubview:self.aboutField];
            return cell;
            break;
        }
        case 7: {
            text = @"Technology Stack";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 8: {
            self.specialtyField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.specialtyField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.specialtyField.placeholder = @"One Technology Specialty (Ex. Android)";
            [self.specialtyField setFont:[UIFont systemFontOfSize:12]];
            self.specialtyField.delegate = self;
            [cell.contentView addSubview:self.specialtyField];
            return cell;
            break;
        }
        case 9: {
            self.technologiesField = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, cell.contentView.frame.size.width-35, 80 )];
            [self.technologiesField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [self.technologiesField setFont:[UIFont systemFontOfSize:12]];
            self.technologiesField.delegate = self;
            self.technologiesField.text = @"Enter list of development technologies used (Ex. JavaScript, PHP, MySQL)";
            self.technologiesField.textColor = [UIColor lightGrayColor];
            self.technologiesField.tag = 2;
            [cell.contentView addSubview:self.technologiesField];
            return cell;
            break;
            
        }
        case 10: {
            text = @"Social Media Links";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 11: {
            self.websiteField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.websiteField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.websiteField.placeholder = @"http://yourdomainname.com";
            [self.websiteField setFont:[UIFont systemFontOfSize:12]];
            self.websiteField.delegate = self;
            [cell.contentView addSubview:self.websiteField];
            
            // Website Icon
            UIImageView *websiteLogo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"website-icon.png"]];
            websiteLogo.frame = CGRectMake(0, 0, 30, 30);
            self.websiteField.leftViewMode = UITextFieldViewModeAlways;
            self.websiteField.leftView = websiteLogo;
            return cell;
            break;
        }
        case 12: {
            self.twitterField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.twitterField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.twitterField.placeholder = @"@username";
            [self.twitterField setFont:[UIFont systemFontOfSize:12]];
            self.twitterField.delegate = self;
            [cell.contentView addSubview:self.twitterField];
            
            // Twitter Icon
            UIImageView *twitterLogo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"twitter-icon.png"]];
            twitterLogo.frame = CGRectMake(0, 0, 30, 30);
            self.twitterField.leftViewMode = UITextFieldViewModeAlways;
            self.twitterField.leftView = twitterLogo;
            
            return cell;
            break;
        }
        case 13: {
            
            
            self.facebookField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, 30 )];
            [self.facebookField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.facebookField.placeholder = @"/username or Facebook ID";
            [self.facebookField setFont:[UIFont systemFontOfSize:12]];
            self.facebookField.delegate = self;
            [cell.contentView addSubview:self.facebookField];
            
            // Facebook Icon
            UIImageView *facebookLogo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"facebook-icon.png"]];
            facebookLogo.frame = CGRectMake(0, 0, 30, 30);
            self.facebookField.leftViewMode = UITextFieldViewModeAlways;
            self.facebookField.leftView = facebookLogo;

            
            return cell;
            break;
        }
            
    }
    
    cell.textLabel.text = text;
    cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
    
    
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 140;
    } else if (indexPath.row == 6) {
        return 80;
    } else if (indexPath.row == 9) {
        return 80;
    } else {
        return 30;
    }
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 1 || textView.tag == 2) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1) {
        textView.text = @"Enter short description of yourself";
        textView.textColor = [UIColor lightGrayColor]; //optional
    } else if (textView.tag == 2) {
        textView.text = @"Enter list of development technologies used (Ex. JavaScript, PHP, MySQL)";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

@end
