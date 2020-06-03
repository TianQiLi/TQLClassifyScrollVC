//
//  TQLCollectionViewCell.h
//  
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
 static CGSize TQLScreenBound()
{
    CGFloat widthCell = 0;
    CGFloat heightCell = 0;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat widthSc = 0;
    CGFloat heightSc = 0;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        widthSc = MAX(screenSize.width, screenSize.height);
        heightSc = MIN(screenSize.width, screenSize.height);
    }else if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        widthSc = MIN(screenSize.width, screenSize.height);
        heightSc = MAX(screenSize.width, screenSize.height);
    }else {
        return screenSize;
    }
    return CGSizeMake(widthSc,heightSc);
}
