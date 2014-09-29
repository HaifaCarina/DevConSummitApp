//
//  CustomTableViewCell.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 9/28/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "CustomTableViewCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


@implementation CustomTableViewCell

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
    
    //SET IMAGE VIEW
    self.imageView.frame = CGRectMake(10,10,60,60);
    self.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.cornerRadius = 5.0;
    self.imageView.layer.masksToBounds = YES;
    
    // SET HEADER LABEL
    self.header.frame = CGRectMake(80, 5, 230, 10);
    self.header.lineBreakMode = NSLineBreakByWordWrapping;
    self.header.numberOfLines = 0;
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.header.attributedText];
    
    // header - Set Font
    [text addAttribute:NSForegroundColorAttributeName
                 value:UIColorFromRGB(0x83ac25)
                 range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-SemiBold" size:12]
                 range:NSMakeRange(0, text.length)];
    [self.header setAttributedText: text];
    
    // header - Set Frame
    CGRect headerFrame = [self.header.text boundingRectWithSize:CGSizeMake(self.header.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.header.font } context:nil];
    self.header.frame = CGRectMake(self.header.frame.origin.x, self.header.frame.origin.y, self.header.frame.size.width, headerFrame.size.height);
    
    
    
    // SET TEXT LABEL
    self.textLabel.frame = CGRectMake(80, 20, 230, 50);
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    
    
    // TEXT LABEL - Set Frame
    CGRect textLabelFrame = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.textLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.textLabel.font } context:nil];
    
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.header.frame.origin.y + self.header.frame.size.height, self.textLabel.frame.size.width, textLabelFrame.size.height);
    //self.textLabel.backgroundColor = [UIColor yellowColor];
    
    // Add a bottomBorder.
  /*  CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.textLabel.frame.size.height + 10 , self.textLabel.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    [self.textLabel.layer addSublayer:bottomBorder];
    */
    
    // TEXT DETAIL LABEL - Set Frame
    self.detailTextLabel.frame = CGRectMake(80, self.textLabel.frame.origin.y + self.textLabel.frame.size.height + 10 , 230, 10);
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
    
    // header - Set Frame
    CGRect detailTextLabelFrame = [self.detailTextLabel.text boundingRectWithSize:CGSizeMake(self.detailTextLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.detailTextLabel.font } context:nil];
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, self.detailTextLabel.frame.size.width, detailTextLabelFrame.size.height);
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
