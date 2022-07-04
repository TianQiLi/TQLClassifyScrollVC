//
//  TQLMixedCollectionViewCell.m
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/11/22.
//

#import "TQLMixedCollectionViewCell.h"
#import "TQLProtocolHeader.h"
@implementation TQLMixedCollectionViewCell
- (NSString *)getCellIdentifiter:(NSIndexPath *)indexPath
{
    return @"TQLMixedCollectionViewCellIdentititer";
}

+ (Class)getCellClassFrom:(NSIndexPath *)indexPath row:(NSInteger)row
{
    return [UITableViewCell class];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellIdentifiter:indexPath] forIndexPath:indexPath];
    SEL sel = @selector(TQL_cellLoadData:indexPath:);
    if ([cell respondsToSelector: sel]) {
        id obj = [self.arrayData objectAtIndex:indexPath.row];
        [cell performSelector:sel withObject:obj withObject:indexPath];
    }
    if (indexPath.row == _currentSelectedIndex_mix) {
        SEL sel = @selector(TQL_cellSelected:indexPath:);
        if ([cell respondsToSelector: sel]) {
            id obj = [self.arrayData objectAtIndex:indexPath.row];
            [cell performSelector:sel withObject:obj withObject:indexPath];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL sel = @selector(TQL_cellHeight:indexPath:);
    Class customClass = [[self class] getCellClassFrom:indexPath row:self.row];
    if ([customClass respondsToSelector: sel]) {
        id obj = [self.arrayData objectAtIndex:indexPath.row];
        id test = [customClass performSelector:sel withObject:obj withObject:indexPath];
        if (test != Nil) {
            NSNumber *temp = test;
            return temp.floatValue;
        }
        
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SEL sel = @selector(TQL_cellSelected:indexPath:);
    if ([cell respondsToSelector: sel]) {
        id obj = [self.arrayData objectAtIndex:indexPath.row];
        [cell performSelector:sel withObject:obj withObject:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SEL sel = @selector(TQL_cellDeSelected:indexPath:);
    if ([cell respondsToSelector: sel]) {
        id obj = [self.arrayData objectAtIndex:indexPath.row];
        [cell performSelector:sel withObject:obj withObject:indexPath];
    }
}


@end
