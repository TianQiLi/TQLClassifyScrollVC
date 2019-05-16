//
//  CustomTableViewCell2.m
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/16.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "CustomTableViewCell2.h"

@implementation CustomTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight{
    return 118;
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

@end
