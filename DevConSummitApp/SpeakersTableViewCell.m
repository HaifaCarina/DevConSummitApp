//
//  SpeakersTableViewCell.m
//  DevConSummitApp
//
//  Created by Haifa Carina Baluyos on 10/2/14.
//  Copyright (c) 2014 HaifaCarina. All rights reserved.
//

#import "SpeakersTableViewCell.h"
#import "UIImage+StackBlur.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation SpeakersTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.header = [[UILabel alloc]init];
        [self addSubview: self.header];
        
        self.affiliation = [[UILabel alloc]init];
        [self addSubview:self.affiliation];
        
        self.title = [[UILabel alloc]init];
        [self addSubview:self.title];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.backgroundColor = UIColorFromRGB(0x6A4FFA);
    
    
    // #########################################
    // Set Image for cell bottom half background
    // #########################################
    UIImage *image = self.imageView.image;
    
    // Slice image into half
    CGImageRef imageToSplit = image.CGImage;
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(imageToSplit, CGRectMake(0,0,image.size.width, image.size.height/2));
    UIImage *partOfImage = [UIImage imageWithCGImage:partOfImageAsCG];
    
    // Blur image
    UIImage *blurredImage = [partOfImage stackBlur:55];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:blurredImage];
    imageView.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
    
    CALayer *sublayer = [CALayer layer];
    [sublayer setBackgroundColor: UIColorFromRGB(0x6A4FFA).CGColor];
    [sublayer setOpacity:0.4];
    [sublayer setFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
    [imageView.layer addSublayer:sublayer];
    

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.contentView.frame.size.height-3, self.contentView.frame.size.width, 4.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:bottomBorder];
    
    [self.contentView addSubview:imageView];
    [self.contentView sendSubviewToBack:imageView];
    
    // #########################################
    //              Set Disclosure Icon
    // #########################################
    UIImageView *disclosure = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"disclosure-icon.png"]];
    disclosure.frame = CGRectMake(self.contentView.frame.size.width * 0.9, self.contentView.frame.size.height * 0.2, 20, 20);
    [self.contentView addSubview:disclosure];
    
    // #########################################
    //              Set Image View
    // #########################################
    self.imageView.frame = CGRectMake(10,30,60,60);
    self.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.cornerRadius = 5.0;
    self.imageView.layer.masksToBounds = YES;
    
    
    // #########################################
    //              Set Header Text
    // #########################################
    
    self.header.frame = CGRectMake(80, 5, 230, 10);
    self.header.textColor = [UIColor whiteColor];
    //self.header.text = @"Resource Speaker";
    self.header.lineBreakMode = NSLineBreakByWordWrapping;
    self.header.numberOfLines = 0;
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.header.attributedText];
    
    // header - Set Font
    [text addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"PTSerif-Italic" size:10]
                 range:NSMakeRange(0, text.length)];
    [self.header setAttributedText: text];
    
    // header - Set Frame
    CGRect headerFrame = [self.header.text boundingRectWithSize:CGSizeMake(self.header.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.header.font } context:nil];
    self.header.frame = CGRectMake(self.header.frame.origin.x, self.header.frame.origin.y, self.header.frame.size.width, headerFrame.size.height);
    
    
    
    // #########################################
    //              Set Text Label
    // #########################################
    self.textLabel.frame = CGRectMake(80, 20, 230, 50);
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.numberOfLines = 0;
    self.textLabel.text = [self.textLabel.text uppercaseString];
    
    NSMutableAttributedString *textTL = [[NSMutableAttributedString alloc] initWithAttributedString: self.textLabel.attributedText];
    
    // TextLabel - Set Font
    [textTL addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"SourceSansPro-Semibold" size:18]
                   range:NSMakeRange(0, textTL.length)];
    [self.textLabel setAttributedText: textTL];
    
    
    // TEXT LABEL - Set Frame
    CGRect textLabelFrame = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.textLabel.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.textLabel.font } context:nil];
    
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.header.frame.origin.y + self.header.frame.size.height , self.textLabel.frame.size.width, textLabelFrame.size.height);
    
    
    
    // #########################################
    //          Set Affiliation Text
    // #########################################
    
    self.affiliation.frame = CGRectMake(80, 65, 230, 10);
    self.affiliation.textColor = [UIColor whiteColor];
    //self.affiliation.text = @"Software Developer at DevCon";
    self.affiliation.lineBreakMode = NSLineBreakByWordWrapping;
    self.affiliation.numberOfLines = 0;
    
    
    NSMutableAttributedString *textA = [[NSMutableAttributedString alloc] initWithAttributedString: self.affiliation.attributedText];
    
    // affiliation - Set Font
    [textA addAttribute:NSFontAttributeName
                 value:[UIFont fontWithName:@"SourceSansPro-Regular" size:10]
                 range:NSMakeRange(0, textA.length)];
    [self.affiliation setAttributedText: textA];
    
    // affiliation - Set Frame
    CGRect affiliationFrame = [self.affiliation.text boundingRectWithSize:CGSizeMake(self.affiliation.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.affiliation.font } context:nil];
    self.affiliation.frame = CGRectMake(self.affiliation.frame.origin.x, self.textLabel.frame.origin.y + self.textLabel.frame.size.height, self.affiliation.frame.size.width, affiliationFrame.size.height);
    
    // #########################################
    //          Set Title Text
    // #########################################
    
    self.title.frame = CGRectMake(80, 65, 230, 10);
    self.title.textColor = [UIColor whiteColor];
    //self.title.text = @"Trends and Best Practices in Android Development";
    self.title.lineBreakMode = NSLineBreakByWordWrapping;
    self.title.numberOfLines = 0;
    //self.title.backgroundColor = [UIColor yellowColor];
    
    
    NSMutableAttributedString *textTitle = [[NSMutableAttributedString alloc] initWithAttributedString: self.title.attributedText];
    
    // title - Set Font
    [textTitle addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"SourceSansPro-Regular" size:16]
                  range:NSMakeRange(0, textTitle.length)];
    [self.title setAttributedText: textTitle];
    
    // title - Set Frame
    CGRect titleFrame = [self.title.text boundingRectWithSize:CGSizeMake(self.title.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.title.font } context:nil];
    self.title.frame = CGRectMake(self.title.frame.origin.x, self.affiliation.frame.origin.y + self.affiliation.frame.size.height + 10, self.title.frame.size.width, titleFrame.size.height);
    
    
}

@end
