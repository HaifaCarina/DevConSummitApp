//
//  MyManager.h
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject <NSURLConnectionDelegate> {
    NSString *someProperty;
    NSDictionary *object;
    
    NSMutableData *speakersData;
    NSURLConnection *speakersConnection;
    NSMutableArray *speakersImages;
    NSDictionary *speakersObject;
    
    NSMutableData *programsData;
    NSURLConnection *programsConnection;
    NSDictionary *programsObject;
    
    NSMutableData *newsData;
    NSURLConnection *newsConnection;
    NSDictionary *newsObject;
    NSMutableArray *newsImages;
    
    
    NSMutableData *sponsorsData;
    NSURLConnection *sponsorsConnection;
    NSDictionary *sponsorsObject;
    NSMutableArray *sponsorsImages;
    int complete;
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain) NSDictionary *speakersObject;
@property (nonatomic, retain) NSMutableArray *speakersImages;
@property (nonatomic, retain) NSDictionary *programsObject;
@property (nonatomic, retain) NSDictionary *newsObject;
@property (nonatomic, retain) NSMutableArray *newsImages;
@property (nonatomic, retain) NSDictionary *sponsorsObject;
@property (nonatomic, retain) NSMutableArray *sponsorsImages;

+ (id)sharedManager;

@end