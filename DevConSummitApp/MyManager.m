//
//  MyManager.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//
#import "AppDelegate.h"
#import "MainViewController.h"
#import "MyManager.h"
#import "KeychainItemWrapper.h"
@implementation MyManager

@synthesize someProperty, profileObject, profileImage, speakersObject, speakersImages, programsObject, programsImages, newsObject, newsImages, sponsorsObject, sponsorsImages;

#pragma mark Singleton Methods
static MyManager *sharedMyManager = nil;

+ (id)sharedManager {
    //static MyManager *sharedMyManager = nil;
   /* static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    }); */
    return sharedMyManager;
}
+ (void) startManager {
    //static MyManager *sharedMyManager =  [[self alloc] init];
    
    if (self == [MyManager class]) {
        sharedMyManager = [[self alloc] init];
    }
    //return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
        [self sendAPIRequests];
    }
    return self;
}

- (void) sendAPIRequests {
    // #########################################
    //              Send API Request
    // #########################################
    KeychainItemWrapper *loginKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"LoginData" accessGroup:nil];
    NSLog(@"MAINVIEW CREDS %@,%@", [loginKeychain objectForKey:(__bridge id)kSecAttrAccount], [[NSString alloc] initWithData:[loginKeychain objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding]);
    
    
    NSString *token = [[NSString alloc] initWithData:[loginKeychain objectForKey:(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding];
    NSString *post = [NSString stringWithFormat:@"authentication_token=%@",token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    //send profile request
    profileData = [[NSMutableData alloc]init];
    NSMutableURLRequest *profileRequest = [[NSMutableURLRequest alloc] init] ;
    [profileRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.devcon.ph/api/v1/profile"]]];
    [profileRequest setHTTPMethod:@"POST"];
    [profileRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [profileRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [profileRequest setHTTPBody:postData];
    profileConnection = [[NSURLConnection alloc]initWithRequest:profileRequest delegate:self];
    
    //send speaker request
    speakersImages = [[NSMutableArray alloc]init];
    speakersData = [[NSMutableData alloc]init];
    NSMutableURLRequest *speakersRequest = [[NSMutableURLRequest alloc] init] ;
    [speakersRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.devcon.ph/api/v1/speakers"]]];
    [speakersRequest setHTTPMethod:@"POST"];
    [speakersRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [speakersRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [speakersRequest setHTTPBody:postData];
    speakersConnection = [[NSURLConnection alloc]initWithRequest:speakersRequest delegate:self];
    
    //send programs request
    programsImages = [[NSMutableArray alloc]init];
    programsData = [[NSMutableData alloc]init];
    NSMutableURLRequest *programsRequest = [[NSMutableURLRequest alloc] init] ;
    [programsRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.devcon.ph/api/v1/programs"]]];
    [programsRequest setHTTPMethod:@"POST"];
    [programsRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [programsRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [programsRequest setHTTPBody:postData];
    programsConnection = [[NSURLConnection alloc]initWithRequest:programsRequest delegate:self];

    //send news request
    newsImages = [[NSMutableArray alloc]init];
    newsData = [[NSMutableData alloc]init];
    NSMutableURLRequest *newsRequest = [[NSMutableURLRequest alloc] init] ;
    [newsRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.devcon.ph/api/v1/news"]]];
    [newsRequest setHTTPMethod:@"GET"];
    //[newsRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[newsRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[newsRequest setHTTPBody:postData];
    newsConnection = [[NSURLConnection alloc]initWithRequest:newsRequest delegate:self];
    

    //send sponsors request
    /*sponsorsData = [[NSMutableData alloc]init];
    NSMutableURLRequest *sponsorsRequest = [[NSMutableURLRequest alloc] init] ;
    [sponsorsRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.devcon.ph/api/v1/sponsors"]]];
    [sponsorsRequest setHTTPMethod:@"POST"];
    [sponsorsRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [sponsorsRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [sponsorsRequest setHTTPBody:postData];
    sponsorsConnection = [[NSURLConnection alloc]initWithRequest:sponsorsRequest delegate:self];
    */
    complete = 0;
    
}

#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    if (connection == profileConnection) {
        [profileData appendData:data];
        NSLog(@"Yup. profileConnection! Did receive data");
    } else if (connection == speakersConnection) {
        [speakersData appendData:data];
        NSLog(@"Yup. spekaersConnection! Did receive data");
    } else if (connection == programsConnection) {
        [programsData appendData:data];
        NSLog(@"Yup. programsConnection! Did receive data");
    } else if (connection == newsConnection) {
        [newsData appendData:data];
        NSLog(@"Yup. newsConnection! Did receive data");
    } else if (connection == sponsorsConnection) {
        [sponsorsData appendData:data];
        NSLog(@"Yup. sponsorsConnection! Did receive data");
    }
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //This method , you can use to receive the error report in case of connection is not made to server.
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *error = nil;
    object = [NSJSONSerialization JSONObjectWithData:speakersData options:0 error:&error];
    
    //NSDictionary *objectTmp = [NSJSONSerialization JSONObjectWithData:speakersData options:0 error:&error];
    
    if(error) { NSLog(@"json was malformed: %@", error); }
    //NSLog(@"speakersData: %@", objectTmp);
    //NSLog(@"count: %d", [[object objectForKey:@"speakers"] count]);
    
    if (connection == profileConnection) {
        profileObject = [NSJSONSerialization JSONObjectWithData:profileData options:0 error:&error];
        complete++;
        NSLog(@"Yup. spekaersConnection! COMPLETE! %@", profileObject);
    } else if (connection == speakersConnection) {
        speakersObject = [NSJSONSerialization JSONObjectWithData:speakersData options:0 error:&error];
                complete++;
        NSLog(@"Yup. spekaersConnection! COMPLETE!");
    } else if (connection == programsConnection) {
        programsObject = [NSJSONSerialization JSONObjectWithData:programsData options:0 error:&error];
        complete++;
        NSLog(@"Yup. programsConnection! COMPLETE!");
    } else if (connection == newsConnection) {
        newsObject = [NSJSONSerialization JSONObjectWithData:newsData options:0 error:&error];
        complete++;
        NSLog(@"Yup. newsConnection! COMPLETE!");
    } else if (connection == sponsorsConnection) {
        sponsorsObject = [NSJSONSerialization JSONObjectWithData:sponsorsData options:0 error:&error];
        complete++;
        NSLog(@"Yup. sponsorsConnection! COMPLETE!");
    }
    
    NSLog(@"TOTAL: %d", complete);
    if (complete == 4) {
        [self getImages];
    }
    
}

- (void) getImages {
    
    // load profile image
    NSDictionary *profileContent = [profileObject objectForKey:@"profile"];
    NSURL *profileUrl = [NSURL URLWithString: [[profileContent objectForKey:@"user"]objectForKey:@"photo_url"] ];
    NSData *data = [NSData dataWithContentsOfURL:profileUrl];
    if (data) {
        
        profileImage = [UIImage imageWithData:data];
    } else {
        profileImage = [UIImage imageNamed:@"logo-summit-flat.png"];
        
    }
    
    NSLog(@"Add image of %@", [[profileContent objectForKey:@"speaker"]objectForKey:@"first_name"]);
    
    // load speakers images
    for (NSDictionary *speakerContent in [speakersObject objectForKey:@"speakers"]) {
        
        NSURL *url = [NSURL URLWithString: [[speakerContent objectForKey:@"speaker"]objectForKey:@"photo_url"] ];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            [speakersImages addObject:[UIImage imageWithData:data]];
        } else {
            [speakersImages addObject:[UIImage imageNamed:@"logo-summit-flat.png"]];
        }
        
        NSLog(@"Add image of %@", [[speakerContent objectForKey:@"speaker"]objectForKey:@"first_name"]);
    }
    // load news images
    for (NSDictionary *newsContent in [newsObject objectForKey:@"news"]) {
        
        NSURL *url = [NSURL URLWithString: [[newsContent objectForKey:@"news"]objectForKey:@"photo_url"] ];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            [newsImages addObject:[UIImage imageWithData:data]];
        } else {
            [newsImages addObject:[UIImage imageNamed:@"logo-summit-flat.png"]];
        }
        
        NSLog(@"Add image of %@", [[newsContent objectForKey:@"news"]objectForKey:@"title"]);
    }
    
    // load programs images
    for (NSDictionary *programsContent in [programsObject objectForKey:@"programs"] ) {
        
        //Check if resource talk
        if ([[[[programsContent objectForKey:@"program" ] objectForKey:@"category"] objectForKey:@"name" ] isEqualToString:@"Resource Talk"]) {
            
            NSDictionary *speaker = [[[programsContent objectForKey:@"program" ] objectForKey:@"speakers"]objectAtIndex:0];
            
            if ([[speaker objectForKey:@"photo_url"] isEqualToString:@""]) {
                [programsImages addObject:[UIImage imageNamed:@"logo-summit-flat.png"]];
            } else {
                NSURL *url = [NSURL URLWithString:[speaker objectForKey:@"photo_url"] ];
                NSData *data = [NSData dataWithContentsOfURL:url];
                
                if (data) {
                    [programsImages addObject:[UIImage imageWithData:data]];
                } else {
                    [programsImages addObject:[UIImage imageNamed:@"logo-summit-flat.png"]];
                }
            }
        } else {
        // Set-up for Panel Panel
            [programsImages addObject:[UIImage imageNamed:@"logo-summit-flat.png"]];
        }
        NSLog(@"Add image of %@", [[programsContent objectForKey:@"program"]objectForKey:@"title"]);
    }
    
        // load sponsors images
    /*for (NSDictionary *sponsorsContent in [sponsorsObject objectForKey:@"sponsors"]) {
        
        NSURL *url = [NSURL URLWithString: [[sponsorsContent objectForKey:@"sponsor"]objectForKey:@"photo_url"] ];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            [sponsorsImages addObject:[UIImage imageWithData:data]];
        } else {
            [sponsorsImages addObject:[UIImage imageNamed:@"logo-summit-flat.png"]];
        }
        
        NSLog(@"Add image of %@", [[sponsorsContent objectForKey:@"sponsor"]objectForKey:@"name"]);
    }
    */
    
    NSLog(@"done with the images");
    
    // Load MainViewController once all the data is loaded
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MainViewController *viewController = [[MainViewController alloc]init];
    [appDelegate.window setRootViewController:viewController];
    

}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
