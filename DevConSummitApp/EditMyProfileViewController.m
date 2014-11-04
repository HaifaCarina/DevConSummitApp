//
//  EditMyProfileViewController.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/7/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "MainViewController.h"
#import "EditMyProfileViewController.h"
#import "CustomTableViewCell.h"
#import "KeychainItemWrapper.h"
#import "MyManager.h"
#import "SWRevealViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface EditMyProfileViewController () <NSURLConnectionDataDelegate> {
    CGFloat defaultFontSize;
    CGFloat defaultHeight;
    UIActionSheet *actionSheet;
    UIImagePickerController *picker;
    UIImageView *profileImage;
    NSMutableData *profileData;
    NSURLConnection *profileConnection;
    NSMutableData *postData;
    NSDictionary *object;
    NSDictionary *newObject;
    MyManager *globals;
}
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

- (void) handleBack: (id) sender {
    NSLog(@"handling back");
    MainViewController *frontViewController = [[MainViewController alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.navigationController pushViewController:frontViewController animated:YES];
    });
    
  /*
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFromRight; //kCATransitionFade kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:frontViewController animated:YES];
    */
    
    //UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    //[self.navigationController popViewController:frontViewController animated:YES];
    //[self.navigationController popToViewController:frontViewController animated:YES];
    
    //SWRevealViewController *revealController = self.revealViewController;
    
    //[revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    //[revealController pushFrontViewController:frontViewController animated:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set global variable to use in this viewcontroller
    globals = [MyManager sharedManager];
    object = globals.profileObject;
    
    self.navigationItem.title = @"Edit My Profile";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColorFromRGB(0x83ac25)};
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x83ac25);
    self.tableView.backgroundColor = [UIColor whiteColor]; //UIColorFromRGB(0xfbfaf7);
   
    
    // change the back button to cancel and add an event handler
   /* UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"My Profile"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    */
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(sendAPIRequest)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    defaultFontSize = 14.0f;
    defaultHeight = 40.0f;
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take photo", @"Choose existing photo", nil];
    
    picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing=TRUE;
    picker.delegate = self;
    
    profileImage = [[UIImageView alloc]init];
    profileImage.image = globals.profileImage;//[UIImage imageNamed:@"haifa.jpg"];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 17;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"data loaded");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    NSString *text = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [cell.textLabel.font fontWithSize:defaultFontSize];
    
    NSDictionary *profileContent = [[object objectForKey:@"profile"] objectForKey:@"user"];
    
    switch ( indexPath.row )
    {
        case 0: {
            text = @"HAIFA CARINA BALUYOS";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont fontWithName:@"SourceSansPro-SemiBold" size:defaultFontSize];
            break;
        }
        case 1: {
            text = @"Photo";
            cell.imageView.image = profileImage.image;
            cell.imageView.layer.cornerRadius = 5.0;
            cell.imageView.layer.masksToBounds = YES;
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 2: {
            text = @"User Information";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 3: {
            self.positionField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.positionField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.positionField.placeholder = @"Company Role/Position";
            if(![[profileContent objectForKey:@"position"] isEqual:[NSNull null]]) {
                self.positionField.text = [profileContent objectForKey:@"position"];
            }
            [self.positionField setFont: [UIFont systemFontOfSize: defaultFontSize]];
            self.positionField.delegate = self;
            [cell.contentView addSubview:self.positionField];
            return cell;
            break;
        }
        case 4: {
            self.companyField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.companyField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.companyField.placeholder = @"Company Name";
            if(![[profileContent objectForKey:@"company"] isEqual:[NSNull null]]) {
                self.companyField.text = [profileContent objectForKey:@"company"];
            }
            [self.companyField setFont:[UIFont systemFontOfSize:defaultFontSize]];
            self.companyField.delegate = self;
            [cell.contentView addSubview:self.companyField];
            return cell;
            break;
        }
        case 5: {
            self.locationField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.locationField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.locationField.placeholder = @"Location";
            if(![[profileContent objectForKey:@"location"] isEqual:[NSNull null]]) {
                    self.locationField.text = [profileContent objectForKey:@"location"];
            }
            
            [self.locationField setFont:[UIFont systemFontOfSize:defaultFontSize]];
            self.locationField.delegate = self;
            [cell.contentView addSubview:self.locationField];
            return cell;
            break;
        }
        case 6: {
            text = @"About Me";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 7: {
            self.aboutField = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, cell.contentView.frame.size.width-35, 80 )];
            [self.aboutField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [self.aboutField setFont:[UIFont systemFontOfSize:defaultFontSize]];
            self.aboutField.delegate = self;
            if(![[profileContent objectForKey:@"description"] isEqual:[NSNull null]]) {
                self.aboutField.text =  [profileContent objectForKey:@"description"];
            }
            
            
            //self.aboutField.textColor = [UIColor lightGrayColor];
            self.aboutField.tag = 1;
            [cell.contentView addSubview:self.aboutField];
            return cell;
            break;
        }
        case 8: {
            text = @"Technology Stack";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 9: {
            self.specialtyField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.specialtyField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.specialtyField.placeholder = @"One Technology Specialty (Ex. Android)";
            /*
             //TEMPORARILY DISABLED
            if(![[[profileContent objectForKey:@"primary_technology"]objectForKey:@"name"] isEqual:[NSNull null]]) {
                    self.specialtyField.text = [[profileContent objectForKey:@"primary_technology"]objectForKey:@"name"];
            }
            */
            [self.specialtyField setEnabled:NO];
            [self.specialtyField setFont:[UIFont systemFontOfSize:defaultFontSize]];
            self.specialtyField.delegate = self;
            [cell.contentView addSubview:self.specialtyField];
            return cell;
            break;
        }
        case 10: {
            self.technologiesField = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, cell.contentView.frame.size.width-35, 80 )];
            [self.technologiesField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [self.technologiesField setFont:[UIFont systemFontOfSize:defaultFontSize]];
            self.technologiesField.delegate = self;
            //TEMPORARILY DISABLED
            [self.technologiesField setEditable:NO];
            //self.technologiesField.text = @"Enter list of development technologies used (Ex. JavaScript, PHP, MySQL)";
            self.technologiesField.textColor = [UIColor lightGrayColor];
            self.technologiesField.tag = 2;
            [cell.contentView addSubview:self.technologiesField];
            return cell;
            break;
            
        }
        case 11: {
            text = @"Social Media Links";
            cell.textLabel.textColor = UIColorFromRGB(0x83ac25);
            break;
            
        }
        case 12: {
            self.websiteField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.websiteField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.websiteField.placeholder = @"http://yourdomainname.com";
            if(![[profileContent objectForKey:@"website"] isEqual:[NSNull null]]) {
                self.websiteField.text = [profileContent objectForKey:@"website"];
            }
            [self.websiteField setFont:[UIFont systemFontOfSize:defaultFontSize]];
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
        case 13: {
            self.twitterField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.twitterField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.twitterField.placeholder = @"@username";
            if(![[profileContent objectForKey:@"twitter_handle"] isEqual:[NSNull null]])  {
                self.twitterField.text = [profileContent objectForKey:@"twitter_handle"];
            }
            [self.twitterField setFont:[UIFont systemFontOfSize:defaultFontSize]];
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
        case 14: {
            
            
            self.facebookField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, cell.contentView.frame.size.width-35, defaultHeight )];
            [self.facebookField setAutocorrectionType:UITextAutocorrectionTypeNo];
            self.facebookField.placeholder = @"/username or Facebook ID";
            [self.facebookField setFont:[UIFont systemFontOfSize:defaultFontSize]];
            self.facebookField.delegate = self;
            self.facebookField.text = @"";
            if(![[profileContent objectForKey:@"facebook_url"] isEqual:[NSNull null]])  {
                self.facebookField.text = [profileContent objectForKey:@"facebook_url"];
            }
            [cell.contentView addSubview:self.facebookField];
            
            // Facebook Icon
            UIImageView *facebookLogo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"facebook-icon.png"]];
            facebookLogo.frame = CGRectMake(0, 0, 30, 30);
            self.facebookField.leftViewMode = UITextFieldViewModeAlways;
            self.facebookField.leftView = facebookLogo;

            
            return cell;
            break;
        }
        case 15: {
            return cell;
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
    if (indexPath.row == 1 ) {
        [actionSheet showInView:self.view];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return defaultHeight;
    } else if (indexPath.row == 1) {
        return 50;
    } else if (indexPath.row == 7) {
        return 80;
    } else if (indexPath.row == 10) {
        return 80;
    } else {
        return defaultHeight;
    }
    
}

- (void) sendAPIRequest {
    NSLog(@"send API Request");
    /*
    //NSString *token = [[NSString alloc] initWithData:[loginKeychain objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding];
    NSString *post = [NSString stringWithFormat:@"authentication_token=%@", @"QqYas3TNzFQRi6wsXfMm"]; //token];
    NSMutableDictionary *dataToSubmit = [[NSMutableDictionary alloc]init];
    [dataToSubmit setValue:self.positionField.text forKey:@"position"];
    //[dataToSubmit setValue:self.companyField.text forKey:@"company"];
    //[dataToSubmit setValue:self.locationField.text forKey:@"location"];
    
    for (id item in dataToSubmit) {
        post = [post stringByAppendingString: [NSString stringWithFormat:@"&%@=%@",item,[dataToSubmit objectForKey: item]]];
    }
    
    NSLog(@"IMAGE: %@", profileImage.image);
    NSLog(@"post: %@", post);
    
    postData = [[NSMutableData alloc]init];
    [postData appendData:[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSLog(@"POSTDATA %@", postData);
    //send profile request
    //profileData = [[NSMutableData alloc]init];
  / *  NSMutableURLRequest *profileRequest = [[NSMutableURLRequest alloc] init] ;
    [profileRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.devcon.ph/api/v1/profile"]]];
    [profileRequest setHTTPMethod:@"PUT"];
    [profileRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [profileRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [profileRequest setHTTPBody:postData];
    profileConnection = [[NSURLConnection alloc]initWithRequest:profileRequest delegate:self];
    */
    
    // ABOVE WORKS FINE FOR TEXTS ONLY, TRIAL AND ERROR FOR IMAGES BELOW
 
    
    
    KeychainItemWrapper *loginKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    NSString *token = [[NSString alloc] initWithData:[loginKeychain objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding];
    
    profileData = [[NSMutableData alloc]init];
    
    NSDictionary *params = @{
                             @"authentication_token": token, //@"QqYas3TNzFQRi6wsXfMm",
                             @"location": self.locationField.text,
                             @"position": self.positionField.text,
                             @"company": self.companyField.text,
                             @"description": self.aboutField.text,
                             //@"primary_technology": self.specialtyField.text,
                             //@"technologies": @"",
                             @"twitter_handle": self.twitterField.text,
                             @"facebook_url": self.facebookField.text,
                             @"website": self.websiteField.text};
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.devcon.ph/api/v1/profile"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"PUT"];
    
    NSString *boundary = @"0xKhTmLbOuNdArY";
    NSString *kNewLine = @"\r\n";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    // Add the parameters from the dictionary to the request body
    for (NSString *name in params.allKeys) {
        NSData *value = [[NSString stringWithFormat:@"%@", params[name]] dataUsingEncoding:NSUTF8StringEncoding];
        
        [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", name] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:value];
        [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Done with %@", name);
    }
    

    // Set-up image to upload
 /*   NSData *imageData = UIImagePNGRepresentation(profileImage.image);
    
    // UPLOAD IMAGE FIRST TRY
    [body appendData:[[NSString stringWithFormat:@"--%@%@", boundary, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"myprofile.png\"%@", @"image", kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
  
    
    // UPLOAD IMAGE SECOND TRY
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo_url\"; filename=\"myprofile.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@%@", kNewLine, kNewLine] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[kNewLine dataUsingEncoding:NSUTF8StringEncoding]];
  */
    
    // Add the terminating boundary marker to signal that we're at the end of the request body
    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    profileConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
  
    
    
}

#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    [profileData appendData:data];
    NSLog(@"Yup. profileConnection! Did receive data");
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //This method , you can use to receive the error report in case of connection is not made to server.
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *error = nil;
    //NSDictionary *object ;
    if (profileData != nil) {
        newObject = [NSJSONSerialization JSONObjectWithData:profileData options:0 error:&error];
    }
    
    
    //NSDictionary *objectTmp = [NSJSONSerialization JSONObjectWithData:speakersData options:0 error:&error];
    
    if(error) { NSLog(@"json was malformed: %@", error); }
    
    NSLog(@"OBJECT %@", newObject);
    globals.profileObject = newObject;
    NSLog(@"NEW OBJECT %@", globals.profileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 1 || textView.tag == 2) {
        textView.text = @"";
       // textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1) {
        //TEMPORARILY DISABLED
        //textView.text = @"Enter short description of yourself";
        //textView.textColor = [UIColor lightGrayColor]; //optional
    } else if (textView.tag == 2) {
        //TEMPORARILY DISABLED
        //textView.text = @"Enter list of development technologies used (Ex. JavaScript, PHP, MySQL)";
       // textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
#pragma mark - UIImagePickerController Delegate
//Tells the delegate that the user picked a still image or movie.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo");
    
    UIImage *pickerImage=[info objectForKey:UIImagePickerControllerEditedImage];
    profileImage.image=pickerImage;
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Tells the delegate that the user cancelled the pick operation.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
