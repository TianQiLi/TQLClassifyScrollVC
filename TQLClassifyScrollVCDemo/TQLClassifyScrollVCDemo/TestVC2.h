//
//  TestVC2.h
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/14.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "TQLViewContorller.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestVC2 : TQLViewContorller
+ (NSString *)cellIdentifiter;

+ (void)registerNibInTableView:(UITableView*)tableView;
@end

NS_ASSUME_NONNULL_END
