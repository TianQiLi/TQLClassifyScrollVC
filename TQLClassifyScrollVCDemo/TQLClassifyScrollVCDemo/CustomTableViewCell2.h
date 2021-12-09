//
//  CustomTableViewCell2.h
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/16.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

+ (NSString *)cellIdentifiter;

+ (CGFloat)cellHeight;
+ (void)registerNibInTableView:(UITableView*)tableView;
@end

NS_ASSUME_NONNULL_END
