//
//  TQLMixedCollectionViewCell.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/11/22.
//

#import "TQLViewContorller.h"

@interface TQLMixedCollectionViewCell : TQLViewContorller
/** currentSelectedIndex:默认0 */
@property (nonatomic, assign) NSInteger currentSelectedIndex_mix;

- (NSString *)getCellIdentifiter:(NSIndexPath *)indexPath;

+ (Class)getCellClassFrom:(NSIndexPath *)indexPath row:(NSInteger)row;
@end
