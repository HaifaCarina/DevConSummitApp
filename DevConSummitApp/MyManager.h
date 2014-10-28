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
    NSMutableData *programsData;
    NSURLConnection *programsConnection;
    NSMutableData *newsData;
    NSURLConnection *newsConnection;
    NSMutableArray *newsImages;
    NSMutableData *sponsorsData;
    NSURLConnection *sponsorsConnection;
    NSDictionary *speakersObject;
    NSDictionary *programsObject;
    NSDictionary *newsObject;
    NSDictionary *sponsorsObject;
    int complete;
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain) NSDictionary *speakersObject;
@property (nonatomic, retain) NSMutableArray *speakersImages;
@property (nonatomic, retain) NSDictionary *programsObject;
@property (nonatomic, retain) NSDictionary *newsObject;
@property (nonatomic, retain) NSMutableArray *newsImages;
@property (nonatomic, retain) NSDictionary *sponsorsObject;

+ (id)sharedManager;

@end