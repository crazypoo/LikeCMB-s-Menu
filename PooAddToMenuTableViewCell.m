//
//  PooAddToMenuTableViewCell.m
//  Menu
//
//  Created by crazypoo on 14-2-24.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooAddToMenuTableViewCell.h"

@implementation PooAddToMenuTableViewCell
@synthesize dataTypeImageView = _dataTypeImageView;
@synthesize labelName = _labelName;
@synthesize willSelectImage = _willSelectImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _dataTypeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 53, 53)];
        [_dataTypeImageView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_dataTypeImageView];
        
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(63, 0, 100, 60)];
        [_labelName setBackgroundColor:[UIColor clearColor]];
        _labelName.textColor = [UIColor blackColor];
        _labelName.textAlignment = NSTextAlignmentCenter;
        _labelName.font = [UIFont systemFontOfSize:18.0f];
        [self.contentView addSubview:_labelName];
        
        _willSelectImage = [[UIImageView alloc] initWithFrame:CGRectMake(270, 3, 53, 53)];
        [_willSelectImage setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_willSelectImage];
    }
    return self;
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
