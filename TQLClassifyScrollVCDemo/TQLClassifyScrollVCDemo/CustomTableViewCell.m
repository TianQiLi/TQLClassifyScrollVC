//
//  CustomTableViewCell.m
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/16.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
+ (CGFloat)cellHeight{
    return  94;
}

- (NSString *)reuseIdentifier{
    return [[self class]cellIdentifiter];
}

+ (NSString *)cellIdentifiter{
    return NSStringFromClass([self class]);
}

+ (void)registerNibInTableView:(UITableView*)tableView{
    [tableView registerNib:[UINib nibWithNibName:[[self class]cellIdentifiter] bundle:nil] forCellReuseIdentifier:[[self class]cellIdentifiter]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
