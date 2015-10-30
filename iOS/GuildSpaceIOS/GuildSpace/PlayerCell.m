//
//  PlayerCell.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/3/19.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "PlayerCell.h"

@implementation PlayerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    
}

@end
