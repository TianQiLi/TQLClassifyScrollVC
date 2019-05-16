//
//  CustomTableViewCell.h
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/16.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
+ (NSString *)cellIdentifiter;

+ (CGFloat)cellHeight;
+ (void)registerNibInTableView:(UITableView*)tableView;
@end

NS_ASSUME_NONNULL_END
