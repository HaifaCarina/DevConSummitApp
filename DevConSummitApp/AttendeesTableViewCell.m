//
//  AttendeesTableViewCell.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/6/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "AttendeesTableViewCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
@implementation AttendeesTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = UIColorFromRGB(0xe6c630);
    // #########################################
    //              Set ImageView
    // #########################################
    
    self.imageView.frame = CGRectMake(10,10,60,60);
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.cornerRadius = 5.0;
    self.imageView.layer.masksToBounds = YES;
    
    // #########################################
    //              Add Bottom Border
    // #########################################
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.contentView.frame.size.height-3, self.contentView.frame.size.width, 4.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:bottomBorder];
    
    // #########################################
    //              Set Disclosure Icon
    // #########################################
    UIImageView *disclosure = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"disclosure-icon.png"]];
    disclosure.frame = CGRectMake(self.contentView.frame.size.width * 0.92, self.contentView.frame.size.height/2 - 10, 20, 20);
    [self.contentView addSubview:disclosure];
    

    
    // #########################################
    //              Set TextLabel
    // #########################################
    self.textLabel.frame = CGRectMake(80, 20, 210, 50);
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    self.textLabel.text = [self.textLabel.text uppercaseString];
    self.textLabel.textColor = [UIColor whiteColor];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.textLabel.attributedText];
    
    // textLabel - Set Font
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-Semibold" size:20]
                 range:NSMakeRange(0, text.length)];
    [self.textLabel setAttributedText: text];
    
    // TEXT LABEL - Set Frame
    CGRect textLabelFrame = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.textLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.textLabel.font } context:nil];
    
    self.textLabel.frame = CGRectMake(80, 10, self.textLabel.frame.size.width, textLabelFrame.size.height);
    
    
    // #########################################
    //              Set Detail TextLabel
    // #########################################
    self.detailTextLabel.frame = CGRectMake(80, self.textLabel.frame.origin.y + self.textLabel.frame.size.height  , 230, 10);
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.textColor = [UIColor whiteColor];
    
    // header - Set Frame
    CGRect detailTextLabelFrame = [self.detailTextLabel.text boundingRectWithSize:CGSizeMake(self.detailTextLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.detailTextLabel.font } context:nil];
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, self.detailTextLabel.frame.size.width, detailTextLabelFrame.size.height);
    
}


@end
