//
//  NewsTableViewCell.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/5/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "NewsTableViewCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation NewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.header = [[UILabel alloc]init];
        [self addSubview: self.header];
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // #########################################
    //              Set ImageView
    // #########################################
    
    self.imageView.frame = CGRectMake(0,0,self.contentView.frame.size.height,self.contentView.frame.size.height);
    
    // #########################################
    //              Set Header Text
    // #########################################
    self.header.frame = CGRectMake(self.contentView.frame.size.height + 10, 5, 200, 10);
    self.header.lineBreakMode = NSLineBreakByWordWrapping;
    self.header.numberOfLines = 0;
    self.header.textAlignment = NSTextAlignmentCenter;
    self.header.layer.cornerRadius = 3;
    self.header.layer.masksToBounds = YES;
    self.header.textColor = [UIColor whiteColor];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.header.attributedText];
    
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12]
                 range:NSMakeRange(0, text.length)];
    [self.header setAttributedText: text];
    
    // header - Set Frame
    CGRect headerFrame = [self.header.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.header.font } context:nil];
    self.header.frame = CGRectMake(self.header.frame.origin.x, self.header.frame.origin.y, headerFrame.size.width +5 , headerFrame.size.height+ 5);
    
    
    
    // #########################################
    //              Set TextLabel
    // #########################################
    self.textLabel.frame = CGRectMake(self.contentView.frame.size.height + 10, 20, 200, 50);
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    
    NSMutableAttributedString *text1 = [[NSMutableAttributedString alloc] initWithAttributedString: self.textLabel.attributedText];
    
    // textLabel - Set Font
    [text1 addAttribute:NSForegroundColorAttributeName
                 value:UIColorFromRGB(0x83ac25)
                 range:NSMakeRange(0, text1.length)];
    [text1 addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12]
                 range:NSMakeRange(0, text1.length)];
    [self.textLabel setAttributedText: text1];
    
    
    // TEXT LABEL - Set Frame
    CGRect textLabelFrame = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.textLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.textLabel.font } context:nil];
    
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.header.frame.origin.y + self.header.frame.size.height, self.textLabel.frame.size.width, textLabelFrame.size.height);
    
    // #########################################
    //              Set Detail TextLabel
    // #########################################
    self.detailTextLabel.frame = CGRectMake(self.contentView.frame.size.height + 10, self.textLabel.frame.origin.y + self.textLabel.frame.size.height + 8  , 200, 10);
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
    self.detailTextLabel.numberOfLines = 2;
    self.detailTextLabel.bounds = CGRectMake(0, 0, self.detailTextLabel.frame.size.width, 2 * self.detailTextLabel.font.lineHeight);
    
    // header - Set Frame
    //CGRect detailTextLabelFrame = [self.detailTextLabel.text boundingRectWithSize:CGSizeMake(self.detailTextLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.detailTextLabel.font } context:nil];
    //self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, self.detailTextLabel.frame.size.width, detailTextLabelFrame.size.height);
    
}


@end
