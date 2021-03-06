//
//  TQLProtocalHeader.h
//  Pods
//
//  Created by litianqi on 2018/11/22.
//


#import <Foundation/Foundation.h>
#ifndef TQLProtocalHeader_h
#define TQLProtocalHeader_h

@protocol TQLCellDataSourceProtocal<NSObject>
@optional
- (void)TQL_cellSelected:(id)obj indexPath:(NSIndexPath *)indexPath;
- (void)TQL_cellDeSelected:(id)obj indexPath:(NSIndexPath *)indexPath;
- (void)TQL_cellLoadData:(id)obj indexPath:(NSIndexPath *)indexPath;
+ (NSNumber *)TQL_cellHeight:(id)obj indexPath:(NSIndexPath *)indexPath;

@end



#endif /* TQLProtocalHeader_h */
